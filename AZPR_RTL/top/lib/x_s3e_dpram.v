/*
 -- ============================================================================
 -- FILE NAME	: x_s3e_dpram.v
 -- DESCRIPTION : Xilinx Spartan-3E Dual Port RAM
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** spm define include  **********/
`include "spm.h"

/********** module define  **********/
module x_s3e_dpram (
	/********** port A **********/
	input  wire				   clka,  // clk
	input  wire [`SpmAddrBus]  addra, // address
	input  wire [`WordDataBus] dina,  // data in
	input  wire				   wea,	  // write read  :write
	output reg	[`WordDataBus] douta, // data out
	/********** port B **********/
	input  wire				   clkb,  //
	input  wire [`SpmAddrBus]  addrb, //
	input  wire [`WordDataBus] dinb,  //
	input  wire				   web,	  //
	output reg	[`WordDataBus] doutb  //
);

	/********** mem area and size **********/
	reg [`WordDataBus] mem [0:`SPM_DEPTH-1];

	/**********  **********/
	always @(posedge clka) begin
		// write
		if ((web == `ENABLE) && (addra == addrb)) begin
			douta	  <= #1 dinb; //direct douta  from b
		end else begin
			douta	  <= #1 mem[addra];
		end
		// for read
		if (wea == `ENABLE) begin
			mem[addra]<= #1 dina;
		end
	end

	/**********  **********/
	always @(posedge clkb) begin
		//
		if ((wea == `ENABLE) && (addrb == addra)) begin
			doutb	  <= #1 dina;
		end else begin
			doutb	  <= #1 mem[addrb];
		end
		// 
		if (web == `ENABLE) begin
			mem[addrb]<= #1 dinb;
		end
	end

endmodule
