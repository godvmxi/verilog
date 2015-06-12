
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
`timescale 1ns/100ps
`include "./sort4.v"
`include "./practice.v"

module Testbench;

	reg[3:0] a,b,c,d;
 	wire[3:0] ra,rb,rc,rd;
  reg[7:0] a1,b1,c1;
  reg clk ;
  reg rst ;
  wire[7:0] oa,ob,oc;
 always #10 clk <= ~clk ;
 initial  begin
  		$dumpfile("wave.vcd");
      $dumpvars;
      clk = 0;
    	a=0;b=0;c=0;d=0;
      rst  = 1;
		repeat(5)
		begin 
      		#100  a ={$random}%15;
        	b ={$random}%15;  
        	c ={$random}%15;
        	d ={$random}%15;
          a1 ={$random}%256;
          b1 ={$random}%256;  
          c1 ={$random}%256;


		end
    rst  = 0;
    repeat(50)
    begin 
          #100  a ={$random}%15;
          b ={$random}%15;  
          c ={$random}%15;
          d ={$random}%15;
          a1 ={$random}%256;
          b1 ={$random}%256;  
          c1 ={$random}%256;


    end
      
    	#100 $finish;
end
    
sort4 sort4 (.a(a),.b(b),.c(c),.d(d), .ra(ra),.rb(rb),.rc(rc),.rd(rd));
bubble bubble1(.rst(rst),.clk(clk),.a(a1),.b(b1),.c(c1), .oa(oa),.ob(ob),.oc(oc) );



endmodule






