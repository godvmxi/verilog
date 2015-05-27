//?????
//------------------------------------------------------------------------------
module machinectl( ena, fetch, rst);
output  ena;
input  fetch, rst;
reg ena;

always @(posedge fetch or posedge rst)
begin
if(rst)
ena<=0;
else
ena<=1;
end

endmodule
//----------------------------------------------------------------------------