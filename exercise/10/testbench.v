`timescale 1ns/100ps
`include "./eeprom_controler.v"
`define clk_cycle 50
module writingTop;
  reg reset,clk;
  reg[7:0] data,address;
  wire ack,sda;
  
  always #`clk_cycle  clk = ~clk;
  
  initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars;
        clk=0;
        reset=1;
        data=8'he;
        address=8'he;
        #(2*`clk_cycle) reset=0;
        #(2*`clk_cycle) reset=1;
      #(200*`clk_cycle) $finish;
    end
    
  always @(posedge ack)      //接收到应答信号后，给出下一个处理对象。
    begin
        data=data+8'hf;
        address=address+8'hf;
    end       
  writing writing(.reset(reset),.clk(clk),.data(data),
                  .address(address),.ack(ack),.sda(sda));  
endmodule              