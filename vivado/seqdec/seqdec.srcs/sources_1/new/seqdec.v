`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2015 06:42:59 PM
// Design Name: 
// Module Name: seqdec
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


module seqdec(x,z,clk,rst );
input x,clk,rst;
output z;

reg[2:0] state ;  //state station

wire z;

parameter  IDLE = 3'd0,
            A   = 3'd1,
            B   = 3'd2,
            C   = 3'd3,
            D   = 3'd4,
            E   = 3'd5,
            F   = 3'd6,
            G   = 3'd7;
 
assign  z = ( state == D && x == 0)  ? 1: 0;

always @( posedge clk or negedge rst) 
    if ( !rst )
        begin
            state = IDLE ;
        end
    else 
        casex ( state ) 
            IDLE :
				if ( x == 0)
					state <= IDLE ;
				else 
					state <= A ;
			A   :
				if ( x == 0 )
					state <= B ;
				else 
					state <= A ;
			B   :
				if ( x == 0 )
					state <= C ;
				else 
					state <= F ;
			C   :
				if ( x == 0)
					state <= G ;
				else 
					state <= D;
			D   :
				if ( x == 0 )
					state <= E ;
				else 
					state <= A ;
			E   :
				if ( x == 0 )
					state <= C ;
				else 
					state <= A ;
			F   :
				if ( x == 0 )
					state <= B ;
				else 
					state <= A ;
			G   :
				if ( x == 0 )
					state <= B ;
				else 
					state <= F ;
			default :
					state <= IDLE ;
		endcase 
endmodule
         
            
