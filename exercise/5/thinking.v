module thinking1(clk,a,b,c);
  output [3:0] b,c;
  input  [3:0] a;
  input        clk;
  reg    [3:0] b,c;
  always @(posedge clk)
   begin    
    c = b;
    b = a;
    $display("Blocking: a = %d, b = %d, c = %d ",a,b,c); 
   end 
endmodule

module thinking2(clk,a,b,c);
  output [3:0] b,c;
  input  [3:0] a;
  input        clk;
  reg    [3:0] b,c;
  always @(posedge clk)   b = a ; // this will block next always block ????? why ??
  always @(posedge clk)   c = b ;

endmodule