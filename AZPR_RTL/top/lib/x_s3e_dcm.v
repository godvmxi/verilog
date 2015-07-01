/*
 -- ============================================================================
 -- FILE NAME	: x_s3e_dcm.v
 -- DESCRIPTION : Xilinx Spartan-3E DCM
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/**********  **********/
`include "nettype.h"

/**********  **********/
module x_s3e_dcm (
	input  wire CLKIN_IN,		 //
	input  wire RST_IN,			 //
	output wire CLK0_OUT,		 //
	output wire CLK180_OUT,		 //
	output wire LOCKED_OUT		 //
);

	/**********  **********/
	assign CLK0_OUT	  = CLKIN_IN;
	assign CLK180_OUT = ~CLKIN_IN;
	assign LOCKED_OUT = ~RST_IN;

endmodule
