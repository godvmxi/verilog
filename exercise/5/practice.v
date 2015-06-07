module mux8to1(sel,out,in0,in1,in2,in3,in4,in5,in6,in7);
    input[2:0] sel ;
    output [3:0] out;
    input  [3:0] in0,in1,in2,in3,in4,in5,in6,in7 ;
    reg[3:0] out;


    always @(sel or in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7)  begin
        case (sel) 
            3'd0 :  out <= in0;
            3'd1 :  out <= in1;
            3'd2 :  out <= in2;
            3'd3 :  out <= in3;
            3'd4 :  out <= in4;
            3'd5 :  out <= in5;
            3'd6 :  out <= in6;
            3'd7 :  out <= in7;
            default : out <= 3'dz;
        endcase
    end
endmodule
