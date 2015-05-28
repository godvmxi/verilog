
module half_clk(reset,clk_in,clk_out,clk_out_n);
input clk_in,reset;
output clk_out;
output clk_out_n;
reg clk_out;
reg clk_out_n;

always @(posedge clk_in)
	begin
		if(!reset)  begin
			clk_out=0;
			clk_out_n = 1;
		end

		else     begin
			clk_out=~clk_out;
			clk_out_n=~clk_out_n;
		end
	end
	
endmodule
