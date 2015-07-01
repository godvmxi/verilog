/*
 -- ============================================================================
 -- FILE NAME	: gpio.v
 -- DESCRIPTION :  General Purpose I/O
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 �V�K�쐬
 -- ============================================================================
*/

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** gpio include  **********/
`include "gpio.h"

/********** module define  **********/
module gpio (
	/**********  &  **********/
	input  wire						clk,	 //
	input  wire						reset,	 //
	/********** bus interface signals  **********/
	input  wire						cs_,	 // chip select
	input  wire						as_,	 // address select
	input  wire						rw,		 // Read / Write
	input  wire [`GpioAddrBus]		addr,	 // gpio address bus
	input  wire [`WordDataBus]		wr_data, // write data
	output reg	[`WordDataBus]		rd_data, // read data
	output reg						rdy_	 // read ready
	/**********  **********/
`ifdef GPIO_IN_CH	 //
	, input wire [`GPIO_IN_CH-1:0]	gpio_in	 // gpio input
`endif
`ifdef GPIO_OUT_CH	 //
	, output reg [`GPIO_OUT_CH-1:0] gpio_out // output
`endif
`ifdef GPIO_IO_CH	 //
	, inout wire [`GPIO_IO_CH-1:0]	gpio_io	 // input output
`endif
);

`ifdef GPIO_IO_CH	 //
	/**********  **********/
	wire [`GPIO_IO_CH-1:0]			io_in;	 // internal input
	reg	 [`GPIO_IO_CH-1:0]			io_out;	 // internal output
	reg	 [`GPIO_IO_CH-1:0]			io_dir;	 // internal direction
	reg	 [`GPIO_IO_CH-1:0]			io;		 // input output
	integer							i;		 //

	/********** input output assign **********/
	assign io_in	   = gpio_io;			 //
	assign gpio_io	   = io;				 //

	/********** gpio direction control **********/
	always @(*) begin
		for (i = 0; i < `GPIO_IO_CH; i = i + 1) begin : IO_DIR
			io[i] = (io_dir[i] == `GPIO_DIR_IN) ? 1'bz : io_out[i];
		end
	end

`endif

	/********** GPIO control  **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* reset */
			rd_data	 <= #1 `WORD_DATA_W'h0;
			rdy_	 <= #1 `DISABLE_;
`ifdef GPIO_OUT_CH	 //
			gpio_out <= #1 {`GPIO_OUT_CH{`LOW}};
`endif
`ifdef GPIO_IO_CH	 // gpio in out port
			io_out	 <= #1 {`GPIO_IO_CH{`LOW}};
			io_dir	 <= #1 {`GPIO_IO_CH{`GPIO_DIR_IN}};
`endif
		end else begin
			/*  */
			if ((cs_ == `ENABLE_) && (as_ == `ENABLE_)) begin
				rdy_	 <= #1 `ENABLE_;
			end else begin
				rdy_	 <= #1 `DISABLE_;
			end
			/* read control register  */
			if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) && (rw == `READ)) begin
				case (addr)
`ifdef GPIO_IN_CH	//
					`GPIO_ADDR_IN_DATA	: begin // control reg  0
						rd_data	 <= #1 {{`WORD_DATA_W-`GPIO_IN_CH{1'b0}},
										gpio_in};
					end
`endif
`ifdef GPIO_OUT_CH	//
					`GPIO_ADDR_OUT_DATA : begin // control reg  1
						rd_data	 <= #1 {{`WORD_DATA_W-`GPIO_OUT_CH{1'b0}},
										gpio_out};
					end
`endif
`ifdef GPIO_IO_CH	//
					`GPIO_ADDR_IO_DATA	: begin // control reg  2
						rd_data	 <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'b0}},
										io_in};
					 end
					`GPIO_ADDR_IO_DIR	: begin // control reg  3
						rd_data	 <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'b0}},
										io_dir};
					end
`endif
				endcase
			end else begin
				rd_data	 <= #1 `WORD_DATA_W'h0;
			end
			/* write control reg */
			if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) && (rw == `WRITE)) begin
				case (addr)
`ifdef GPIO_OUT_CH	//
					`GPIO_ADDR_OUT_DATA : begin // creg 1
						gpio_out <= #1 wr_data[`GPIO_OUT_CH-1:0];
					end
`endif
`ifdef GPIO_IO_CH	// 
					`GPIO_ADDR_IO_DATA	: begin // creg 2
						io_out	 <= #1 wr_data[`GPIO_IO_CH-1:0];
					 end
					`GPIO_ADDR_IO_DIR	: begin // creg 3
						io_dir	 <= #1 wr_data[`GPIO_IO_CH-1:0];
					end
`endif
				endcase
			end
		end
	end

endmodule
