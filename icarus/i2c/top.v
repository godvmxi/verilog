//顶层模块：
/****************************************************************************
模块名称：Top  文件名：top.v
模块功能：用于把产生测试信号的模块（Signal）与设计的具体模块（EEPROM_WR）
          以及EEPROM虚拟模块连接起来的模块，用于全面测试。
模块说明：本模块为行为模块，不可综合为门级网表。但其中EEPROM_WR可以综合
          为门级网表，所以可以对所设计的EEPROM 读写器进行门级后仿真。
****************************************************************************/
 `include "./Signal.v"
 `include "./EEPROM.v"
 `include "./EEPROM_WR.v"  //可以用EEPROM_WR模块相应的Verilog门级网表来替换
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
//------------ top.v 文件的结束---------------

