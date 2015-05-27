// 信号源模型：
`timescale 1ns/1ns       // 定义时间单位。

`include  "./compare.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。

//而需要从调试环境的菜单中键入有关模块文件的路径和名称

module t;

reg a,b;

wire equal1;
wire equal2;

initial              // initial常用于仿真时信号的给出。
	begin 
	$dumpfile("test.vcd");
	$dumpvars;
	a=0;
	b=0;
	#100   a=0; b=1;
	#100   a=1;
	b=1;
	#100
	a=1; b=0;
	#100
	a=0;
	b=0;
	#100
	$stop;
	//

end



compare1 m1(.equal(equal1),.a(a),.b(b));
compare2 m2(.equal(equal2),.a(a),.b(b));



endmodule   
