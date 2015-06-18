
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


/*************************************************************************
***   模块功能：把在nGet_AD_data负跳变沿时刻后能维持约三个             *** 
***             时钟周期的并行字节数据取入模块，在时钟节拍下转换为字    ***
***             节的位流，并产生相应字节位流的有效信号                  ***
**************************************************************************/ 
`define YES 1
`define NO  0
module  P_S(Dbit_out,link_S_out,data,nGet_AD_data,clk);
input clk;               //主时钟节拍input nGet_AD_data;     //负电平有效的取并行数据控制信号线                               
input [7:0] data;     //并行输入的数据端口。
output Dbit_out;        //串行位流的输出
output link_S_out;      //允许串行位流输出的控制信号

reg [3:0] state;        //状态变量寄存器
reg [7:0] data_buf;     //并行数据缓存器
reg link_S_out;         //串行位流输出的控制信号寄存器
reg d_buf;              //位缓存器
reg finish_flag;         //字节处理结束标志

assign   Dbit_out = (link_S_out)? d_buf:0;         //给出串行数据。

   always @(posedge clk or negedge nGet_AD_data)  
                // nGet_AD_data下降沿置数,寄存器清零，clk上跳沿送出位流  if(!nGet_AD_data)
          begin
           finish_flag <=0;
           state <= 9;
           link_S_out <=`NO;
           d_buf <= 0;
           data_buf <=0;
          end
    else
          case(state)
        9:   begin 
                    data_buf <= data;
                    state <=10;
                    link_S_out <=`NO;
              end 
        10:   begin 
                    data_buf <= data;
                    state <=0;
                    link_S_out <=`NO;
              end 
         0:    begin
                   link_S_out <=`YES;
                   d_buf <=data_buf[7];
                   state <=1;
               end
         1:   begin
                   d_buf <=data_buf[6];
                   state <=2;
               end
         2:   begin
                   d_buf <=data_buf[5];
                   state <=3;
               end
         3:   begin
                   d_buf <=data_buf[4];
                   state <=4;
               end
      4:    begin
                   d_buf <=data_buf[3];
                   state <=5;
               end
         5:   begin
                   d_buf <=data_buf[2];
                   state <=6;
               end
         6:   begin
                   d_buf <=data_buf[1];
                   state <=7;
               end
        7:   begin
                   d_buf <=data_buf[0];
                   state <=8;
               end
      8:   begin  
                   link_S_out <=`NO;   
                   state <= 4'b1111;   //do nothing state
                   finish_flag <=1;
               end      
   default:  begin 
                   link_S_out <=`NO;
                   state <= 4'b1111;   //do nothing state
             end
          endcase

endmodule