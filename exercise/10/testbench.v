          
/***************************************************************************
***   模块的功能： 对合并在一起的可综合的模块sys 进行测试验证。其测试信号***
***    尽可能地与实际情况一致，用随机数系统任务对数据的到来和时钟沿的    ***
***    抖动都进行了模拟仿真。本模块无任何工程价值，只有学习价值。        *** 
****************************************************************************/

`timescale 1ns/1ns
`include "./sys.v"   // 改用不同级别的Verilog 网表文件可进行不同层次的仿真module Top;
 reg clk;
 reg[7:0] data_buf;
 reg nGet_AD_data;
 reg D_Pin_ena;   //并行数据输入sys模块的使能信号寄存器
 wire [7:0] data;
 wire clk2;
 wire Dbit_ena;
 
 assign  data = (D_Pin_ena)? data_buf : 8'bz;   
                
initial  
  begin
    $dumpfile("wave.vcd");
    $dumpvars;
     clk = 0;
     nGet_AD_data =1;       //置取数据控制信号初始值为高电平
     data_buf = 8'b1001_1001;  //假设的数据缓存器的初始值，可用于模拟并行数据的变化
     D_Pin_ena = 0;
  end

initial
  begin
    repeat(100)
    begin
      #(100*14+{$random} %23) nGet_AD_data = 0;  //取并行数据开始
      # (112+{$random} %12)  nGet_AD_data = 1;  //保持一定时间低电平后恢复高电平
      # ({$random}%50) D_Pin_ena = 1;  //并行数据输入sys模块的使能信号有效
      # (100*3 + {$random}%5) D_Pin_ena = 0;  //保持三个时钟周期后让出总线
      # 333  data_buf = data_buf+1;  //假设的数据变化， 可为下次取得不同得数据
      #(100*11 + {$random}%1000);
    end
  end

always  #(50+$random%2)  clk = ~clk;  //主时钟的产生
 
sys ms( .databus(data),
  .use_p_in_bus(D_Pin_ena),
       .Dbit_out(Dbit_out), 
       .Dbit_ena(Dbit_ena),
       .nGet_AD_data(nGet_AD_data),
       .clk(clk));
 endmodule
