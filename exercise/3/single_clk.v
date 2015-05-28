module single_clk(rst,start ,clk_in ,clk_out);
input rst ;  // set to 0 ,reset
input clk_in;
input start ; // every start 0->1 ,generate a __-----___  wave
output clk_out;

reg clk_out;
reg start_flag ;
`define  delay_uint   5
`define  clk_last_1   20
`define  clk_last_2   30
`define  clk_last_3   50
reg[7:0]  counter ;
always @(posedge clk_in ) begin 
	if (!rst) begin 
		counter <= 0;
		clk_out = 1'bz;
		start_flag <= 0;
	end
	else begin 
		if(start_flag) begin 
			counter <= counter + 1;
			if (counter < `clk_last_1 )
				clk_out <= 0;
			else if ( counter < `clk_last_2 )
				clk_out <= 1;
			else if (counter < `clk_last_3 )
				clk_out <= 0;
			else begin 
				clk_out <= 1'bz;
				start_flag <=  0;
			end
		end 
		else begin 
			clk_out <= 1'bz;	
		end
	end
end
always @(posedge start) begin 
	counter <= 0;
	start_flag <= 1 ;
end

endmodule

