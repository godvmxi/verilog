// 信号源模型：
`timescale 1ns/100ps
`include "./tryfunct.v"
`include "./practice.v"

`define clk_cycle 50

module Testbench;

	reg[3:0] n,i;
	reg reset,clk;

	wire[31:0] result ;
	wire[7:0] out1,out2,out3;
	always #`clk_cycle clk <= ~clk;	
	initial  begin
        $dumpfile("wave.vcd");
        $dumpvars;
		clk=0;
		n=0;
		i = 0;
		reset=1;
		#100 reset=0;  //产生复位信号的负跳沿
		#100 reset=1;  //复位信号恢复高电平后才开始输入n 
		//for(i=0;i<=15;i=i+1)	begin
		repeat(16)	begin
			$display("cal -> %d\n",i);
			#200 n=i;
			i = i + 1;
		end
		//#100 $stop;
		$finish;
	end


	tryfunct  m0(.clk(clk),.n(n),.result(result),.reset(reset));
	tryfunct2 m1(.clk(clk),.n(n),.out(out1),.opcode(3'd0),.reset(reset));
	tryfunct2 m2(.clk(clk),.n(n),.out(out2),.opcode(3'd1),.reset(reset));
	tryfunct2 m3(.clk(clk),.n(n),.out(out3),.opcode(3'd2),.reset(reset));

endmodule






