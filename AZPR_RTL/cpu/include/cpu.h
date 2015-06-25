/*
 -- ============================================================================
 -- FILE NAME	: cpu.h
 -- DESCRIPTION : CPU define
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 
 -- ============================================================================
*/

`ifndef __CPU_HEADER__
	`define __CPU_HEADER__	// avoid reinclude

//------------------------------------------------------------------------------
// Operation
//------------------------------------------------------------------------------
	/********** register define  **********/
	`define REG_NUM				 32	  // register number
	`define REG_ADDR_W			 5	  // register address width
	`define RegAddrBus			 4:0  // register address bits range
	/********** cpu irq define  **********/
	`define CPU_IRQ_CH			 8	  // IRQ channel number
	/********** ALU cmd define  **********/
	// ALU OP Bus Define
	`define ALU_OP_W			 4	  // ALU Opcode width
	`define AluOpBus			 3:0  // ALU opcode bits range
	// ALU OP Define
	`define ALU_OP_NOP			 4'h0  // No Operation
	`define ALU_OP_AND			 4'h1  // AND
	`define ALU_OP_OR			   4'h2  // OR
	`define ALU_OP_XOR			 4'h3  // XOR
	`define ALU_OP_ADDS			 4'h4  // add signed
	`define ALU_OP_ADDU			 4'h5  // add unsigned
	`define ALU_OP_SUBS			 4'h6  //  sub signed
	`define ALU_OP_SUBU			 4'h7  // sun unsigned
	`define ALU_OP_SHRL			 4'h8  // shift left
	`define ALU_OP_SHLL			 4'h9  // shift right
	/********** memory opcode define  **********/
	// memory opcode define
	`define MEM_OP_W			 2	  // memory opcode width
	`define MemOpBus			 1:0  // memory opcode bus
	//
	`define MEM_OP_NOP			 2'h0 // No Operation
	`define MEM_OP_LDW			 2'h1 // load word
	`define MEM_OP_STW			 2'h2 // store word
	/********** ctrl code define  **********/
	//
	`define CTRL_OP_W			 2	  // ctrl code bus width
	`define CtrlOpBus			 1:0  // ctrl code bus
	//
	`define CTRL_OP_NOP			 2'h0 // No Operation
	`define CTRL_OP_WRCR		 2'h1 // ctrl op write ctrl register
	`define CTRL_OP_EXRT		 2'h2 // return from exception

	/**********  cpu mode define  **********/
	//
	`define CPU_EXE_MODE_W		 1	  // cpu execute mode width
	`define CpuExeModeBus		 0:0  // cpu execute mode bus
	//
	`define CPU_KERNEL_MODE		 1'b0 // cpu kernel mode
	`define CPU_USER_MODE		 1'b1 // cpu user mode

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
	/********** CREG address define  **********/
	`define CREG_ADDR_STATUS	 5'h0  // address status
	`define CREG_ADDR_PRE_STATUS 5'h1  // address pre status
	`define CREG_ADDR_PC		 5'h2  //   PC
	`define CREG_ADDR_EPC		 5'h3  //   exception count
	`define CREG_ADDR_EXP_VECTOR 5'h4  // exception Vector
	`define CREG_ADDR_CAUSE		 5'h5  // exception cause
	`define CREG_ADDR_INT_MASK	 5'h6  //irq mask
	`define CREG_ADDR_IRQ		 5'h7  // irq
	//
	`define CREG_ADDR_ROM_SIZE	 5'h1d // Rom size
	`define CREG_ADDR_SPM_SIZE	 5'h1e // SPM Size
	`define CREG_ADDR_CPU_INFO	 5'h1f // CPU para
	/**********  **********/
	`define CregExeModeLoc		 0	   // execute mode location
	`define CregIntEnableLoc	 1	   // interrupt enable location
	`define CregExpCodeLoc		 2:0   // exception code location
	`define CregDlyFlagLoc		 3	   // delay flag location

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
	/********** bus interface define  **********/
	//
	`define BusIfStateBus		 1:0   // bus interface status bus
	//
	`define BUS_IF_STATE_IDLE	 2'h0  // bus interface status idle
	`define BUS_IF_STATE_REQ	 2'h1  // request
	`define BUS_IF_STATE_ACCESS	 2'h2  // access
	`define BUS_IF_STATE_STALL	 2'h3  // stall pause

//------------------------------------------------------------------------------
// MISC
//------------------------------------------------------------------------------
	/**********  **********/
	`define RESET_VECTOR		 30'h0 // reset vector
	/**********  **********/
	`define ShAmountBus			 4:0   // shift amount bus
	`define ShAmountLoc			 4:0   // shift amount location

	/********** CPU info  *********/
	`define RELEASE_YEAR		 8'd41 //  (YYYY - 1970)
	`define RELEASE_MONTH		 8'd7  //
	`define RELEASE_VERSION		 8'd1  //
	`define RELEASE_REVISION	 8'd0  //


`endif
