// 信号源模型：
`timescale 1ns/10ps
`define 	clk_cycle  	10
`include  "./blocking.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。
`include  "./non_blocking.v" 
`include  "./thinking.v" 

module compareTop;

  wire [3:0] b1,c1,b2,c2,tb1,tb2,tc1,tc2;
  reg  [3:0] a;
  reg        clk;
  
  initial
  begin
  	$dumpfile("wave.vcd");
	$dumpvars;
    clk = 0;
    forever #50 clk = ~clk;  //思考：如果在本句后还有语句，能否执行？为什么？
  end
  
 initial
  begin
    a = 4'h3;
    $display("____________________________");
    # 100 a = 4'h7;
    $display("____________________________");
    # 100 a = 4'hf;
    $display("____________________________");
    # 100 a = 4'ha;
    $display("____________________________");
    # 100 a = 4'h2;
    $display("____________________________");
    # 100  $display("____________________________");
    $finish;
  end
  non_blocking  nb(clk,a,b2,c2);
  blocking      b (clk,a,b1,c1);
  thinking1      t1(clk,a,tb1,tc1);
  thinking2      t2(clk,a,tb2,tc2);

endmodule





