
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


/***************************************************************************
***   模块的功能： 把两个独立的逻辑模块（P_S和S_P）合并到一个可综合    ***
***       的模块中，共用一条并行总线，配合有关信号，分时进行输入/或输出。***
***   模块的目的：学习如何把两个单向输入/输出的实例模块，连接在一起，    ***
***               共享一 条总线。                                        ***
***         本模块是完全可综合模块，已经通过综合和布线后仿真。           ***
****************************************************************************/
`include "./P_S.v"
`include "./S_P.v"
module sys(databus,use_p_in_bus,Dbit_out,Dbit_ena,nGet_AD_data,clk);  input nGet_AD_data;      //取并行数据的控制信号
  input use_p_in_bus;      // 并行总线用于输入数据的控制信号  input clk;                //主时钟  inout  [7:0]  databus;    //双向并行数据总线  output Dbit_out;          //字节位流输出
  output Dbit_ena;          //字节位流输出使能
  
  wire clk；
  wire nGet_AD_data;   
  wire Dbit_out;
  wire Dbit_ena;  
  wire [7:0]  data;

assign databus = (!use_p_in_bus)? data : 8'bzzzz_zzzz;
  P_S  m0(.Dbit_out(Dbit_out),.link_S_out(Dbit_ena),.data(databus),
                    .nGet_AD_data(nGet_AD_data),.clk(clk));
  S_P  m1(.data(data), .Dbit_in(Dbit_out), .Dbit_ena(Dbit_ena),.clk(clk));
  
endmodule