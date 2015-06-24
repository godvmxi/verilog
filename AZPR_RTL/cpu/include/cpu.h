/*
 -- ============================================================================
 -- FILE NAME	: cpu.h
 -- DESCRIPTION : CPU define
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
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
	// �I�y�R�[�h
	`define MEM_OP_NOP			 2'h0 // No Operation
	`define MEM_OP_LDW			 2'h1 // load word
	`define MEM_OP_STW			 2'h2 // store word
	/********** ctrl code define  **********/
	//
	`define CTRL_OP_W			 2	  // ctrl code bus width 
	`define CtrlOpBus			 1:0  // �����I�y�R�[�h�o�X
	// �I�y�R�[�h
	`define CTRL_OP_NOP			 2'h0 // No Operation
	`define CTRL_OP_WRCR		 2'h1 // ���䃌�W�X�^�ւ̏�������
	`define CTRL_OP_EXRT		 2'h2 // ���O�����̕��A

	/********** ���s���[�h **********/
	// �o�X
	`define CPU_EXE_MODE_W		 1	  // ���s���[�h��
	`define CpuExeModeBus		 0:0  // ���s���[�h�o�X
	// ���s���[�h
	`define CPU_KERNEL_MODE		 1'b0 // �J�[�l�����[�h
	`define CPU_USER_MODE		 1'b1 // ���[�U���[�h

//------------------------------------------------------------------------------
// ���䃌�W�X�^
//------------------------------------------------------------------------------
	/********** �A�h���X�}�b�v **********/
	`define CREG_ADDR_STATUS	 5'h0  // �X�e�[�^�X
	`define CREG_ADDR_PRE_STATUS 5'h1  // �O�̃X�e�[�^�X
	`define CREG_ADDR_PC		 5'h2  // �v���O�����J�E���^
	`define CREG_ADDR_EPC		 5'h3  // ���O�v���O�����J�E���^
	`define CREG_ADDR_EXP_VECTOR 5'h4  // ���O�x�N�^
	`define CREG_ADDR_CAUSE		 5'h5  // ���O���򃌃W�X�^
	`define CREG_ADDR_INT_MASK	 5'h6  // ���荞�݃}�X�N
	`define CREG_ADDR_IRQ		 5'h7  // ���荞�ݗv��
	// �ǂݏo�����p�̈�
	`define CREG_ADDR_ROM_SIZE	 5'h1d // ROM�T�C�Y
	`define CREG_ADDR_SPM_SIZE	 5'h1e // SPM�T�C�Y
	`define CREG_ADDR_CPU_INFO	 5'h1f // CPU����
	/********** �r�b�g�}�b�v **********/
	`define CregExeModeLoc		 0	   // ���s���[�h�̈ʒu
	`define CregIntEnableLoc	 1	   // ���荞�ݗL���̈ʒu
	`define CregExpCodeLoc		 2:0   // ���O�R�[�h�̈ʒu
	`define CregDlyFlagLoc		 3	   // �f�B���C�X���b�g�t���O�̈ʒu

//------------------------------------------------------------------------------
// �o�X�C���^�t�F�[�X
//------------------------------------------------------------------------------
	/********** �o�X�C���^�t�F�[�X�̏��� **********/
	// �o�X
	`define BusIfStateBus		 1:0   // ���ԃo�X
	// ����
	`define BUS_IF_STATE_IDLE	 2'h0  // �A�C�h��
	`define BUS_IF_STATE_REQ	 2'h1  // �o�X���N�G�X�g
	`define BUS_IF_STATE_ACCESS	 2'h2  // �o�X�A�N�Z�X
	`define BUS_IF_STATE_STALL	 2'h3  // �X�g�[��

//------------------------------------------------------------------------------
// MISC
//------------------------------------------------------------------------------
	/********** �x�N�^ **********/
	`define RESET_VECTOR		 30'h0 // ���Z�b�g�x�N�^
	/********** �V�t�g�� **********/
	`define ShAmountBus			 4:0   // �V�t�g�ʃo�X
	`define ShAmountLoc			 4:0   // �V�t�g�ʂ̈ʒu

	/********** CPU���� *********/
	`define RELEASE_YEAR		 8'd41 // �쐬�N (YYYY - 1970)
	`define RELEASE_MONTH		 8'd7  // �쐬��
	`define RELEASE_VERSION		 8'd1  // �o�[�W����
	`define RELEASE_REVISION	 8'd0  // ���r�W����


`endif
