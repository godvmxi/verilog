
/*
                   _ooOoo_
                  o8888888o
                  88" . "88
                  (| -_- |)
                  O\  =  /O
               ____/`---'\____
             .'  \\|     |//  `.
            /  \\|||  :  |||//  \
           /  _||||| -:- |||||-  \
           |   | \\\  -  /// |   |
           | \_|  ''\---/''  |   |
           \  .-\__  `-`  ___/-. /
         ___`. .'  /--.--\  `. . __
      ."" '<  `.___\_<|>_/___.'  >'"".
     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
     \  \ `-.   \_ __\ /__ _/   .-` /  /
======`-.____`-.___\_____/___.-`____.-'======
                   `=---='
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         佛祖保佑       永无BUG
*/

// 信号源模型：
`timescale 1ns/10ps
`define 	clk_cycle  	20
`include  "./half_clk.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。
`include  "./thinking.v" 

module  testbench;

reg clk_in ,reset;

wire clk_out;
wire clk_out_n;
wire clk_out_no_rst;
wire clk_duty_div_x_no_rst;

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
half_div_no_rst		 u2(   
	.clk_in(clk_in),
	.clk_out(clk_out_no_rst)
	) ;

duty_div_x_no_rst  u3(
	.clk_in(clk_in),
	.clk_out(clk_duty_div_x_no_rst),
	.x(4)
	);

endmodule   
