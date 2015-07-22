moudule ps2scan(clk,rst,ps2_clk,ps2_dat,key_value) ;
input clk ;
input rst ;
input ps2_clk ;
input ps2_dat ;
output[7:0] key_value ;
reg[7:0] key_value ;
reg[7:0] state ;

always @(clk,rst ,ps2_clk ){
	if (!rst )  begin 
		key_value =  8'h00;
		state  <= 8'h0;
	end
	else begin 
		
	end
}