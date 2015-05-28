//i do not know ,will add later 
module half_div_no_rst(clk_in,clk_out) ;
input clk_in ;
output clk_out ;
reg clk_out;
initial begin
	clk_out <= 0;
end
always @(posedge clk_in)   begin 
	clk_out <= ~clk_out;
end

endmodule

module duty_div_x_no_rst(clk_in,clk_out,x) ;
input clk_in ;
input[3:0] x ;
output clk_out ;
reg clk_out;
reg[3:0] counter ;
initial begin
	clk_out <= 0;
	counter <=  0;
end
always @(posedge clk_in)   begin 
	counter =  counter + 1 ;
	if (counter === x )  begin 
		clk_out <= ~clk_out;
		counter <= 0 ;
	end

end

endmodule

/*
module duty_div_x_y_no_rst(clk_in,clk_out,x,y) ;
input clk_in ;
input[3:0] x;
input[3:0] y;
output clk_out ;
reg clk_out;
initial begin
	clk_out <= 0;
end
always @(posedge clk_in)   begin 
	clk_out <= ~clk_out;
end

endmodule

*/