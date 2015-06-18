`timescale 1ns/100ps


module  seqdet1111( x,out,clk,rst,status);
input  clk , rst ,x;
output out;

output[2:0] status ;

reg[2:0]  status ;
reg out;
parameter IDLE='d0,  A='d1,  B='d2,
                     C='d3,  D='d4;


always @(posedge clk ) begin 
	if(!rst) begin
		out <= 0;
		status <= IDLE ;
	end
	else begin
		case ( status )
			IDLE : begin 
				if ( x == 1)
					status <= A ;
				else begin 
					status <= IDLE ;
					out <= 0;
				end 
			end
			A :begin 
				if ( x == 1)
					status <= B ;
				else 
					status <= IDLE ;
			end
			B :begin 
				if ( x == 1)
					status <= C ;
				else 
					status <= IDLE ;
			end
			C :begin 
				if ( x == 1) begin 
					status <= D ;
					out <=  1;
				end 
				else 
					status <= IDLE ;

			end
			D :begin 
				if ( x == 1) begin 
					status <= D ;
					out <=  1;
				end
				else begin
					status <= IDLE ;
					out <= 0;
				end

			end
			default :begin 
					status <= IDLE ;
					out <= 0;
			end 

		endcase
	end
end

endmodule 
