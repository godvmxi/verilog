/*
 -- ============================================================================
 -- FILE NAME	: if_reg.v
 -- DESCRIPTION : IF stage reg
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

/********** isa cpu include  **********/
`include "isa.h"
`include "cpu.h"

/********** if reg module define **********/
module if_reg (
	/********** clk && reset  **********/
	input  wire				   clk,		   //
	input  wire				   reset,	   //
	/**********  **********/
	input  wire [`WordDataBus] insn,	   // instruction
	/********** control sigal **********/
	input  wire				   stall,	   // delay
	input  wire				   flush,	   // flush
	input  wire [`WordAddrBus] new_pc,	   //
	input  wire				   br_taken,   // Branch establishment
	input  wire [`WordAddrBus] br_addr,	   // Branch address
	/********** IF/ID register  **********/
	output reg	[`WordAddrBus] if_pc,	   //
	output reg	[`WordDataBus] if_insn,	   //
	output reg				   if_en	   // Pipeline Data significance
);

	/**********  **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/*  */
			if_pc	<= #1 `RESET_VECTOR;
			if_insn <= #1 `ISA_NOP;
			if_en	<= #1 `DISABLE;
		end else begin
			/*  */
			if (stall == `DISABLE) begin
				if (flush == `ENABLE) begin				// 
					if_pc	<= #1 new_pc;
					if_insn <= #1 `ISA_NOP;
					if_en	<= #1 `DISABLE;
				end else if (br_taken == `ENABLE) begin //
					if_pc	<= #1 br_addr;
					if_insn <= #1 insn;
					if_en	<= #1 `ENABLE;
				end else begin							// get next pc value
					if_pc	<= #1 if_pc + 1'd1;
					if_insn <= #1 insn;
					if_en	<= #1 `ENABLE;
				end
			end
		end
	end

endmodule
