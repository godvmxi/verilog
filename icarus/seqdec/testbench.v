/*
* finite state machine----FSM
* testbench file for Detector110.v
* 有限状态机的实例
* 2012/05/22
* Iverilog + GTKWave in windows XP sp3
* */

`timescale 1ns/100ps

module test;
reg aa, clk, rst;
wire ww;
Detector110 UUT(aa, clk, rst, ww);

initial
begin
	aa = 0;
	clk = 0;
	rst = 1;
end

initial
	repeat (44) #7 clk = ~clk;

initial
	repeat (15) #23 aa = ~aa;

initial
begin
	#31 rst = 1;
	#23 rst = 0;
end

always @ (ww)
	if(ww == 1)
		$display("A 1 was detector on w at time = %t,",$time);

	initial
	begin            
	$dumpfile("test.vcd");
	$dumpvars;
end
endmodule
