/*
 -- ============================================================================
 -- FILE NAME	: bus_if.v
 -- DESCRIPTION : bus interface
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** comonn include **********/
`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

/********** cpu and bus include **********/
`include "cpu.h"
`include "bus.h"

/********** module if **********/
module bus_if (
	/********** clk & reset input **********/
	input  wire				   clk,			   //
	input  wire				   reset,		   //
	/********** flow control **********/
	input  wire				   stall,		   // delay signal
	input  wire				   flush,		   // flush signal
	output reg				   busy,		   // bus busy
	/********** CPU  interface **********/
	input  wire [`WordAddrBus] addr,		   // address
	input  wire				   as_,			   // address gating
	input  wire				   rw,			   //  write read flag
	input  wire [`WordDataBus] wr_data,		   // write data
	output reg	[`WordDataBus] rd_data,		   //  read data^
	/********** SPM interface **********/
	input  wire [`WordDataBus] spm_rd_data,	   // spm read data
	output wire [`WordAddrBus] spm_addr,	   // spm address
	output reg				   spm_as_,		   // spm address gating
	output wire				   spm_rw,		   // spm read write flag
	output wire [`WordDataBus] spm_wr_data,	   // spm write data
	/********** bus interface  **********/
	input  wire [`WordDataBus] bus_rd_data,	   // bus read data
	input  wire				   bus_rdy_,	   // bus read ready
	input  wire				   bus_grnt_,	   // bus use agree
	output reg				   bus_req_,	   // bus use request
	output reg	[`WordAddrBus] bus_addr,	   // bus address
	output reg				   bus_as_,		   // bus address gating
	output reg				   bus_rw,		   // bus read write flag
	output reg	[`WordDataBus] bus_wr_data	   // bus write data
);

	/********** internal signals **********/
	reg	 [`BusIfStateBus]	   state;		   // bus interface state
	reg	 [`WordDataBus]		   rd_buf;		   // bus read buffer
	wire [`BusSlaveIndexBus]   s_index;		   // bus slave index

	/********** get bus slave index **********/
	assign s_index	   = addr[`BusSlaveIndexLoc];

	/********** output assign **********/
	assign spm_addr	   = addr;
	assign spm_rw	   = rw;
	assign spm_wr_data = wr_data;

	/********** spm acess control **********/
	always @(*) begin
		/* set default value  */
		rd_data	 = `WORD_DATA_W'h0;
		spm_as_	 = `DISABLE_;
		busy	 = `DISABLE;
		/* bus interface state switch */
		case (state)
			`BUS_IF_STATE_IDLE	 : begin // idle
				/* check flush && as_ */
				if ((flush == `DISABLE) && (as_ == `ENABLE_)) begin
					/* select the access target  */
					if (s_index == `BUS_SLAVE_1) begin // SPM acess ,no need bus cycle
						if (stall == `DISABLE) begin // delay signal check
							spm_as_	 = `ENABLE_;
							if (rw == `READ) begin // spm read
								rd_data	 = spm_rd_data;
							end
						end
					end else begin					   // other slave access ,set busy
						busy	 = `ENABLE;
					end
				end
			end
			`BUS_IF_STATE_REQ	 : begin // bus aribitration request
				busy	 = `ENABLE;
			end
			`BUS_IF_STATE_ACCESS : begin // bus access stage
				/* wait for ready sigal  */
				if (bus_rdy_ == `ENABLE_) begin //
					if (rw == `READ) begin // bus read  reach
						rd_data	 = bus_rd_data;
					end
				end else begin					// ready signal not avavilable
					busy	 = `ENABLE;
				end
			end
			`BUS_IF_STATE_STALL	 : begin //
				if (rw == `READ) begin //
					rd_data	 = rd_buf;
				end
			end
		endcase
	end

   /********** bus interface state control  **********/
   always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* async reset  */
			state		<= #1 `BUS_IF_STATE_IDLE;
			bus_req_	<= #1 `DISABLE_;
			bus_addr	<= #1 `WORD_ADDR_W'h0;
			bus_as_		<= #1 `DISABLE_;
			bus_rw		<= #1 `READ;
			bus_wr_data <= #1 `WORD_DATA_W'h0;
			rd_buf		<= #1 `WORD_DATA_W'h0;
		end else begin
			/* bus interface state */
			case (state)
				`BUS_IF_STATE_IDLE	 : begin //
					/*   */
					if ((flush == `DISABLE) && (as_ == `ENABLE_)) begin
						/*  memory access */
						if (s_index != `BUS_SLAVE_1) begin // access spm
							state		<= #1 `BUS_IF_STATE_REQ;
							bus_req_	<= #1 `ENABLE_;
							bus_addr	<= #1 addr;
							bus_rw		<= #1 rw;
							bus_wr_data <= #1 wr_data;
						end
					end
				end
				`BUS_IF_STATE_REQ	 : begin // �o�X���N�G�X�g
					/* wait for aribitration permit */
					if (bus_grnt_ == `ENABLE_) begin // get bus grant
						state		<= #1 `BUS_IF_STATE_ACCESS;
						bus_as_		<= #1 `ENABLE_;
					end
				end
				`BUS_IF_STATE_ACCESS : begin // �o�X�A�N�Z�X
					/* �A�h���X�X�g���[�u�̃l�Q�[�g */
					bus_as_		<= #1 `DISABLE_;
					/* ���f�B�҂� */
					if (bus_rdy_ == `ENABLE_) begin // ���f�B����
						bus_req_	<= #1 `DISABLE_;
						bus_addr	<= #1 `WORD_ADDR_W'h0;
						bus_rw		<= #1 `READ;
						bus_wr_data <= #1 `WORD_DATA_W'h0;
						/* �ǂݏo���f�[�^�̕ۑ� */
						if (bus_rw == `READ) begin // �ǂݏo���A�N�Z�X
							rd_buf		<= #1 bus_rd_data;
						end
						/* �X�g�[�������̃`�F�b�N */
						if (stall == `ENABLE) begin // �X�g�[������
							state		<= #1 `BUS_IF_STATE_STALL;
						end else begin				// �X�g�[��������
							state		<= #1 `BUS_IF_STATE_IDLE;
						end
					end
				end
				`BUS_IF_STATE_STALL	 : begin // �X�g�[��
					/* �X�g�[�������̃`�F�b�N */
					if (stall == `DISABLE) begin // �X�g�[������
						state		<= #1 `BUS_IF_STATE_IDLE;
					end
				end
			endcase
		end
	end

endmodule
