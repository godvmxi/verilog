// ä¿¡å·æºæ¨¡åž‹ï¼š
`timescale 1ns/1ns

`include  "./alu.v"   //  åŒ…å«æ¨¡å—æ–‡ä»¶ã€‚åœ¨æœ‰çš„ä»¿çœŸè°ƒè¯•çŽ¯å¢ƒä¸­å¹¶ä¸éœ€è¦æ­¤è¯­å¥ã€?
`include  "./practice.v"

module testbench;
    reg[7:0] a,b;
    reg[2:0]  opcode ;
    wire[7:0] out;
    parameter times = 30 ;
//for practice
    wire[3:0]  out2 ;
    reg[2:0]    sel;
    reg[3:0]   in0,in1,in2,in3,in4,in5,in6,in7 ;

  
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
        a =  {$random} % 256 ;
        b =  {$random} % 256 ;
        opcode = 3'b0  ;
        sel= 3'b0;
        in0 = 3'b0 ;
        in1 = 3'b0 ;
        in2 = 3'b0 ;
        in3 = 3'b0 ;
        in4 = 3'b0 ;
        in5 = 3'b0 ;
        in6 = 3'b0 ;
        in7 = 3'b0 ;
        repeat (times) begin
        #100  a =  {$random} % 256 ;
        b =  {$random} % 256 ;
        opcode = opcode + 1 ;
        //for practice testbench
        in0 = {$random} % 14 ;
        in1 = {$random} % 14 ;
        in2 = {$random} % 14 ;
        in3 = {$random} % 14 ;
        in4 = {$random} % 14 ;
        in5 = {$random} % 14 ;
        in6 = {$random} % 14 ;
        in7 = {$random} % 14 ;
        sel = sel + 1;

        end
        #100  $finish ;
    end

    alu       u1(.out(out),.opcode(opcode),.a(a),.b(b));
    mux8to1   u2(sel,out2,in0,in1,in2,in3,in4,in5,in6,in7);


endmodule


