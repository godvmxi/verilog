/*
 -- ============================================================================
 -- FILE NAME	: bus.v
 -- DESCRIPTION : bus
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito
 -- ============================================================================
*/

/********** common inlcude **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** bus define inlcude **********/
`include "bus.h"

/********** module define **********/
module bus (
	/********** input signal  **********/
	input  wire				   clk,		   //
	input  wire				   reset,	   //
	/********** output signal **********/
	//master comon siganls for read
	output wire [`WordDataBus] m_rd_data,  //
	output wire				   m_rdy_,	   //
	// master 0
	input  wire				   m0_req_,	   // request siganl of master 0 's aribitration
	input  wire [`WordAddrBus] m0_addr,	   // address of master 0
	input  wire				   m0_as_,	   // address gating siganl of master 0
	input  wire				   m0_rw,	   	// read  write siganl of master 0
	input  wire [`WordDataBus] m0_wr_data, // read wirte data of mater 0
	output wire				   m0_grnt_,   // ok signal of master 0 's aribitration
	// master 1
	input  wire				   m1_req_,	   //
	input  wire [`WordAddrBus] m1_addr,	   //
	input  wire				   m1_as_,	   //
	input  wire				   m1_rw,	   //
	input  wire [`WordDataBus] m1_wr_data, //
	output wire				   m1_grnt_,   //
	//master 2
	input  wire				   m2_req_,	   //
	input  wire [`WordAddrBus] m2_addr,	   //
	input  wire				   m2_as_,	   //
	input  wire				   m2_rw,	   //
	input  wire [`WordDataBus] m2_wr_data, //
	output wire				   m2_grnt_,   //
	//master 3
	input  wire				   m3_req_,	   //
	input  wire [`WordAddrBus] m3_addr,	   //
	input  wire				   m3_as_,	   //
	input  wire				   m3_rw,	   //
	input  wire [`WordDataBus] m3_wr_data, //
	output wire				   m3_grnt_,   //
	/********** slave device signals **********/
	// slave common signal
	output wire [`WordAddrBus] s_addr,	   // slave device addresss
	output wire				   s_as_,	   // slave device address gating signal
	output wire				   s_rw,	   // slave decice read wirte signal
	output wire [`WordDataBus] s_wr_data,  // slave device write data signal
	// slave 0
	input  wire [`WordDataBus] s0_rd_data, // slave read data
	input  wire				   s0_rdy_,	   // slave read data ready
	output wire				   s0_cs_,	   // slave chip enable
	// slave 1
	input  wire [`WordDataBus] s1_rd_data, //
	input  wire				   s1_rdy_,	   //
	output wire				   s1_cs_,	   //
	// slave 2
	input  wire [`WordDataBus] s2_rd_data, //
	input  wire				   s2_rdy_,	   //
	output wire				   s2_cs_,	   //
	// slave 3
	input  wire [`WordDataBus] s3_rd_data, //
	input  wire				   s3_rdy_,	   //
	output wire				   s3_cs_,	   //
	// slave 4
	input  wire [`WordDataBus] s4_rd_data, //
	input  wire				   s4_rdy_,	   //
	output wire				   s4_cs_,	   //
	// slave 5
	input  wire [`WordDataBus] s5_rd_data, //
	input  wire				   s5_rdy_,	   //
	output wire				   s5_cs_,	   //
	// slave 6
	input  wire [`WordDataBus] s6_rd_data, //
	input  wire				   s6_rdy_,	   //
	output wire				   s6_cs_,	   //
	// slave 7
	input  wire [`WordDataBus] s7_rd_data, //
	input  wire				   s7_rdy_,	   //
	output wire				   s7_cs_	   //
);

	/********** bus arbiter  **********/
	bus_arbiter bus_arbiter (
		/********** clk && reset **********/
		.clk		(clk),		  //
		.reset		(reset),	  //
		/********** request and ack to master n **********/
		// master 0
		.m0_req_	(m0_req_),	  //
		.m0_grnt_	(m0_grnt_),	  //
		// master 1
		.m1_req_	(m1_req_),	  //
		.m1_grnt_	(m1_grnt_),	  //
		//  master 2
		.m2_req_	(m2_req_),	  //
		.m2_grnt_	(m2_grnt_),	  //
		//  master 3
		.m3_req_	(m3_req_),	  //
		.m3_grnt_	(m3_grnt_)	  //
	);

	/********** master mux **********/
	bus_master_mux bus_master_mux (
		/********** **********/
		// master 0
		.m0_addr	(m0_addr),	  // address
		.m0_as_		(m0_as_),	  // address valid
		.m0_rw		(m0_rw),	  // read write select
		.m0_wr_data (m0_wr_data), // write data
		.m0_grnt_	(m0_grnt_),	  // master 0 arbiter control
		// master 1
		.m1_addr	(m1_addr),	  //
		.m1_as_		(m1_as_),	  //
		.m1_rw		(m1_rw),	  //
		.m1_wr_data (m1_wr_data), //
		.m1_grnt_	(m1_grnt_),	  //
		//
		.m2_addr	(m2_addr),	  //
		.m2_as_		(m2_as_),	  //
		.m2_rw		(m2_rw),	  //
		.m2_wr_data (m2_wr_data), //
		.m2_grnt_	(m2_grnt_),	  //
		//
		.m3_addr	(m3_addr),	  //
		.m3_as_		(m3_as_),	  //
		.m3_rw		(m3_rw),	  //
		.m3_wr_data (m3_wr_data), //
		.m3_grnt_	(m3_grnt_),	  //
		/**********  **********/
		.s_addr		(s_addr),	  // address output
		.s_as_		(s_as_),	  // address valid output
		.s_rw		(s_rw),		  //   read write output
		.s_wr_data	(s_wr_data)	  // write data output
	);

	/********** bus address decider **********/
	bus_addr_dec bus_addr_dec (
		/**********  **********/
		.s_addr		(s_addr),	  // slave device address
		/**********  **********/
		.s0_cs_		(s0_cs_),	  // slave 0 enable
		.s1_cs_		(s1_cs_),	  //
		.s2_cs_		(s2_cs_),	  //
		.s3_cs_		(s3_cs_),	  //
		.s4_cs_		(s4_cs_),	  //
		.s5_cs_		(s5_cs_),	  //
		.s6_cs_		(s6_cs_),	  //
		.s7_cs_		(s7_cs_)	  //
	);

	/********** bus slave mux **********/
	bus_slave_mux bus_slave_mux (
		/**********  slave x enable input **********/
		.s0_cs_		(s0_cs_),	  // slave 0
		.s1_cs_		(s1_cs_),	  //
		.s2_cs_		(s2_cs_),	  //
		.s3_cs_		(s3_cs_),	  //
		.s4_cs_		(s4_cs_),	  //
		.s5_cs_		(s5_cs_),	  //
		.s6_cs_		(s6_cs_),	  //
		.s7_cs_		(s7_cs_),	  //
		/********** slave x read && ready signal **********/
		// slave 0
		.s0_rd_data (s0_rd_data), // read data
		.s0_rdy_	(s0_rdy_),	  // read ready
		//
		.s1_rd_data (s1_rd_data), //
		.s1_rdy_	(s1_rdy_),	  //
		//
		.s2_rd_data (s2_rd_data), //
		.s2_rdy_	(s2_rdy_),	  //
		//
		.s3_rd_data (s3_rd_data), //
		.s3_rdy_	(s3_rdy_),	  //
		//
		.s4_rd_data (s4_rd_data), //
		.s4_rdy_	(s4_rdy_),	  //
		//
		.s5_rd_data (s5_rd_data), //
		.s5_rdy_	(s5_rdy_),	  //
		//
		.s6_rd_data (s6_rd_data), //
		.s6_rdy_	(s6_rdy_),	  //
		//
		.s7_rd_data (s7_rd_data), //
		.s7_rdy_	(s7_rdy_),	  //
		/********** read data output  **********/
		.m_rd_data	(m_rd_data),  //
		.m_rdy_		(m_rdy_)	  // 
	);

endmodule
