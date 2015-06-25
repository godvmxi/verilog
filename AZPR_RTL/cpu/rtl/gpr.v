/*
 -- ============================================================================
 -- FILE NAME	: gpr.v
 -- DESCRIPTION : general register ,include two read port and one write port
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

/********** cpu include  **********/
`include "cpu.h"

/********** module define **********/
module gpr (
	/********** clk & reset**********/
	input  wire				   clk,				   //
	input  wire				   reset,			   //
	/********** read 0 **********/
	input  wire [`RegAddrBus]  rd_addr_0,		   // address
	output wire [`WordDataBus] rd_data_0,		   // data
	/********** read 1 **********/
	input  wire [`RegAddrBus]  rd_addr_1,		   //
	output wire [`WordDataBus] rd_data_1,		   //
	/********** write**********/
	input  wire				   we_,				   //
	input  wire [`RegAddrBus]  wr_addr,			   // address
	input  wire [`WordDataBus] wr_data			   // data
);

	/**********  **********/
	reg [`WordDataBus]		   gpr [`REG_NUM-1:0]; // regist array
	integer					   i;				   //

	/********** (Write After Read) **********/
	// �ǂݏo���|�[�g 0
	assign rd_data_0 = ((we_ == `ENABLE_) && (wr_addr == rd_addr_0)) ?
					   wr_data : gpr[rd_addr_0];
	// �ǂݏo���|�[�g 1
	assign rd_data_1 = ((we_ == `ENABLE_) && (wr_addr == rd_addr_1)) ?
					   wr_data : gpr[rd_addr_1];

	/********** �������݃A�N�Z�X **********/
	always @ (posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* �񓯊����Z�b�g */
			for (i = 0; i < `REG_NUM; i = i + 1) begin
				gpr[i]		 <= #1 `WORD_DATA_W'h0;
			end
		end else begin
			/* �������݃A�N�Z�X */
			if (we_ == `ENABLE_) begin
				gpr[wr_addr] <= #1 wr_data;
			end
		end
	end

endmodule
