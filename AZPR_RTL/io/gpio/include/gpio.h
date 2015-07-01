/*
 -- ============================================================================
 -- FILE NAME	: gpio.h
 -- DESCRIPTION : General Purpose I/O
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
 -- ============================================================================
*/

`ifndef __GPIO_HEADER__
   `define __GPIO_HEADER__			//

	/********** �|�[�g���̒��` **********/
	`define GPIO_IN_CH		   4	// IO INPUT Channel
	`define GPIO_OUT_CH		   18	// IO Output Channel
	`define GPIO_IO_CH		   16	// Input Output Channel

	/********** bus define  **********/
	`define GpioAddrBus		   1:0	// address bus
	`define GPIO_ADDR_W		   2	// address bus width
	`define GpioAddrLoc		   1:0	//address location
	/********** io data define  **********/
	`define GPIO_ADDR_IN_DATA  2'h0 // control reg 0 : input data
	`define GPIO_ADDR_OUT_DATA 2'h1 // control reg 1 : output data
	`define GPIO_ADDR_IO_DATA  2'h2 // control reg 2 : input output data
	`define GPIO_ADDR_IO_DIR   2'h3 // control reg 3 : io direction
	/********** io direction define  **********/
	`define GPIO_DIR_IN		   1'b0 // input
	`define GPIO_DIR_OUT	   1'b1 // output 

`endif
