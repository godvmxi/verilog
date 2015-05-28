
module fdivision(RESET,F10MB,F500KB);
input RESET;
input F10MB;
output F500KB;
reg F500KB;
reg[7:0]counter ;
always @(posedge F10MB) begin
	if (!RESET)  begin
		counter <= 8'd0;	
		F500KB  <= 0;		
	end
	else  begin 
		if (counter == 9) begin
			counter <= 8'd0;
			F500KB <=  ~F500KB;	
		end
		else 
			counter <= counter + 1;
	end
end

endmodule
