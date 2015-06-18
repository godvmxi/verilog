`timescale 1ns/1ns
`include "./seqdet.v"
`include "./practice.v"
module seqdet_top;
  reg clk,rst;
  reg[23:0] data;
  wire[2:0] state;
  wire out,x;

  // module seqdet1111
  reg[23:0] data2;
  wire[2:0] state2;
  wire out2,x2;
  

  assign x=data[23];
  assign x2=data2[23];
  always  #10 clk = ~clk;
  always @(posedge clk)
      data={data[22:0],data[23]};  //形成数据向左移环行流，最高位与x 连接
  always @(posedge clk)
      data2={data2[22:0],data2[23]};  //形成数据向左移环行流，最高位与x 连接

  
  initial
     begin
     $dumpfile("wave.vcd");
      $dumpvars;
       clk=0;
       rst=1;
       #2 rst=0;
       #30 rst=1;
       data ='b1100_1001_0000_1001_0100;
       data2 ='b1111_1101_01111_1001_0100;
       #500 $finish;
     end
  
  seqdet  m(x,out,clk,rst,state);


  seqdet1111 m1(x2,out2,clk,rst,state2) ;
         
endmodule                 