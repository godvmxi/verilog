// 信号源模型：
`timescale 1ns/1ns

`include  "./alu.v"   //  包含模块文件。在有的仿真调试环境中并不需要此语句。


module testbench;
  wire[7:0]    out ;
  
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





