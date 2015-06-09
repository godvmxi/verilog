//----------- 文件名 tryfunct.v --------------------
module tryfunct(clk,n,result,reset);
    output[31:0] result;
    input[3:0]  n;
    input reset,clk;
    reg[31:0] result;

    always @(posedge clk)   begin //clk的上沿触发同步运算。
 		if(!reset)            //reset为低时复位。
			result<=0;
      	else  begin
			result <= n * factorial(n)/((n*2)+1);
		end       //verilog在整数除法运算结果中不考虑余数
    	end
  
 	function [31:0] factorial;      //函数定义，返回的是一个32位的数
		input  [3:0]  operand;        //输入只有一个四位的操作数
		reg    [3:0]  index;          //函数内部计数用中间变量
		begin
 			factorial = operand ? 1 : 0;  //先定义操作数为零时函数的输出为零，不为零时为1
			for(index = 2; index <= operand; index = index + 1)
				factorial = index * factorial;   //表示阶乘的算术迭代运算
		end
	endfunction
  
endmodule
