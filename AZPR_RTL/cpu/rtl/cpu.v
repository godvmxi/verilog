/*
 -- ============================================================================
 -- FILE NAME	: cpu.v
 -- DESCRIPTION : CPU�g�b�v���W���[��
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
 -- ============================================================================
*/

/********** ���ʃw�b�_�t�@�C�� **********/
`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

/********** �ʃw�b�_�t�@�C�� **********/
`include "isa.h"
`include "cpu.h"
`include "bus.h"
`include "spm.h"

/********** ���W���[�� **********/
module cpu (
	/********** �N���b�N & ���Z�b�g **********/
	input  wire					  clk,			   // �N���b�N
	input  wire					  clk_,			   // ���]�N���b�N
	input  wire					  reset,		   // �񓯊����Z�b�g
	/********** �o�X�C���^�t�F�[�X **********/
	// IF Stage
	input  wire [`WordDataBus]	  if_bus_rd_data,  // �ǂݏo���f�[�^
	input  wire					  if_bus_rdy_,	   // ���f�B
	input  wire					  if_bus_grnt_,	   // �o�X�O�����g
	output wire					  if_bus_req_,	   // �o�X���N�G�X�g
	output wire [`WordAddrBus]	  if_bus_addr,	   // �A�h���X
	output wire					  if_bus_as_,	   // �A�h���X�X�g���[�u
	output wire					  if_bus_rw,	   // �ǂ݁^����
	output wire [`WordDataBus]	  if_bus_wr_data,  // �������݃f�[�^
	// MEM Stage
	input  wire [`WordDataBus]	  mem_bus_rd_data, // �ǂݏo���f�[�^
	input  wire					  mem_bus_rdy_,	   // ���f�B
	input  wire					  mem_bus_grnt_,   // �o�X�O�����g
	output wire					  mem_bus_req_,	   // �o�X���N�G�X�g
	output wire [`WordAddrBus]	  mem_bus_addr,	   // �A�h���X
	output wire					  mem_bus_as_,	   // �A�h���X�X�g���[�u
	output wire					  mem_bus_rw,	   // �ǂ݁^����
	output wire [`WordDataBus]	  mem_bus_wr_data, // �������݃f�[�^
	/********** ���荞�� **********/
	input  wire [`CPU_IRQ_CH-1:0] cpu_irq		   // ���荞�ݗv��
);

	/********** �p�C�v���C�����W�X�^ **********/
	// IF/ID
	wire [`WordAddrBus]			 if_pc;			 // �v���O�����J�E���^
	wire [`WordDataBus]			 if_insn;		 // ����
	wire						 if_en;			 // �p�C�v���C���f�[�^�̗L��
	// ID/EX�p�C�v���C�����W�X�^
	wire [`WordAddrBus]			 id_pc;			 // �v���O�����J�E���^
	wire						 id_en;			 // �p�C�v���C���f�[�^�̗L��
	wire [`AluOpBus]			 id_alu_op;		 // ALU�I�y���[�V����
	wire [`WordDataBus]			 id_alu_in_0;	 // ALU���� 0
	wire [`WordDataBus]			 id_alu_in_1;	 // ALU���� 1
	wire						 id_br_flag;	 // ����t���O
	wire [`MemOpBus]			 id_mem_op;		 // �������I�y���[�V����
	wire [`WordDataBus]			 id_mem_wr_data; // �������������݃f�[�^
	wire [`CtrlOpBus]			 id_ctrl_op;	 // ����I�y���[�V����
	wire [`RegAddrBus]			 id_dst_addr;	 // GPR�������݃A�h���X
	wire						 id_gpr_we_;	 // GPR�������ݗL��
	wire [`IsaExpBus]			 id_exp_code;	 // ��O�R�[�h
	// EX/MEM�p�C�v���C�����W�X�^
	wire [`WordAddrBus]			 ex_pc;			 // �v���O�����J�E���^
	wire						 ex_en;			 // �p�C�v���C���f�[�^�̗L��
	wire						 ex_br_flag;	 // ����t���O
	wire [`MemOpBus]			 ex_mem_op;		 // �������I�y���[�V����
	wire [`WordDataBus]			 ex_mem_wr_data; // �������������݃f�[�^
	wire [`CtrlOpBus]			 ex_ctrl_op;	 // ���䃌�W�X�^�I�y���[�V����
	wire [`RegAddrBus]			 ex_dst_addr;	 // �ėp���W�X�^�������݃A�h���X
	wire						 ex_gpr_we_;	 // �ėp���W�X�^�������ݗL��
	wire [`IsaExpBus]			 ex_exp_code;	 // ��O�R�[�h
	wire [`WordDataBus]			 ex_out;		 // ��������
	// MEM/WB�p�C�v���C�����W�X�^
	wire [`WordAddrBus]			 mem_pc;		 // �v���O�����J�E���^
	wire						 mem_en;		 // �p�C�v���C���f�[�^�̗L��
	wire						 mem_br_flag;	 // ����t���O
	wire [`CtrlOpBus]			 mem_ctrl_op;	 // ���䃌�W�X�^�I�y���[�V����
	wire [`RegAddrBus]			 mem_dst_addr;	 // �ėp���W�X�^�������݃A�h���X
	wire						 mem_gpr_we_;	 // �ėp���W�X�^�������ݗL��
	wire [`IsaExpBus]			 mem_exp_code;	 // ��O�R�[�h
	wire [`WordDataBus]			 mem_out;		 // ��������
	/********** �p�C�v���C������M�� **********/
	// �X�g�[���M��
	wire						 if_stall;		 // IF�X�e�[�W
	wire						 id_stall;		 // ID�X�e�[
	wire						 ex_stall;		 // EX�X�e�[�W
	wire						 mem_stall;		 // MEM�X�e�[�W
	// �t���b�V���M��
	wire						 if_flush;		 // IF�X�e�[�W
	wire						 id_flush;		 // ID�X�e�[�W
	wire						 ex_flush;		 // EX�X�e�[�W
	wire						 mem_flush;		 // MEM�X�e�[�W
	// �r�W�[�M��
	wire						 if_busy;		 // IF�X�e�[�W
	wire						 mem_busy;		 // MEM�X�e�[�W
	// ���̑��̐���M��
	wire [`WordAddrBus]			 new_pc;		 // �V����PC
	wire [`WordAddrBus]			 br_addr;		 // ����A�h���X
	wire						 br_taken;		 // ����̐���
	wire						 ld_hazard;		 // ���[�h�n�U�[�h
	/********** �ėp���W�X�^�M�� **********/
	wire [`WordDataBus]			 gpr_rd_data_0;	 // �ǂݏo���f�[�^ 0
	wire [`WordDataBus]			 gpr_rd_data_1;	 // �ǂݏo���f�[�^ 1
	wire [`RegAddrBus]			 gpr_rd_addr_0;	 // �ǂݏo���A�h���X 0
	wire [`RegAddrBus]			 gpr_rd_addr_1;	 // �ǂݏo���A�h���X 1
	/********** ���䃌�W�X�^�M�� **********/
	wire [`CpuExeModeBus]		 exe_mode;		 // ���s���[�h
	wire [`WordDataBus]			 creg_rd_data;	 // �ǂݏo���f�[�^
	wire [`RegAddrBus]			 creg_rd_addr;	 // �ǂݏo���A�h���X
	/********** Interrupt Request **********/
	wire						 int_detect;	  // ���荞�݌��o
	/********** �X�N���b�`�p�b�h�������M�� **********/
	// IF�X�e�[�W
	wire [`WordDataBus]			 if_spm_rd_data;  // �ǂݏo���f�[�^
	wire [`WordAddrBus]			 if_spm_addr;	  // �A�h���X
	wire						 if_spm_as_;	  // �A�h���X�X�g���[�u
	wire						 if_spm_rw;		  // �ǂ݁^����
	wire [`WordDataBus]			 if_spm_wr_data;  // �������݃f�[�^
	// MEM�X�e�[�W
	wire [`WordDataBus]			 mem_spm_rd_data; // �ǂݏo���f�[�^
	wire [`WordAddrBus]			 mem_spm_addr;	  // �A�h���X
	wire						 mem_spm_as_;	  // �A�h���X�X�g���[�u
	wire						 mem_spm_rw;	  // �ǂ݁^����
	wire [`WordDataBus]			 mem_spm_wr_data; // �������݃f�[�^
	/********** �t�H���[�f�B���O�M�� **********/
	wire [`WordDataBus]			 ex_fwd_data;	  // EX�X�e�[�W
	wire [`WordDataBus]			 mem_fwd_data;	  // MEM�X�e�[�W

	/********** IF�X�e�[�W **********/
	if_stage if_stage (
		/********** �N���b�N & ���Z�b�g **********/
		.clk			(clk),				// �N���b�N
		.reset			(reset),			// �񓯊����Z�b�g
		/********** SPM�C���^�t�F�[�X **********/
		.spm_rd_data	(if_spm_rd_data),	// �ǂݏo���f�[�^
		.spm_addr		(if_spm_addr),		// �A�h���X
		.spm_as_		(if_spm_as_),		// �A�h���X�X�g���[�u
		.spm_rw			(if_spm_rw),		// �ǂ݁^����
		.spm_wr_data	(if_spm_wr_data),	// �������݃f�[�^
		/********** �o�X�C���^�t�F�[�X **********/
		.bus_rd_data	(if_bus_rd_data),	// �ǂݏo���f�[�^
		.bus_rdy_		(if_bus_rdy_),		// ���f�B
		.bus_grnt_		(if_bus_grnt_),		// �o�X�O�����g
		.bus_req_		(if_bus_req_),		// �o�X���N�G�X�g
		.bus_addr		(if_bus_addr),		// �A�h���X
		.bus_as_		(if_bus_as_),		// �A�h���X�X�g���[�u
		.bus_rw			(if_bus_rw),		// �ǂ݁^����
		.bus_wr_data	(if_bus_wr_data),	// �������݃f�[�^
		/********** �p�C�v���C������M�� **********/
		.stall			(if_stall),			// �X�g�[��
		.flush			(if_flush),			// �t���b�V��
		.new_pc			(new_pc),			// �V����PC
		.br_taken		(br_taken),			// ����̐���
		.br_addr		(br_addr),			// �����A�h���X
		.busy			(if_busy),			// �r�W�[�M��
		/********** IF/ID�p�C�v���C�����W�X�^ **********/
		.if_pc			(if_pc),			// �v���O�����J�E���^
		.if_insn		(if_insn),			// ����
		.if_en			(if_en)				// �p�C�v���C���f�[�^�̗L��
	);

	/********** ID�X�e�[�W **********/
	id_stage id_stage (
		/********** �N���b�N & ���Z�b�g **********/
		.clk			(clk),				// �N���b�N
		.reset			(reset),			// �񓯊����Z�b�g
		/********** GPR�C���^�t�F�[�X **********/
		.gpr_rd_data_0	(gpr_rd_data_0),	// �ǂݏo���f�[�^ 0
		.gpr_rd_data_1	(gpr_rd_data_1),	// �ǂݏo���f�[�^ 1
		.gpr_rd_addr_0	(gpr_rd_addr_0),	// �ǂݏo���A�h���X 0
		.gpr_rd_addr_1	(gpr_rd_addr_1),	// �ǂݏo���A�h���X 1
		/********** �t�H���[�f�B���O **********/
		// EX�X�e�[�W����̃t�H���[�f�B���O
		.ex_en			(ex_en),			// �p�C�v���C���f�[�^�̗L��
		.ex_fwd_data	(ex_fwd_data),		// �t�H���[�f�B���O�f�[�^
		.ex_dst_addr	(ex_dst_addr),		// �������݃A�h���X
		.ex_gpr_we_		(ex_gpr_we_),		// �������ݗL��
		// MEM�X�e�[�W����̃t�H���[�f�B���O
		.mem_fwd_data	(mem_fwd_data),		// �t�H���[�f�B���O�f�[�^
		/********** ���䃌�W�X�^�C���^�t�F�[�X **********/
		.exe_mode		(exe_mode),			// ���s���[�h
		.creg_rd_data	(creg_rd_data),		// �ǂݏo���f�[�^
		.creg_rd_addr	(creg_rd_addr),		// �ǂݏo���A�h���X
		/********** �p�C�v���C������M�� **********/
	   .stall		   (id_stall),		   // �X�g�[��
		.flush			(id_flush),			// �t���b�V��
		.br_addr		(br_addr),			// ����A�h���X
		.br_taken		(br_taken),			// ����̐���
		.ld_hazard		(ld_hazard),		// ���[�h�n�U�[�h
		/********** IF/ID�p�C�v���C�����W�X�^ **********/
		.if_pc			(if_pc),			// �v���O�����J�E���^
		.if_insn		(if_insn),			// ����
		.if_en			(if_en),			// �p�C�v���C���f�[�^�̗L��
		/********** ID/EX�p�C�v���C�����W�X�^ **********/
		.id_pc			(id_pc),			// �v���O�����J�E���^
		.id_en			(id_en),			// �p�C�v���C���f�[�^�̗L��
		.id_alu_op		(id_alu_op),		// ALU�I�y���[�V����
		.id_alu_in_0	(id_alu_in_0),		// ALU���� 0
		.id_alu_in_1	(id_alu_in_1),		// ALU���� 1
		.id_br_flag		(id_br_flag),		// ����t���O
		.id_mem_op		(id_mem_op),		// �������I�y���[�V����
		.id_mem_wr_data (id_mem_wr_data),	// �������������݃f�[�^
		.id_ctrl_op		(id_ctrl_op),		// ����I�y���[�V����
		.id_dst_addr	(id_dst_addr),		// GPR�������݃A�h���X
		.id_gpr_we_		(id_gpr_we_),		// GPR�������ݗL��
		.id_exp_code	(id_exp_code)		// ��O�R�[�h
	);

	/********** EX�X�e�[�W **********/
	ex_stage ex_stage (
		/********** �N���b�N & ���Z�b�g **********/
		.clk			(clk),				// �N���b�N
		.reset			(reset),			// �񓯊����Z�b�g
		/********** �p�C�v���C������M�� **********/
		.stall			(ex_stall),			// �X�g�[��
		.flush			(ex_flush),			// �t���b�V��
		.int_detect		(int_detect),		// ���荞�݌��o
		/********** �t�H���[�f�B���O **********/
		.fwd_data		(ex_fwd_data),		// �t�H���[�f�B���O�f�[�^
		/********** ID/EX�p�C�v���C�����W�X�^ **********/
		.id_pc			(id_pc),			// �v���O�����J�E���^
		.id_en			(id_en),			// �p�C�v���C���f�[�^�̗L��
		.id_alu_op		(id_alu_op),		// ALU�I�y���[�V����
		.id_alu_in_0	(id_alu_in_0),		// ALU���� 0
		.id_alu_in_1	(id_alu_in_1),		// ALU���� 1
		.id_br_flag		(id_br_flag),		// ����t���O
		.id_mem_op		(id_mem_op),		// �������I�y���[�V����
		.id_mem_wr_data (id_mem_wr_data),	// �������������݃f�[�^
		.id_ctrl_op		(id_ctrl_op),		// ���䃌�W�X�^�I�y���[�V����
		.id_dst_addr	(id_dst_addr),		// �ėp���W�X�^�������݃A�h���X
		.id_gpr_we_		(id_gpr_we_),		// �ėp���W�X�^�������ݗL��
		.id_exp_code	(id_exp_code),		// ��O�R�[�h
		/********** EX/MEM�p�C�v���C�����W�X�^ **********/
		.ex_pc			(ex_pc),			// �v���O�����J�E���^
		.ex_en			(ex_en),			// �p�C�v���C���f�[�^�̗L��
		.ex_br_flag		(ex_br_flag),		// ����t���O
		.ex_mem_op		(ex_mem_op),		// �������I�y���[�V����
		.ex_mem_wr_data (ex_mem_wr_data),	// �������������݃f�[�^
		.ex_ctrl_op		(ex_ctrl_op),		// ���䃌�W�X�^�I�y���[�V����
		.ex_dst_addr	(ex_dst_addr),		// �ėp���W�X�^�������݃A�h���X
		.ex_gpr_we_		(ex_gpr_we_),		// �ėp���W�X�^�������ݗL��
		.ex_exp_code	(ex_exp_code),		// ��O�R�[�h
		.ex_out			(ex_out)			// ��������
	);

	/********** MEM�X�e�[�W **********/
	mem_stage mem_stage (
		/********** �N���b�N & ���Z�b�g **********/
		.clk			(clk),				// �N���b�N
		.reset			(reset),			// �񓯊����Z�b�g
		/********** �p�C�v���C������M�� **********/
		.stall			(mem_stall),		// �X�g�[��
		.flush			(mem_flush),		// �t���b�V��
		.busy			(mem_busy),			// �r�W�[�M��
		/********** �t�H���[�f�B���O **********/
		.fwd_data		(mem_fwd_data),		// �t�H���[�f�B���O�f�[�^
		/********** SPM�C���^�t�F�[�X **********/
		.spm_rd_data	(mem_spm_rd_data),	// �ǂݏo���f�[�^
		.spm_addr		(mem_spm_addr),		// �A�h���X
		.spm_as_		(mem_spm_as_),		// �A�h���X�X�g���[�u
		.spm_rw			(mem_spm_rw),		// �ǂ݁^����
		.spm_wr_data	(mem_spm_wr_data),	// �������݃f�[�^
		/********** �o�X�C���^�t�F�[�X **********/
		.bus_rd_data	(mem_bus_rd_data),	// �ǂݏo���f�[�^
		.bus_rdy_		(mem_bus_rdy_),		// ���f�B
		.bus_grnt_		(mem_bus_grnt_),	// �o�X�O�����g
		.bus_req_		(mem_bus_req_),		// �o�X���N�G�X�g
		.bus_addr		(mem_bus_addr),		// �A�h���X
		.bus_as_		(mem_bus_as_),		// �A�h���X�X�g���[�u
		.bus_rw			(mem_bus_rw),		// �ǂ݁^����
		.bus_wr_data	(mem_bus_wr_data),	// �������݃f�[�^
		/********** EX/MEM�p�C�v���C�����W�X�^ **********/
		.ex_pc			(ex_pc),			// �v���O�����J�E���^
		.ex_en			(ex_en),			// �p�C�v���C���f�[�^�̗L��
		.ex_br_flag		(ex_br_flag),		// ����t���O
		.ex_mem_op		(ex_mem_op),		// �������I�y���[�V����
		.ex_mem_wr_data (ex_mem_wr_data),	// �������������݃f�[�^
		.ex_ctrl_op		(ex_ctrl_op),		// ���䃌�W�X�^�I�y���[�V����
		.ex_dst_addr	(ex_dst_addr),		// �ėp���W�X�^�������݃A�h���X
		.ex_gpr_we_		(ex_gpr_we_),		// �ėp���W�X�^�������ݗL��
		.ex_exp_code	(ex_exp_code),		// ��O�R�[�h
		.ex_out			(ex_out),			// ��������
		/********** MEM/WB�p�C�v���C�����W�X�^ **********/
		.mem_pc			(mem_pc),			// �v���O�����J�E���^
		.mem_en			(mem_en),			// �p�C�v���C���f�[�^�̗L��
		.mem_br_flag	(mem_br_flag),		// ����t���O
		.mem_ctrl_op	(mem_ctrl_op),		// ���䃌�W�X�^�I�y���[�V����
		.mem_dst_addr	(mem_dst_addr),		// �ėp���W�X�^�������݃A�h���X
		.mem_gpr_we_	(mem_gpr_we_),		// �ėp���W�X�^�������ݗL��
		.mem_exp_code	(mem_exp_code),		// ��O�R�[�h
		.mem_out		(mem_out)			// ��������
	);

	/********** ���䃆�j�b�g **********/
	ctrl ctrl (
		/********** �N���b�N & ���Z�b�g **********/
		.clk			(clk),				// �N���b�N
		.reset			(reset),			// �񓯊����Z�b�g
		/********** ���䃌�W�X�^�C���^�t�F�[�X **********/
		.creg_rd_addr	(creg_rd_addr),		// �ǂݏo���A�h���X
		.creg_rd_data	(creg_rd_data),		// �ǂݏo���f�[�^
		.exe_mode		(exe_mode),			// ���s���[�h
		/********** ���荞�� **********/
		.irq			(cpu_irq),			// ���荞�ݗv��
		.int_detect		(int_detect),		// ���荞�݌��o
		/********** ID/EX�p�C�v���C�����W�X�^ **********/
		.id_pc			(id_pc),			// �v���O�����J�E���^
		/********** MEM/WB�p�C�v���C�����W�X�^ **********/
		.mem_pc			(mem_pc),			// �v���O�����J�E���^
		.mem_en			(mem_en),			// �p�C�v���C���f�[�^�̗L��
		.mem_br_flag	(mem_br_flag),		// ����t���O
		.mem_ctrl_op	(mem_ctrl_op),		// ���䃌�W�X�^�I�y���[�V����
		.mem_dst_addr	(mem_dst_addr),		// �ėp���W�X�^�������݃A�h���X
		.mem_exp_code	(mem_exp_code),		// ��O�R�[�h
		.mem_out		(mem_out),			// ��������
		/********** �p�C�v���C������M�� **********/
		// �p�C�v���C���̏��
		.if_busy		(if_busy),			// IF�X�e�[�W�r�W�[
		.ld_hazard		(ld_hazard),		// Load�n�U�[�h
		.mem_busy		(mem_busy),			// MEM�X�e�[�W�r�W�[
		// �X�g�[���M��
		.if_stall		(if_stall),			// IF�X�e�[�W�X�g�[��
		.id_stall		(id_stall),			// ID�X�e�[�W�X�g�[��
		.ex_stall		(ex_stall),			// EX�X�e�[�W�X�g�[��
		.mem_stall		(mem_stall),		// MEM�X�e�[�W�X�g�[��
		// �t���b�V���M��
		.if_flush		(if_flush),			// IF�X�e�[�W�t���b�V��
		.id_flush		(id_flush),			// ID�X�e�[�W�t���b�V��
		.ex_flush		(ex_flush),			// EX�X�e�[�W�t���b�V��
		.mem_flush		(mem_flush),		// MEM�X�e�[�W�t���b�V��
		// �V�����v���O�����J�E���^
		.new_pc			(new_pc)			// �V�����v���O�����J�E���^
	);

	/********** �ėp���W�X�^ **********/
	gpr gpr (
		/********** �N���b�N & ���Z�b�g **********/
		.clk	   (clk),					// �N���b�N
		.reset	   (reset),					// �񓯊����Z�b�g
		/********** �ǂݏo���|�[�g 0 **********/
		.rd_addr_0 (gpr_rd_addr_0),			// �ǂݏo���A�h���X
		.rd_data_0 (gpr_rd_data_0),			// �ǂݏo���f�[�^
		/********** �ǂݏo���|�[�g 1 **********/
		.rd_addr_1 (gpr_rd_addr_1),			// �ǂݏo���A�h���X
		.rd_data_1 (gpr_rd_data_1),			// �ǂݏo���f�[�^
		/********** �������݃|�[�g **********/
		.we_	   (mem_gpr_we_),			// �������ݗL��
		.wr_addr   (mem_dst_addr),			// �������݃A�h���X
		.wr_data   (mem_out)				// �������݃f�[�^
	);

	/********** �X�N���b�`�p�b�h������ **********/
	spm spm (
		/********** �N���b�N **********/
		.clk			 (clk_),					  // �N���b�N
		/********** �|�[�gA : IF�X�e�[�W **********/
		.if_spm_addr	 (if_spm_addr[`SpmAddrLoc]),  // �A�h���X
		.if_spm_as_		 (if_spm_as_),				  // �A�h���X�X�g���[�u
		.if_spm_rw		 (if_spm_rw),				  // �ǂ݁^����
		.if_spm_wr_data	 (if_spm_wr_data),			  // �������݃f�[�^
		.if_spm_rd_data	 (if_spm_rd_data),			  // �ǂݏo���f�[�^
		/********** �|�[�gB : MEM�X�e�[�W **********/
		.mem_spm_addr	 (mem_spm_addr[`SpmAddrLoc]), // �A�h���X
		.mem_spm_as_	 (mem_spm_as_),				  // �A�h���X�X�g���[�u
		.mem_spm_rw		 (mem_spm_rw),				  // �ǂ݁^����
		.mem_spm_wr_data (mem_spm_wr_data),			  // �������݃f�[�^
		.mem_spm_rd_data (mem_spm_rd_data)			  // �ǂݏo���f�[�^
	);

endmodule
