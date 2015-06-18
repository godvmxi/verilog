
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


/**********************************************************************8***
***   模块功能：把在位流有效信号控制下的字节位流读入模块，              ***
***             在时钟节拍控制下转换为并行的字节数据，输出到并行        ***
***             数据口。                                                ***
**************************************************************************/ 
`timescale 1ns/1ns
`define YES 1
`define NO  0
module S_P(data, Dbit_in, Dbit_ena, clk);              
       output [7:0] data;       //并行数据输出口   
       input   Dbit_in, clk;    //字节位流输入口
       input   Dbit_ena;        //字节位流使能输入口
                                         
       reg [7:0] data_buf;
       reg [3:0] state;   //状态变量寄存器
       reg  p_out_link;   //并行输出控制寄存器
       
       assign  data = (p_out_link==`YES) ? data_buf : 8'bz;    
       
       always@(negedge clk)
         if(Dbit_ena )
               case(state)
               0:  begin 
                     p_out_link  <=`NO;
                     data_buf[7] <= Dbit_in;
                             state <=1;
                   end
               1:  begin 
                     data_buf[6] <= Dbit_in;
                      state <=2;
                   end
               2:  begin 
                     data_buf[5] <= Dbit_in;
                             state <=3;
                   end
               3:  begin 
                     data_buf[4] <= Dbit_in;
                             state <=4;
                   end
               4:  begin 
                     data_buf[3] <= Dbit_in;
                             state <=5;
                   end
               5:  begin 
                     data_buf[2] <= Dbit_in;
                             state <=6;
                   end
               6:  begin 
                     data_buf[1] <= Dbit_in;
                             state <=7;
                   end
               7:   begin 
                     data_buf[0] <= Dbit_in;
                             state <=8;
                    end
               8:   begin 
                        p_out_link <= `YES;
                        state <= 4'b1111;
                    end
       default:   state <=0;
             endcase
       else  begin 
                    p_out_link <= `YES;
                    state <=0;
             end
               
           
endmodule