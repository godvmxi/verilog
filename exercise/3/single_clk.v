module single_clk(rst,start ,clk_in ,clk_out);
input rst ;  // set to 0 ,reset
input clk_in;
input start ; // every start 0->1 ,generate a __-----___  wave
output clk_out;

reg clk_out;
`define  delay_uint   5
`define  clk_last_1   20
`define  clk_last_2   10
`define  clk_last_3   20
reg[7:0]  i ;
always @(posedge start) begin 
	if (!rst) begin 
		clk_out = 0 ;
		for (i = 0;i< `clk_last_1 ; i = i + 1)
		begin 
			@(posedge clk_in) ;
			# `delay_uint;
		end
		clk_out = 1 ;
		for (i = 0;i< `clk_last_2 ; i = i + 1)
		begin 
			@(posedge clk_in) ;
			# `delay_uint;
		end
		clk_out = 0 ;
		for (i = 0;i< `clk_last_3 ; i = i + 1)
		begin 
			@(posedge clk_in) ;
			# `delay_uint;
		end
		clk_out = 1'bz ;
	end
	else begin 
			clk_out = 1'bz ;
	end 

end

endmodule

