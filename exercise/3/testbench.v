// 信号源模型：
`timescale 1ns/100ps
`define 	clk_cycle  	50
`include  "./single_clk.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。

module  testbench;

reg clk_in ,reset, start;

wire clk_out;
`define   start_last    50000
always   # `clk_cycle   clk_in  = ~clk_in ;



initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("wave.vcd");
	$dumpvars;
	clk_in = 0;
	clk_out = 1'z;
	reset =0 ;
	start = 0;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#100    reset  =  1 ;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#`start_last  start = 1;
	#`start_last  start = 0;
	#100  $finish;
	
	//

end

single_clk	 u1(   
	.rst(reset),
	.start(start),
	.clk_in(clk_in),
	.clk_out(clk_out)
	) ;


endmodule   
