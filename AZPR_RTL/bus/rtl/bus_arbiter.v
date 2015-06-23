/*
 -- ============================================================================
 -- FILE	 : bus_arbiter.v
 -- SYNOPSIS : �����ٲ���
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** include bus **********/
`include "bus.h"

/********** �����ٲ���module **********/
module bus_arbiter (
	/********** �����ź� **********/
	input  wire		   clk,		 //
	input  wire		   reset,	 // 
	/********** ����ź� **********/
	// for bus master 0
	input  wire		   m0_req_,	 // �ٲ����� 
	output reg		   m0_grnt_, // �ٲ���Ӧ
	// for bus master 1
	input  wire		   m1_req_,	 // 
	output reg		   m1_grnt_, // 
	// for bus master 2
	input  wire		   m2_req_,	 // 
	output reg		   m2_grnt_, // 
	// for bus master 3
	input  wire		   m3_req_,	 // 
	output reg		   m3_grnt_	 //
);

	/********** reg �������� **********/
	reg [`BusOwnerBus] owner;	 // �������������
   
	/********** module  **********/
	always @(*) begin
		/* ��ʼ�� */
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
		/*  */
		case (owner)
			`BUS_OWNER_MASTER_0 : begin // bus master 0
				m0_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_1 : begin // bus master 1
				m1_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_2 : begin // bus master 2
				m2_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_3 : begin // bus master 3
				m3_grnt_ = `ENABLE_;
			end
		endcase
	end
   
	/********** �ٲ�����Ȩ��� **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* reset */
			owner <= #1 `BUS_OWNER_MASTER_0;
		end else begin
			/* �ٲ�����Ȩ������ */
			case (owner)
				`BUS_OWNER_MASTER_0 : begin // ��ǰ������Ϊ0,���ȼ�: 0>1>2>3
					/* �����ȼ���������Ȩ */
					if (m0_req_ == `ENABLE_) begin			//
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_3;
					end
				end
				`BUS_OWNER_MASTER_1 : begin // ��ǰ������Ϊ1,
					/*���ȼ�: 1>2>3>0 */
					if (m1_req_ == `ENABLE_) begin			//
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin //
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin //
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin //
						owner <= #1 `BUS_OWNER_MASTER_0;
					end
				end
				`BUS_OWNER_MASTER_2 : begin // ��ǰ������Ϊ2
					/* ���ȼ�: 2>3>0>1 */
					if (m2_req_ == `ENABLE_) begin			// 
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin //
						owner <= #1 `BUS_OWNER_MASTER_1;
					end
				end
				`BUS_OWNER_MASTER_3 : begin // ��ǰ������Ϊ3
					/* ���ȼ�: 3>0>1>2 */
					if (m3_req_ == `ENABLE_) begin			// 
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // 
						owner <= #1 `BUS_OWNER_MASTER_2;
					end
				end
			endcase
		end
	end

endmodule
