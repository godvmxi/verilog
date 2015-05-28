// 信号源模型：
`timescale 1ns/1ns       // 定义时间单位。

`include  "./compare.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。
`include   "./practice.v"

//而需要从调试环境的菜单中键入有关模块文件的路径和名称

module t;

reg a,b;
reg[7:0]  in_a;
reg[7:0]  in_b;

wire equal1;
wire equal2;
wire equal3;

initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("test.vcd");
	$dumpvars;
	a=0;
	b=0;
	in_a = 8'h0;
	in_b = 8'h10;

	#100   a=0; b=1;
	in_a = 8'h10;
	in_b = 8'h10;
	#100   a=1;
	in_a = 8'h20;
	in_b = 8'h10;
	b=1;
	#100
	in_a <= 8'h10;
	in_b <= 8'h20;
	a=1; b=0;
	#100
	a=0;
	b=0;
	#100
	$finish;
	//

end



compare1 m1(.equal(equal1),.a(a),.b(b));
compare2 m2(.equal(equal2),.a(a),.b(b));

compare8 m8 (.in_a(in_a) ,.in_b (in_b),.out(equal3));



endmodule   
