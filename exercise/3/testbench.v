// 信号源模型：
`timescale 1ns/1ns
`define 	clk_cycle  	50
`include  "./single_clk.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。
`include  "./fdivision.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。

module  testbench;

wire clk_out1;
wire clk_out2;
reg clk_in ,reset, start;

`define   start_last    100000
always   # `clk_cycle   clk_in  = ~clk_in ;  //10MHz



initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("wave.vcd");
	$dumpvars;
	clk_in  = 1'b0;
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

fdivision	 u1(   
	.RESET(reset),
	.F10MB(clk_in),
	.F500KB(clk_out_f500kb)
	) ;
single_clk	 u2(   
	.rst(reset),
	.start(start),
	.clk_in(clk_in),
	.clk_out(clk_out_single_clk)
	) ;


endmodule   
