module compare8(in_a,in_b,out);
input[7:0] in_a ;
input[7:0] in_b ;
output out;
assign  out =  in_a  > in_b ? 1 : 0;
endmodule