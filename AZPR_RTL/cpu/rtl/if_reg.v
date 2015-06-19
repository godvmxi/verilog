/*
 -- ============================================================================
 -- FILE NAME	: if_reg.v
 -- DESCRIPTION : IF�X�e�[�W�p�C�v���C�����W�X�^
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

/********** ���W���[�� **********/
module if_reg (
	/********** �N���b�N & ���Z�b�g **********/
	input  wire				   clk,		   // �N���b�N
	input  wire				   reset,	   // �񓯊����Z�b�g
	/********** �t�F�b�`�f�[�^ **********/
	input  wire [`WordDataBus] insn,	   // �t�F�b�`��������
	/********** �p�C�v���C������M�� **********/
	input  wire				   stall,	   // �X�g�[��
	input  wire				   flush,	   // �t���b�V��
	input  wire [`WordAddrBus] new_pc,	   // �V�����v���O�����J�E���^
	input  wire				   br_taken,   // ����̐���
	input  wire [`WordAddrBus] br_addr,	   // �����A�h���X
	/********** IF/ID�p�C�v���C�����W�X�^ **********/
	output reg	[`WordAddrBus] if_pc,	   // �v���O�����J�E���^
	output reg	[`WordDataBus] if_insn,	   // ����
	output reg				   if_en	   // �p�C�v���C���f�[�^�̗L��
);

	/********** �p�C�v���C�����W�X�^ **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin 
			/* �񓯊����Z�b�g */
			if_pc	<= #1 `RESET_VECTOR;
			if_insn <= #1 `ISA_NOP;
			if_en	<= #1 `DISABLE;
		end else begin
			/* �p�C�v���C�����W�X�^�̍X�V */
			if (stall == `DISABLE) begin 
				if (flush == `ENABLE) begin				// �t���b�V��
					if_pc	<= #1 new_pc;
					if_insn <= #1 `ISA_NOP;
					if_en	<= #1 `DISABLE;
				end else if (br_taken == `ENABLE) begin // ����̐���
					if_pc	<= #1 br_addr;
					if_insn <= #1 insn;
					if_en	<= #1 `ENABLE;
				end else begin							// ���̃A�h���X
					if_pc	<= #1 if_pc + 1'd1;
					if_insn <= #1 insn;
					if_en	<= #1 `ENABLE;
				end
			end
		end
	end

endmodule
