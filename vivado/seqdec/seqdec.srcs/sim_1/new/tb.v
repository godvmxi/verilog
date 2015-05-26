`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2015 06:43:19 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////





module tb;

reg clk , rst ;
reg[23:0] data ;
wire z ,x ;
assign  x = data[23];

initial 
	begin 
		clk = 0;
		rst = 1 ;
		#2 rst = 0;
		#30 rst = 1 ;
		data = 20 'b1100_1001_0000_1001_0100 ;
		# 20000  $stop ;
	end


always #20 clk = ~clk ;
always @ (posedge clk )
	#2 data = { data[22:0] ,data[23] };

seqdec m (
	.x( x ) ,
	.z( z ) ,
	.clk ( clk ),
	.rst( rst )
);

endmodule
