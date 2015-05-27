//
//
//
//
`include "signal.v"
`include "eeprom.v"
`include "eeprom_wr.v" 
`timescale 1ns/1ns
module Top;
wire RESET;
wire CLK;
wire RD,WR;
wire ACK;
wire[10:0] ADDR;
wire[7:0]  DATA; 
wire SCL;
wire SDA;
Signal         signal(.RESET(RESET),.CLK(CLK),.RD(RD),
	.WR(WR),.ADDR(ADDR),.ACK(ACK),.DATA(DATA));
EEPROM_WR   eeprom_wr(.RESET(RESET),.SDA(SDA),.SCL(SCL),.ACK(ACK),
	.CLK(CLK),.WR(WR),.RD(RD),.ADDR(ADDR),.DATA(DATA));
EEPROM         eeprom(.sda(SDA),.scl(SCL));  

endmodule

