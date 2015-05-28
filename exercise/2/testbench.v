// 信号源模型：
`timescale 1ns/10ps
`define 	clk_cycle  	20
`include  "./half_clk.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。


module  testbench;

reg clk_in ,reset;

wire clk_out;
wire clk_out_n;

always   # `clk_cycle   clk_in  = ~clk_in ;



initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("wave.vcd");
	$dumpvars;
	clk_in = 0;
	reset =0 ;

	#200    reset  =  1 ;
	#1000  $finish;
	
	//

end

half_clk		 u1(   
	.reset(reset),
	.clk_in(clk_in),
	.clk_out(clk_out),
	.clk_out_n(clk_out_n)
	) ;


endmodule   
