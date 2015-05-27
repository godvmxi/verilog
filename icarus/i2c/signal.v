 /****************************************************************************
ģ�����ƣ�Signal  �ļ�����signal.v
ģ�鹦�ܣ����ڲ��������źţ�������Ƶ�EEPROM_WRģ����в��ԡ�Signalģ��
          �ܶԱ�����ģ�������ack�źŲ�����Ӧ������ģ��MCU�����ݡ���ַ�ź�
          �Ͷ�/д�źš������Ե�ģ���ڽ��յ��źź�ᷢ��д/��EEPROM����ģ��
          ���źš�  
ģ��˵������ģ��Ϊ��Ϊģ�飬�����ۺ�Ϊ�ż��������ұ�ģ��Ϊ��ѧĿ��������
          ��򻯣����ܲ�����������������ҵĿ�ġ�
****************************************************************************/
// �ź�Դģ�ͣ�
`timescale 1ns/1ns
`define timeslice1 200
`define CheckByteNum 16
module Signal(RESET,CLK,RD,WR,ADDR,ACK,DATA); 
output RESET;        //��λ�ź�
output CLK;          //ʱ���ź�
output RD,WR;        //��д�ź�
output[10:0] ADDR;    //11λ��ַ�ź�
input ACK;           //��д���ڵ�Ӧ���ź�
inout[7:0] DATA;      //������
reg RESET;
reg CLK;
reg RD,WR;
reg W_R;            //��λ��д��������λ�������� 
reg[10:0] ADDR;  
reg[7:0]  data_to_eeprom;
reg[10:0] addr_mem[0:255];
reg[7:0]  data_mem[0:255];
reg[7:0]  ROM[0:2047]; 
integer i,j;
integer OUTFILE;
assign DATA = (W_R) ?  8'bz : data_to_eeprom ;

//------------------------------------ʱ���ź�����------------------------------
always #(`timeslice1/2)
   CLK = ~CLK; 

//----------------------------------- ��д�ź�����------------------------------
initial 
   begin
     RESET = 1;
     i   = 0; 
     j   =0;
     W_R = 0;
     CLK = 0;    			
     RD  = 0;
     WR  = 0;
     #1000 ;
     RESET = 0; 
repeat(`CheckByteNum)  //����д15�����ݣ����Գɹ���������ӵ�ȫ����ַ���ǲ���
      begin	
        # (5 * `timeslice1);
	    WR = 1; 
	    # (`timeslice1);
	    WR = 0;
	   @ (posedge ACK);  //EEPROM_WRת��ģ������д����
     end
    #(10 * `timeslice1);
    W_R = 1;   //��ʼ������
    repeat(`CheckByteNum)  //������15������ 
      begin
     	# (5 * `timeslice1);
     	RD = 1;
       # ( `timeslice1 );
     	RD = 0;
   	   @ (posedge ACK);  //EEPROM_WRת��ģ�����������
      end
   end                 
//-----------------------------------------д����-----------------------------
initial 
  begin
    $display("writing-----writing-----writing-----writing");
    # (2*`timeslice1);
    for(i=0;i<=`CheckByteNum-1;i=i+1)
      begin
       ADDR = addr_mem[i];              //���д�����ĵ�ַ   
       data_to_eeprom = data_mem[i];    //�����Ҫת����ƽ������
       $fdisplay(OUTFILE,"@%0h  %0h",ADDR, data_to_eeprom);
        //������ĵ�ַ�����ݼ�¼���Ѿ��򿪵�eeprom.dat�ļ���
       @(posedge ACK) ;    //EEPROM_WRת��ģ������д����        
     end
 end   

//----------------------------------------������----------------------------
initial
  @(posedge W_R)
   begin
    ADDR = addr_mem[0];
    $fclose (OUTFILE);    //�ر��Ѿ��򿪵�eeprom.dat�ļ�
    $readmemh("./eeprom.dat",ROM);  //�������ļ������ݶ���ROM��

    $display("Begin READING-----READING-----READING-----READING");
     for(j = 0; j <=`CheckByteNum; j = j+1)   // ����д��eeprom�е��ֽ��Ƿ���ȷ���ȼ��15���ֽ�     
     begin
        ADDR = addr_mem[j]; 
        if (j<=15)    
         begin     
            @(posedge ACK);
               if(DATA == ROM[ADDR]) //�Ƚϲ���ʾ���͵����ݺͽ��յ��������Ƿ�һ��
              $display("DATA %0h == ROM[%0h]---READ RIGHT",DATA,ADDR);
            else
                $display("DATA %0h != ROM[%0h]---READ WRONG",DATA,ADDR);  
         end
        else
          $display ("All the bytes written in eeprom have been checked!!");     
             
     end
     $stop;
     
  end   

initial
  begin
   OUTFILE = $fopen("./eeprom.dat");  // ��һ����Ϊeeprom.dat���ļ�����
   $readmemh("./addr.dat",addr_mem);  // �ѵ�ַ���ݴ����ַ�洢��
   $readmemh("./data.dat",data_mem);  // ��׼��д��EEPROM�����ݴ������ݴ洢��
end

endmodule


