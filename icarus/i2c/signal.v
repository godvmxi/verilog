 /****************************************************************************
模块名称：Signal  文件名：signal.v
模块功能：用于产生测试信号，对所设计的EEPROM_WR模块进行测试。Signal模块
          能对被测试模块产生的ack信号产生响应，发出模仿MCU的数据、地址信号
          和读/写信号。被测试的模块在接收到信号后会发出写/读EEPROM虚拟模块
          的信号。  
模块说明：本模块为行为模块，不可综合为门级网表。而且本模块为教学目的做了许
          多简化，功能不完整，不能用做商业目的。
****************************************************************************/
// 信号源模型：
`timescale 1ns/1ns
`define timeslice1 200
`define CheckByteNum 16
module Signal(RESET,CLK,RD,WR,ADDR,ACK,DATA); 
output RESET;        //复位信号
output CLK;          //时钟信号
output RD,WR;        //读写信号
output[10:0] ADDR;    //11位地址信号
input ACK;           //读写周期的应答信号
inout[7:0] DATA;      //数据线
reg RESET;
reg CLK;
reg RD,WR;
reg W_R;            //低位：写操作；高位：读操作 
reg[10:0] ADDR;  
reg[7:0]  data_to_eeprom;
reg[10:0] addr_mem[0:255];
reg[7:0]  data_mem[0:255];
reg[7:0]  ROM[0:2047]; 
integer i,j;
integer OUTFILE;
assign DATA = (W_R) ?  8'bz : data_to_eeprom ;

//------------------------------------时钟信号输入------------------------------
always #(`timeslice1/2)
   CLK = ~CLK; 

//----------------------------------- 读写信号输入------------------------------
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
repeat(`CheckByteNum)  //连续写15次数据，调试成功后可以增加到全部地址覆盖测试
      begin	
        # (5 * `timeslice1);
	    WR = 1; 
	    # (`timeslice1);
	    WR = 0;
	   @ (posedge ACK);  //EEPROM_WR转换模块请求写数据
     end
    #(10 * `timeslice1);
    W_R = 1;   //开始读操作
    repeat(`CheckByteNum)  //连续读15次数据 
      begin
     	# (5 * `timeslice1);
     	RD = 1;
       # ( `timeslice1 );
     	RD = 0;
   	   @ (posedge ACK);  //EEPROM_WR转换模块请求读数据
      end
   end                 
//-----------------------------------------写操作-----------------------------
initial 
  begin
    $display("writing-----writing-----writing-----writing");
    # (2*`timeslice1);
    for(i=0;i<=`CheckByteNum-1;i=i+1)
      begin
       ADDR = addr_mem[i];              //输出写操作的地址   
       data_to_eeprom = data_mem[i];    //输出需要转换的平行数据
       $fdisplay(OUTFILE,"@%0h  %0h",ADDR, data_to_eeprom);
        //把输出的地址和数据记录在已经打开的eeprom.dat文件中
       @(posedge ACK) ;    //EEPROM_WR转换模块请求写数据        
     end
 end   

//----------------------------------------读操作----------------------------
initial
  @(posedge W_R)
   begin
    ADDR = addr_mem[0];
    $fclose (OUTFILE);    //关闭已经打开的eeprom.dat文件
    $readmemh("./eeprom.dat",ROM);  //把数据文件的数据读到ROM中

    $display("Begin READING-----READING-----READING-----READING");
     for(j = 0; j <=`CheckByteNum; j = j+1)   // 检查的写到eeprom中的字节是否正确，先检查15个字节     
     begin
        ADDR = addr_mem[j]; 
        if (j<=15)    
         begin     
            @(posedge ACK);
               if(DATA == ROM[ADDR]) //比较并显示发送的数据和接收到的数据是否一致
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
	$dumpfile("test.vcd");
	$dumpvars;
   OUTFILE = $fopen("./eeprom.dat");  // 打开一个名为eeprom.dat的文件备用
   $readmemh("./addr.dat",addr_mem);  // 把地址数据存入地址存储器
   $readmemh("./data.dat",data_mem);  // 把准备写入EEPROM的数据存入数据存储器
	end

endmodule


