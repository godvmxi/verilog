/*
 -- ============================================================================
 -- FILE NAME	: isa.h
 -- DESCRIPTION : ���߃Z�b�g�A�[�L�e�N�`��
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
 -- ============================================================================
*/

`ifndef __ISA_HEADER__
	`define __ISA_HEADER__			 // Include Guard

//------------------------------------------------------------------------------
// ����
//------------------------------------------------------------------------------
	/********** ���� **********/
	`define ISA_NOP			   32'h0 // No Operation
	/********** �I�y�R�[�h **********/
	// �o�X
	`define ISA_OP_W		   6	 // opcode  width
	`define IsaOpBus		   5:0	 // op code  bits for decode
	`define IsaOpLoc		   31:26 // op bits range in op code
	// �I�y�R�[�h
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
	/********** ���W�X�^�A�h���X **********/
	// �o�X
	`define ISA_REG_ADDR_W	   5	 // ���W�X�^�A�h���X��
	`define IsaRegAddrBus	   4:0	 // ���W�X�^�A�h���X�o�X
	`define IsaRaAddrLoc	   25:21 // ���W�X�^Ra�̈ʒu
	`define IsaRbAddrLoc	   20:16 // ���W�X�^Rb�̈ʒu
	`define IsaRcAddrLoc	   15:11 // ���W�X�^Rc�̈ʒu
	/********** ���l **********/
	// �o�X
	`define ISA_IMM_W		   16	 // ���l�̕�
	`define ISA_EXT_W		   16	 // ���l�̕����g����
	`define ISA_IMM_MSB		   15	 // ���l�̍ŏ��ʃr�b�g
	`define IsaImmBus		   15:0	 // ���l�̃o�X
	`define IsaImmLoc		   15:0	 // ���l�̈ʒu

//------------------------------------------------------------------------------
// ���O
//------------------------------------------------------------------------------
	/********** ���O�R�[�h **********/
	// �o�X
	`define ISA_EXP_W		   3	 // ���O�R�[�h��
	`define IsaExpBus		   2:0	 // ���O�R�[�h�o�X
	// ���O
	`define ISA_EXP_NO_EXP	   3'h0	 // ���O�Ȃ�
	`define ISA_EXP_EXT_INT	   3'h1	 // �O�����荞��
	`define ISA_EXP_UNDEF_INSN 3'h2	 // �����`����
	`define ISA_EXP_OVERFLOW   3'h3	 // �Z�p�I�[�o�t���[
	`define ISA_EXP_MISS_ALIGN 3'h4	 // �A�h���X�~�X�A���C��
	`define ISA_EXP_TRAP	   3'h5	 // �g���b�v
	`define ISA_EXP_PRV_VIO	   3'h6	 // �����ᔽ

`endif
