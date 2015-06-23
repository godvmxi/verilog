/*
 -- ============================================================================
 -- FILE NAME	: stddef.h
 -- DESCRIPTION : global common define
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/04/01  suito		 
 -- ============================================================================
*/

`ifndef __STDDEF_HEADER__				 // 
	`define __STDDEF_HEADER__

// -----------------------------------------------------------------------------
// 
// -----------------------------------------------------------------------------
	/********** basic signal define *********/
	`define HIGH				1'b1	 // 
	`define LOW					1'b0	 // 
	/**********  *********/
	// 
	`define DISABLE				1'b0	 // 
	`define ENABLE				1'b1	 // 
	// 
	`define DISABLE_			1'b1	 // 
	`define ENABLE_				1'b0	 // 
	/********** *********/
	`define READ				1'b1	 // 
	`define WRITE				1'b0	 // 

// -----------------------------------------------------------------------------
// data bus define 
// -----------------------------------------------------------------------------
	/********** bit little end define  *********/
	`define LSB					0		 // the low  bit define
	/********** 8 bits data bus with define (8 bit) *********/
	`define BYTE_DATA_W			8		 // 
	`define BYTE_MSB			7		 // the high bit define
	`define ByteDataBus			7:0		 // data bus define
	/********** 32 bits data bus define (32 bit) *********/
	`define WORD_DATA_W			32		 // 
	`define WORD_MSB			31		 // 
	`define WordDataBus			31:0	 // 

// -----------------------------------------------------------------------------
// address bus define 
// -----------------------------------------------------------------------------
	/********** address bus define *********/
	`define WORD_ADDR_W			30		 // bus width 
	`define WORD_ADDR_MSB		29		 // bus high bit
	`define WordAddrBus			29:0	 // bus arange
	/********** address byte offset define  *********/
	`define BYTE_OFFSET_W		2		 // bus address offset ,no not align data access
	`define ByteOffsetBus		1:0		 // bus byte offset bus define
	/********** word address define *********/
	`define WordAddrLoc			31:2	 // address bus valid bits
	`define ByteOffsetLoc		1:0		 // low bits for word address bytes offset
	/**********  *********/
	`define BYTE_OFFSET_WORD	2'b00	 // word offset range

`endif
