//???
//--------------------------------------------------------------
module accum( accum, data, ena, clk1, rst);
output[7:0]accum;
input[7:0]data;
input ena,clk1,rst;
reg[7:0]accum;

always@(posedge clk1)
begin
if(rst)
accum<=8'b0000_0000;		//Reset
else
if(ena)		//?CPU???????load_acc??
accum<=data;		//Accumulate
	end

endmodule
