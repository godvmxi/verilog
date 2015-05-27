//����ģ�飺
/****************************************************************************
ģ�����ƣ�Top  �ļ�����top.v
ģ�鹦�ܣ����ڰѲ��������źŵ�ģ�飨Signal������Ƶľ���ģ�飨EEPROM_WR��
          �Լ�EEPROM����ģ������������ģ�飬����ȫ����ԡ�
ģ��˵������ģ��Ϊ��Ϊģ�飬�����ۺ�Ϊ�ż�����������EEPROM_WR�����ۺ�
          Ϊ�ż��������Կ��Զ�����Ƶ�EEPROM ��д�������ż�����档
****************************************************************************/
 `include "./Signal.v"
 `include "./EEPROM.v"
 `include "./EEPROM_WR.v"  //������EEPROM_WRģ����Ӧ��Verilog�ż��������滻
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
//------------ top.v �ļ��Ľ���---------------

