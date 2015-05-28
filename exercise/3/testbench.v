// 信号源模型：
`timescale 1ns/10ps
`define 	clk_cycle  	10
`include  "./fdivision.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。


module  testbench;

reg clk_in ,reset;

wire clk_out;

always   # `clk_cycle   clk_in  = ~clk_in ;



initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("wave.vcd");
	$dumpvars;
	clk_in = 0;
	reset =0 ;

	#5000    reset  =  1 ;
	#5000    reset  =  0 ;
	#5000    reset  =  1 ;
	#5000  $finish;
	
	//

end

fdivision		 u1(   
	.RESET(reset),
	.F10MB(clk_in),
	.F500KB(clk_out)
	) ;


endmodule   
