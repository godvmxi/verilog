/*
 -- ============================================================================
 -- FILE NAME	: bus_master_mux.v
 -- DESCRIPTION : bus master multiple multiplexer
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 Jap
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** bus define include **********/
`include "bus.h"

/********** bus master mux module  **********/
module bus_master_mux (
	/********** input signals **********/
	// master 0
	input  wire [`WordAddrBus] m0_addr,	   // address
	input  wire				   m0_as_,	   // address valid
	input  wire				   m0_rw,	   // read write
	input  wire [`WordDataBus] m0_wr_data, // write data
	input  wire				   m0_grnt_,   //bus arbiter gating
	//master 1
	input  wire [`WordAddrBus] m1_addr,	   //
	input  wire				   m1_as_,	   //
	input  wire				   m1_rw,	   //
	input  wire [`WordDataBus] m1_wr_data, //
	input  wire				   m1_grnt_,   //
	// /master 2
	input  wire [`WordAddrBus] m2_addr,	   //
	input  wire				   m2_as_,	   //
	input  wire				   m2_rw,	   //
	input  wire [`WordDataBus] m2_wr_data, //
	input  wire				   m2_grnt_,   //
	// /master 3
	input  wire [`WordAddrBus] m3_addr,	   //
	input  wire				   m3_as_,	   //
	input  wire				   m3_rw,	   //
	input  wire [`WordDataBus] m3_wr_data, //
	input  wire				   m3_grnt_,   //
	/********** multiplexer output  **********/
	output reg	[`WordAddrBus] s_addr,	   // address
	output reg				   s_as_,	   // address valid
	output reg				   s_rw,	   // read write
	output reg	[`WordDataBus] s_wr_data   // write data
);

	/**********  **********/
	always @(*) begin
		/* select the master input */
		if (m0_grnt_ == `ENABLE_) begin			 //
			s_addr	  = m0_addr;
			s_as_	  = m0_as_;
			s_rw	  = m0_rw;
			s_wr_data = m0_wr_data;
		end else if (m1_grnt_ == `ENABLE_) begin //
			s_addr	  = m1_addr;
			s_as_	  = m1_as_;
			s_rw	  = m1_rw;
			s_wr_data = m1_wr_data;
		end else if (m2_grnt_ == `ENABLE_) begin //
			s_addr	  = m2_addr;
			s_as_	  = m2_as_;
			s_rw	  = m2_rw;
			s_wr_data = m2_wr_data;
		end else if (m3_grnt_ == `ENABLE_) begin //
			s_addr	  = m3_addr;
			s_as_	  = m3_as_;
			s_rw	  = m3_rw;
			s_wr_data = m3_wr_data;
		end else begin							 // clean status 
			s_addr	  = `WORD_ADDR_W'h0;
			s_as_	  = `DISABLE_;
			s_rw	  = `READ;
			s_wr_data = `WORD_DATA_W'h0;
		end
	end

endmodule
