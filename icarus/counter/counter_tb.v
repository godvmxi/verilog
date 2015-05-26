module test;
	reg reset = 0;

initial begin 
	$display("@@begin testbench @@");
	#17 reset = 1;
	#11 reset = 0;
	#29 reset = 1;
	#11 reset = 0;
	#100 $finish ;
end 
reg clk = 0;
always #5 clk = ~clk ;
wire[7:0] value ;
counter c1(value,clk,reset);
endmodule
