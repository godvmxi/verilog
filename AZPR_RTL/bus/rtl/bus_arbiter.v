/*
 -- ============================================================================
 -- FILE	 : bus_arbiter.v
 -- SYNOPSIS : 总线仲裁器
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

/********** 总线仲裁器module **********/
module bus_arbiter (
	/********** 输入信号 **********/
	input  wire		   clk,		 //
	input  wire		   reset,	 // 
	/********** 输出信号 **********/
	// for bus master 0
	input  wire		   m0_req_,	 // 仲裁请求 
	output reg		   m0_grnt_, // 仲裁响应
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

	/********** reg 变量声明 **********/
	reg [`BusOwnerBus] owner;	 // 总线所有者序号
   
	/********** module  **********/
	always @(*) begin
		/* 初始化 */
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
   
	/********** 仲裁所有权检测 **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* reset */
			owner <= #1 `BUS_OWNER_MASTER_0;
		end else begin
			/* 仲裁所有权检测分配 */
			case (owner)
				`BUS_OWNER_MASTER_0 : begin // 当前所有者为0,优先级: 0>1>2>3
					/* 按优先级分配所有权 */
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
				`BUS_OWNER_MASTER_1 : begin // 当前所有者为1,
					/*优先级: 1>2>3>0 */
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
				`BUS_OWNER_MASTER_2 : begin // 当前所有者为2
					/* 优先级: 2>3>0>1 */
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
				`BUS_OWNER_MASTER_3 : begin // 当前所有者为3
					/* 优先级: 3>0>1>2 */
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
