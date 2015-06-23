/*
 -- ============================================================================
 -- FILE NAME	: bus_addr_dec.v
 -- DESCRIPTION : µÿ÷∑Ω‚¬Î∆˜
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 êVãKçÏê¨
 -- ============================================================================
*/

/********** common include **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** bus include **********/
`include "bus.h"

/********** ÉÇÉWÉÖÅ[Éã **********/
module bus_addr_dec (
	/********** input signal **********/
	input  wire [`WordAddrBus] s_addr, // input bus address 
	/********** output signal **********/
	output reg				   s0_cs_, //
	output reg				   s1_cs_, //
	output reg				   s2_cs_, //
	output reg				   s3_cs_, //
	output reg				   s4_cs_, //
	output reg				   s5_cs_, // 
	output reg				   s6_cs_, //
	output reg				   s7_cs_  //
);

	/********** decode volid bits in bus address **********/
	wire [`BusSlaveIndexBus] s_index = s_addr[`BusSlaveIndexLoc];

	/********** decode the bus address  **********/
	always @(*) begin
		/* init */
		s0_cs_ = `DISABLE_;
		s1_cs_ = `DISABLE_;
		s2_cs_ = `DISABLE_;
		s3_cs_ = `DISABLE_;
		s4_cs_ = `DISABLE_;
		s5_cs_ = `DISABLE_;
		s6_cs_ = `DISABLE_;
		s7_cs_ = `DISABLE_;
		/* decode and enable slave devices */
		case (s_index)
			`BUS_SLAVE_0 : begin // slave 0 
				s0_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_1 : begin // slave 1
				s1_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_2 : begin // slave 2
				s2_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_3 : begin // slave 3
				s3_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_4 : begin // slave 4
				s4_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_5 : begin // slave 5
				s5_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_6 : begin // slave 6
				s6_cs_	= `ENABLE_;
			end
			`BUS_SLAVE_7 : begin // slave 7
				s7_cs_	= `ENABLE_;
			end
		endcase
	end

endmodule
