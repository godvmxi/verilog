
/*
                   _ooOoo_
                  o8888888o
                  88" . "88
                  (| -_- |)
                  O\  =  /O
               ____/`---'\____
             .'  \\|     |//  `.
            /  \\|||  :  |||//  \
           /  _||||| -:- |||||-  \
           |   | \\\  -  /// |   |
           | \_|  ''\---/''  |   |
           \  .-\__  `-`  ___/-. /
         ___`. .'  /--.--\  `. . __
      ."" '<  `.___\_<|>_/___.'  >'"".
     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
     \  \ `-.   \_ __\ /__ _/   .-` /  /
======`-.____`-.___\_____/___.-`____.-'======
                   `=---='
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         佛祖保佑       永无BUG
*/
`timescale 1ns/100ps
module writing(reset,clk,address,data,sda,ack);
  input reset,clk;
  input[7:0] data;
  input[7:0] address;  
  output sda,ack;          //sda负责串行数据输出//ack是一个对象操作完毕后，模块给出的应答信号
  reg link_write;          //link_write 决定何时输出
  reg[3:0] state;          //主状态机的状态字
  reg[4:0] sh8out_state;   //从状态机的状态字
  reg[7:0] sh8out_buf;     //输入数据缓冲
  reg finish_F;            //用以判断是否处理完一个操作对象。
  reg ack;
  
  parameter
    idle=0,addr_write=1,data_write=2,stop_ack=3;
  parameter
    bit0=1,bit1=2,bit2=3,bit3=4,bit4=5,bit5=6,bit6=7,bit7=8; 
  
  assign   sda = link_write? sh8out_buf[7] : 1'bz;
  
  always @(posedge clk)
    begin
      if(!reset)               //复位。
        begin
           link_write<= 0;     //挂起串行单总线
           state    <= idle;
           finish_F <= 0;      //结束标志清零
           sh8out_state<=idle;
                 ack<= 0;
           sh8out_buf<=0;
        end
      else
        case(state)
        
        idle:                       
          begin
            link_write  <= 0;     //断开串行单总线
             finish_F <= 0;
             sh8out_state<=idle;
                   ack<= 0;
             sh8out_buf<=address;  //并行地址存入寄存器
            state    <= addr_write;  //进入下一个状态
          end
        
        addr_write:         //地址的输入。
          begin
            if(finish_F==0)
              begin  shift8_out; end   //地址的串行输出
            else
              begin
                 sh8out_state <= idle;
                 sh8out_buf   <= data;  //并行数据存入寄存器
                        state <= data_write;
                     finish_F <= 0;
              end
          end
        
        data_write:       //数据的写入。
          begin
            if(finish_F==0) 
              begin  shift8_out; end  //数据的串行输出
            else
              begin
                  link_write <= 0;
                       state <= stop_ack;
                    finish_F <= 0;  
                         ack <= 1; //向信号源发出应答。
              end
          end   
        
        stop_ack:             //向信号源发出应答结束。
          begin
              ack <= 0;
            state <= idle;
          end
        
        endcase       
    end                         
               
task shift8_out;                // 地址和数据的串行输出。
  begin
     case(sh8out_state)
     idle: 
       begin
         link_write  <= 1;     //连接串行单总线，立即输出地址或数据的最高位（MSB）
        sh8out_state <= bit7;
      end
     
     bit7:
       begin
           link_write <= 1;   //连接串行单总线
         sh8out_state <= bit6;                                  
           sh8out_buf <= sh8out_buf<<1; //输出地址或数据的次高位（bit 6）
       end
     
     bit6:
       begin
         sh8out_state<=bit5;
         sh8out_buf<=sh8out_buf<<1;
       end
       
     bit5:
       begin
         sh8out_state<=bit4;
         sh8out_buf<=sh8out_buf<<1;
       end
     
     bit4:
       begin
         sh8out_state<=bit3;
         sh8out_buf<=sh8out_buf<<1;
       end
     
     bit3:
       begin
         sh8out_state<=bit2;
         sh8out_buf<=sh8out_buf<<1;
       end
     
     bit2:
       begin
         sh8out_state<=bit1;
         sh8out_buf<=sh8out_buf<<1;
       end
     
     bit1:
       begin
         sh8out_state<=bit0;
         sh8out_buf<=sh8out_buf<<1;    //输出地址或数据的最低位（LSB）
       end
     
     bit0:
       begin
         link_write<= 0;        //挂起串行单总线
         finish_F<= 1;          //建立结束标志                    
       end  
     endcase
  end
endtask

endmodule        
