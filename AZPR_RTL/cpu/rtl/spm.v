/*
 -- ============================================================================
 -- FILE NAME	: spm.v
 -- DESCRIPTION : Scratch Pad Memory
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

/********** spm include  **********/
`include "spm.h"

/********** module define **********/
module spm (
	/********** clk **********/
	input  wire				   clk,				//
	/********** interface for cpu if stage  **********/
	input  wire [`SpmAddrBus]  if_spm_addr,		// address
	input  wire				   if_spm_as_,		// addres enable
	input  wire				   if_spm_rw,		// read write   1: write
	input  wire [`WordDataBus] if_spm_wr_data,	// write data
	output wire [`WordDataBus] if_spm_rd_data,	// read data
	/********** interface for cpu mem stage  **********/
	input  wire [`SpmAddrBus]  mem_spm_addr,	//
	input  wire				   mem_spm_as_,		//
	input  wire				   mem_spm_rw,		//
	input  wire [`WordDataBus] mem_spm_wr_data, //
	output wire [`WordDataBus] mem_spm_rd_data	//
);

	/********** write enable  **********/
	reg						   wea;			// port A   1 / write
	reg						   web;			// port B

	/**********   **********/
	always @(*) begin
		/* port A */
		if ((if_spm_as_ == `ENABLE_) && (if_spm_rw == `WRITE)) begin
			wea = `MEM_ENABLE;	//
		end else begin
			wea = `MEM_DISABLE; //
		end
		/*  */
		if ((mem_spm_as_ == `ENABLE_) && (mem_spm_rw == `WRITE)) begin
			web = `MEM_ENABLE;	//
		end else begin
			web = `MEM_DISABLE; //
		end
	end

	/********** Xilinx FPGA Block RAM :RAM **********/
	x_s3e_dpram x_s3e_dpram (
		/********** port A : IF stage **********/
		.clka  (clk),			  //
		.addra (if_spm_addr),	  //
		.dina  (if_spm_wr_data),  //
		.wea   (wea),			  //
		.douta (if_spm_rd_data),  //
		/********** port  B : MEM stage **********/
		.clkb  (clk),			  //
		.addrb (mem_spm_addr),	  //
		.dinb  (mem_spm_wr_data), //
		.web   (web),			  //
		.doutb (mem_spm_rd_data)  // 
	);

endmodule
