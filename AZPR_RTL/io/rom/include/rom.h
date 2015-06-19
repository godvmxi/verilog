/*
 -- ============================================================================
 -- FILE NAME	: rom.h
 -- DESCRIPTION : ROM �w�b�_
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
 -- ============================================================================
*/

`ifndef __ROM_HEADER__
	`define __ROM_HEADER__			  // �C���N���[�h�K�[�h

/*
 * �yROM�̃T�C�Y�ɂ��āz
 * �EROM�̃T�C�Y��ύX����ɂ́A
 *	 ROM_SIZE�AROM_DEPTH�AROM_ADDR_W�ARomAddrBus�ARomAddrLoc��ύX���ĉ������B
 * �EROM_SIZE��ROM�̃T�C�Y���`���Ă��܂��B
 * �EROM_DEPTH��ROM�̐[�����`���Ă��܂��B
 *	 ROM�̕��͊�{�I��32bit�i4Byte�j�Œ�Ȃ̂ŁA
 *	 ROM_DEPTH��ROM_SIZE��4�Ŋ������l�ɂȂ�܂��B
 * �EROM_ADDR_W��ROM�̃A�h���X�����`���Ă���A
 *	 ROM_DEPTH��log2�����l�ɂȂ�܂��B
 * �ERomAddrBus��RomAddrLoc��ROM_ADDR_W�̃o�X�ł��B
 *	 ROM_ADDR_W-1:0�Ƃ��ĉ������B
 *
 * �yROM�̃T�C�Y�̗�z
 * �EROM�̃T�C�Y��8192Byte�i4KB�j�̏ꍇ�A
 *	 ROM_DEPTH��8192��4��2048
 *	 ROM_ADDR_W��log2(2048)��11�ƂȂ�܂��B
 */

	`define ROM_SIZE   8192	// ROM�̃T�C�Y
	`define ROM_DEPTH  2048	// ROM�̐[��
	`define ROM_ADDR_W 11	// �A�h���X��
	`define RomAddrBus 10:0 // �A�h���X�o�X
	`define RomAddrLoc 10:0 // �A�h���X�̈ʒu

`endif
