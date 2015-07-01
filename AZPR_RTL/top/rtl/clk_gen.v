/*
 -- ============================================================================
 -- FILE NAME	: clk_gen.v
 -- DESCRIPTION :
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** clock gen module  **********/
module clk_gen (
	/********** clk && reset  **********/
	input wire	clk_ref,   // main clk
	input wire	reset_sw,  // async reset
	/********** output  **********/
	output wire clk,	   // out clk
	output wire clk_,	   // out nege clk
	/********** output reset  **********/
	output wire chip_reset // clk reset output
);

	/**********  **********/
	wire		locked;	   // clk locked
	wire		dcm_reset; // 

	/**********  **********/
	//
	assign dcm_reset  = (reset_sw == `RESET_ENABLE) ? `ENABLE : `DISABLE;
	//
	assign chip_reset = ((reset_sw == `RESET_ENABLE) || (locked == `DISABLE)) ?
							`RESET_ENABLE : `RESET_DISABLE;

	/********** Xilinx DCM (Digitl Clock Manager) **********/
	x_s3e_dcm x_s3e_dcm (
		.CLKIN_IN		 (clk_ref),	  //
		.RST_IN			 (dcm_reset), //
		.CLK0_OUT		 (clk),		  //
		.CLK180_OUT		 (clk_),	  //
		.LOCKED_OUT		 (locked)	  //
   );

endmodule
