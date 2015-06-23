/*
 -- ============================================================================
 -- FILE NAME	: global_config.h
 -- DESCRIPTION : global setting para
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 
 -- ============================================================================
*/

`ifndef __GLOBAL_CONFIG_HEADER__
	`define __GLOBAL_CONFIG_HEADER__	// 

//------------------------------------------------------------------------------
// 
//------------------------------------------------------------------------------
	/********** develop board sellect  **********/
//	`define TARGET_DEV_MFPGA_SPAR3E		// 
	`define TARGET_DEV_AZPR_EV_BOARD	//

	/********** reset signal active status **********/
//	`define POSITIVE_RESET				// Active High
	`define NEGATIVE_RESET				// Active Low

	/********** memory active status **********/
	`define POSITIVE_MEMORY				// Active High
//	`define NEGATIVE_MEMORY				// Active Low

	/********** I/O device define *********/
	`define IMPLEMENT_TIMER				// Timer
	`define IMPLEMENT_UART				// UART
	`define IMPLEMENT_GPIO				// General Purpose I/O

//------------------------------------------------------------------------------
// signal polarity define
//------------------------------------------------------------------------------
	/**********  *********/
	// Active Low
	`ifdef POSITIVE_RESET
		`define RESET_EDGE	  posedge	// 
		`define RESET_ENABLE  1'b1		// 
		`define RESET_DISABLE 1'b0		// 
	`endif
	// Active High
	`ifdef NEGATIVE_RESET
		`define RESET_EDGE	  negedge	// 
		`define RESET_ENABLE  1'b0		// 
		`define RESET_DISABLE 1'b1		// 
	`endif

	/********** ÉÅÉÇÉäêßå‰êMçÜÇÃã…ê´ *********/
	// Actoive High
	`ifdef POSITIVE_MEMORY
		`define MEM_ENABLE	  1'b1		// 
		`define MEM_DISABLE	  1'b0		// 
	`endif
	// Active Low
	`ifdef NEGATIVE_MEMORY
		`define MEM_ENABLE	  1'b0		// 
		`define MEM_DISABLE	  1'b1		//
	`endif

`endif
