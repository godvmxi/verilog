`timescale 1ns/100ps
`define opcode_square  		3'd0 
`define opcode_cubic   		3'd1
`define opcode_factorial  	3'd2 

module  tryfunct2( 
	clk,
	reset ,
	n ,
	opcode ,
	out 
);
input  clk ;
input  reset ;
input[3:0]  n ;
input[2:0] opcode ;
output[7:0] out ;
reg[7:0] out;
always @(posedge clk ) begin 
	if(reset == 1'b0)
		out <= 0'hz ;
	else begin
	//	$display("test function");
		case (opcode) 
			`opcode_square : out <=  square (n) ;
			`opcode_cubic  : out <=  cubic(n);
			`opcode_factorial : out <= factorial(n);
			default : out <= 8'bz;
		endcase
	end
end
function[7:0] square ;
	input[3:0]     n ;
	square = n * n ;
endfunction 
function [7:0] cubic   ;
	input[3:0]     n ;
	cubic = n * n  * n;
endfunction 
function [7:0] factorial   ;
	input[3:0]     n ;
	reg[3:0]   index ;
	begin 
 		factorial =  n  ? 1 : 0;  //先定义操作数为零时函数的输出为零，不为零时为1
		for(index = 1; index <= n ;index = index+1 )
			factorial = factorial * index ;
	end 
endfunction 
endmodule 
