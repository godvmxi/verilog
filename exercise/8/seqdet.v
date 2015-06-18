
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
module seqdet(x,z,clk,rst,state);
input  x,clk,rst;
output z;
output[2:0] state;
reg[2:0] state;
wire z;

parameter IDLE='d0,  A='d1,  B='d2,
                     C='d3,  D='d4,
                     E='d5,  F='d6,
                     G='d7;
            
assign  z = ( state==E && x==0 )? 1 : 0;   
//当x 序列10010最后一个0刚到时刻，时钟沿立刻将状态变为E，此时z 应该变为高
always @(posedge clk)
   if(!rst)
          begin
          state <= IDLE;
          end
   else
          casex(state)
            IDLE : if(x==1)   //第一个码位对,记状态A
                       begin  
                          state <= A;
                       end
            A:     if(x==0)   //第二个码位对,记状态B
                       begin
                          state <= B;
                       end
            B:     if(x==0)   //第三个码位对，记状态C
                       begin
                          state <= C;
                       end
                    else      //第三个码位不对,前功尽弃，记状态为F
                       begin
                          state <= F;
                       end
            C:      if(x==1)  //第四个码位对
                       begin
                          state <= D;
                       end
                    else    //第四个码位不对，前功尽弃，记状态为G
                       begin
                          state <= G;
                       end
            D:      if(x==0) //第五个码位对,记状态E
                       begin
                          state <= E; //此时开始应有z 的输出
                       end
                    else  
        //第五个码位不对,前功尽弃，只有刚进入的1有用，回到第一个码位对状态,记状态A
                       begin
                          state <= A;
                       end
            E:   if(x==0)  
        //连着前面已经输入的x 序列10010考虑，又输入了0码位可以认为第三个码位已对，记状态C
                       begin
                          state <= C;
                       end
                    else  //前功尽弃，只有刚输入的1码位对，记状态为A
                       begin
                          state <= A;
                       end
            F:      if(x==1)  //只有刚输入的1码位对，记状态为A
                       begin
                          state <= A;
                       end
                    else      //又有1码位对，记状态为B
                       begin
                          state <= B;
                       end
            G:      if(x==1)  //只有刚输入的1码位对，记状态为A
                       begin
                          state <= F;
                       end
           default:state=IDLE;      //缺省状态为初始状态。
           endcase
endmodule