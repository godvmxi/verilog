/****************************************************************************
ģ�����ƣ�EEPROM  �ļ�����eeprom.v
ģ�鹦�ܣ�����ģ����ʵ��EEPROM��AT24C02/4/8/16�� �������д�Ĺ��ܡ����ڷ���
          AT24C02/4/8/16 Ҫ���scl��sda �����/д�ź��ܸ���I2CЭ�飬����
          �京�岢������Ӧ�Ķ�/д������
ģ��˵������ģ��Ϊ��Ϊģ�飬�����ۺ�Ϊ�ż��������ұ�ģ��Ϊ��ѧĿ��������
          ��򻯣����ܲ�����������������ҵĿ�ġ�
****************************************************************************/

`timescale 1ns/1ns
`define timeslice 100
module EEPROM(scl, sda);	 	
input  scl;    //����ʱ����
inout  sda;    //����������
reg out_flag;  //SDA��������Ŀ����ź�
reg[7:0]  memory[2047:0];
reg[10:0] address; 
reg[7:0]  memory_buf;
reg[7:0]  sda_buf;   //SDA ��������Ĵ���
reg[7:0]  shift;     //SDA ��������Ĵ���
reg[7:0]  addr_byte; //EEPROM �洢��Ԫ��ַ�Ĵ���
reg[7:0]  ctrl_byte; //�����ּĴ���
reg[1:0]  State;     //״̬�Ĵ���
integer i;

//--------------------------------------------------------------
parameter 	  r7= 8'b10101111,w7= 8'b10101110,         //main7
      		  r6= 8'b10101101,w6= 8'b10101100,         //main6
 		      r5= 8'b10101011,w5= 8'b10101010,         //main5
		      r4= 8'b10101001,w4= 8'b10101000,         //main4
 		      r3= 8'b10100111,w3= 8'b10100110,         //main3
 		      r2= 8'b10100101,w2= 8'b10100100,         //main2
 		      r1= 8'b10100011,w1= 8'b10100010,         //main1
 		      r0= 8'b10100001,w0= 8'b10100000;         //main0
//--------------------------------------------------------------
assign sda = (out_flag == 1) ? sda_buf[7] : 1'bz; 

//----------�Ĵ����ʹ洢����ʼ��---------
initial
  begin
    addr_byte     = 0;
    ctrl_byte     = 0; 
    out_flag      = 0;
    sda_buf       = 0;
    State         = 2'b00;
    memory_buf    = 0;
    address       = 0;
    shift         = 0;
    for(i=0;i<=2047;i=i+1)
      memory[i]=0;
  end
//------------ �����ź� -----------------------------
always @ (negedge sda)  
  if(scl == 1 )
    begin
      State = State + 1;
      if(State == 2'b11)
         disable write_to_eeprm;
    end

//------------ ��״̬�� --------------------------
always @(posedge sda)            
  if (scl == 1 )      //ֹͣ����         
    stop_W_R;
  else 
    begin
     casex(State)
         2'b01:
   	         begin  
   	           read_in;
                   if(ctrl_byte==w7||ctrl_byte==w6||ctrl_byte==w5
                      ||ctrl_byte==w4||ctrl_byte==w3||ctrl_byte==w2
                      ||ctrl_byte==w1||ctrl_byte==w0)
	              begin
	                State = 2'b10;
	                write_to_eeprm;  //д���� 
	               end
	           else
	             State = 2'b00;
	         end
	
         2'b11:    
               read_from_eeprm;      //������            

     default:  
               State=2'b00;  
		   
   endcase
  end  //��״̬������

//------------- ����ֹͣ------------------------------
task stop_W_R;
  begin
    State =2'b00;  //״̬����Ϊ��ʼ״̬
    addr_byte  = 0;
    ctrl_byte  = 0;
    out_flag  = 0;
    sda_buf   = 0;
  end
endtask

//------------- ���������ֺʹ洢��Ԫ��ַ ------------------------
task  read_in;
  begin
    shift_in(ctrl_byte);
    shift_in(addr_byte);   
  end
endtask

//------------EEPROM ��д����---------------------------------------
task write_to_eeprm;
  begin
    shift_in(memory_buf);    
    address          = {ctrl_byte[3:1],addr_byte};
    memory[address]  = memory_buf;	
    $display("eeprm----memory[%0h]=%0h",address,memory[address]);   
    State =2'b00;             //�ص�0״̬
  end
endtask

//-----------EEPROM �Ķ�����----------------------------------------
task read_from_eeprm;
  begin 
    shift_in(ctrl_byte);
    if(ctrl_byte==r7||ctrl_byte==r6||ctrl_byte==r5||ctrl_byte==r4
       ||ctrl_byte==r3||ctrl_byte==r2||ctrl_byte==r1||ctrl_byte==r0)
      begin
        address = {ctrl_byte[3:1],addr_byte};		
	     sda_buf = memory[address];
	     shift_out;
	     State= 2'b00;
      end
  end	   
endtask   
 	   
//-----SDA �������ϵ����ݴ���Ĵ�����������SCL�ĸߵ�ƽ��Ч-------------
task shift_in;
 output [7:0] shift; 
  begin
     @ (posedge  scl) shift[7] = sda;  
     @ (posedge  scl) shift[6] = sda;
     @ (posedge  scl) shift[5] = sda;
     @ (posedge  scl) shift[4] = sda;
     @ (posedge  scl) shift[3] = sda; 
     @ (posedge  scl) shift[2] = sda;
     @ (posedge  scl) shift[1] = sda;
     @ (posedge  scl) shift[0] = sda;
     @ (negedge scl)      
       begin 	
         #`timeslice ;
      	 out_flag = 1;     //Ӧ���ź����
          sda_buf  = 0;  
       end
     @(negedge scl)
        #`timeslice out_flag  = 0;  
  end
endtask

//----EEPROM �洢���е�����ͨ��SDA �����������������SCL �͵�ƽʱ�仯
task shift_out;
  begin
    out_flag = 1;
    for(i=6;i>=0;i=i-1)
      begin 
@ (negedge scl);
#`timeslice;
sda_buf = sda_buf<<1;
         end
    @(negedge scl)  #`timeslice sda_buf[7] = 1;  //��Ӧ���ź����
    @(negedge scl)  #`timeslice out_flag  = 0;  
  end
endtask	    
  endmodule
  //-------------------------------eeprom.v �ļ�����----------------
