/*
 -- ============================================================================
 -- FILE NAME	: isa.h
 -- DESCRIPTION :
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

`ifndef __ISA_HEADER__
	`define __ISA_HEADER__			 // Include Guard

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
	/********** ISA Operation code define  **********/
	`define ISA_NOP			   32'h0 // No Operation
	/********** opcode  define  **********/
	// bus define
	`define ISA_OP_W		   6	 // opcode  width
	`define IsaOpBus		   5:0	 // op code  bits for decode
	`define IsaOpLoc		   31:26 // op bits range in op code
	// opcode define
	`define ISA_OP_ANDR		   6'h00 // and   						: GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_ANDI		   6'h01 // and   						: GPR[Ra] Im ->GPR[Rb]
	`define ISA_OP_ORR		   6'h02 // or    						: GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_ORI		   6'h03 // or    						: GPR[Ra] Im ->GPR[Rb]
	`define ISA_OP_XORR		   6'h04 // xor   						: GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_XORI		   6'h05 // xor   						: GPR[Ra] Im ->GPR[Rb]
	`define ISA_OP_ADDSR	   6'h06 // add signed        : GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_ADDSI	   6'h07 // add signed im     : GPR[Ra] Im ->GPR[Rb]
	`define ISA_OP_ADDUR	   6'h08 // add unsigned      : GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_ADDUI	   6'h09 // add unsigned im   : GPR[Ra] Im ->GPR[Rb]
	`define ISA_OP_SUBSR	   6'h0a // sub signed   			: GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_SUBUR	   6'h0b // sub unsigned 			: GPR[Ra] GPR[Rb] ->GPR[Rc]
	`define ISA_OP_SHRLR	   6'h0c // shift left 				: GPR[Ra] >> GPR[Rb][4:0]  -> GPR[Rc]
	`define ISA_OP_SHRLI	   6'h0d // shift left Im 		: GPR[Ra] >> Im[4:0]  -> GPR[Rc]
	`define ISA_OP_SHLLR	   6'h0e // shift right 		 	: GPR[Ra] >> GPR[Rb][4:0]  -> GPR[Rc]
	`define ISA_OP_SHLLI	   6'h0f // shift right Im    : GPR[Ra] >> Im[4:0]  -> GPR[Rc]
	`define ISA_OP_BE		   	 6'h10 // be jump 					: GPR[Ra] == GPR[Rb] ->PC = PC+IM
	`define ISA_OP_BNE		   6'h11 // bne jump 					: GPR[Ra] != GPR[Rb] ->PC = PC+IM
	`define ISA_OP_BSGT		   6'h12 // signed compare    : GPR[Ra] <  GPR[Rb] ->PC = PC+IM
	`define ISA_OP_BUGT		   6'h13 // unsigned compare  : GPR[Ra] <  GPR[Rb] ->PC = PC+IM
	`define ISA_OP_JMP		   6'h14 // jump 							: jump GPR[Ra]
	`define ISA_OP_CALL		   6'h15 // call 							: jump GPR[Ra] ,PC ->Reg[31]
	`define ISA_OP_LDW		   6'h16 // load word 				: load GPR[Ra]+Im ->  GPR[Rb]
	`define ISA_OP_STW		   6'h17 // store word				: store GPR[Ra]+Im <- GPR[Rb]
	`define ISA_OP_TRAP		   6'h18 // trap exception    :
	`define ISA_OP_RDCR		   6'h19 // read ctrl to reg  : ctrl[Ra] ->Gpr[Rb]
	`define ISA_OP_WRCR		   6'h1a // write reg to ctrl : ctrl[Rb] <- GPR[Ra]
	`define ISA_OP_EXRT		   6'h1b // exception return  :
	/**********  ra rb rc bit define  **********/
	// Rx
	`define ISA_REG_ADDR_W	   5	 // register address width
	`define IsaRegAddrBus	   4:0	 // register address bus bits range
	`define IsaRaAddrLoc	   25:21 // register Ra bits in op code
	`define IsaRbAddrLoc	   20:16 // register Rb bits in op code
	`define IsaRcAddrLoc	   15:11 // register Rc bits in op code
	/********** immediate **********/
	// Im
	`define ISA_IMM_W		   16	 // immediate witdh
	`define ISA_EXT_W		   16	 // immediate extend width
	`define ISA_IMM_MSB		   15	 // immediate data high bit
	`define IsaImmBus		   15:0	 // immediate bus bits range
	`define IsaImmLoc		   15:0	 // immediate bit in op code

//------------------------------------------------------------------------------
// irq exception define
//------------------------------------------------------------------------------
	/********** exception define  **********/
	// exception bus define
	`define ISA_EXP_W		   3	 // exception index width
	`define IsaExpBus		   2:0	 // exception index bus width
	// exception index enum
	`define ISA_EXP_NO_EXP	   3'h0	 // None
	`define ISA_EXP_EXT_INT	   3'h1	 // out interrupt
	`define ISA_EXP_UNDEF_INSN 3'h2	 // undefine exception
	`define ISA_EXP_OVERFLOW   3'h3	 // overflow exception
	`define ISA_EXP_MISS_ALIGN 3'h4	 // address not align
	`define ISA_EXP_TRAP	     3'h5	 // trap exception
	`define ISA_EXP_PRV_VIO	   3'h6	 // Violation  authority exception

`endif
