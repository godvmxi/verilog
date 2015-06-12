`timescale 1ns/100ps


module  bubble( clk,rst,a,b,c,oa,ob,oc );

input  clk , rst ;
input[7:0] a ,b,c;
output[7:0] oa,ob,oc;
reg[7:0] oa,ob,oc ;
reg[7:0] va,vb,vc ;


always @(posedge clk ) begin 
	if(rst) 
		{oa,ob,oc} = {8'bz,8'bz,8'bz};
	else begin
		{va ,vb ,vc } = {a , b , c } ;
		compare(va,vb);
		compare(vb,vc);
		compare(va,vb);
		{oa ,ob ,oc } = {va , vb , vc } ;
	end
end

task compare ;
	inout[7:0] x,y;
    reg[7:0] tmp;
    if ( x > y ) begin
    	tmp = x ;
    	x = y ;
    	y = tmp ;
    end
endtask
endmodule 
