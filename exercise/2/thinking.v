//                            _ooOoo_  
//                           o8888888o  
//                           88" . "88  
//                           (| -_- |)  
//                            O\ = /O  
//                        ____/`---'\____  
//                      .   ' \\| |// `.  
//                       / \\||| : |||// \  
//                     / _||||| -:- |||||- \  
//                       | | \\\ - /// | |  
//                     | \_| ''\---/'' | |  
//                      \ .-\__ `-` ___/-. /  
//                   ___`. .' /--.--\ `. . __  
//                ."" '< `.___\_<|>_/___.' >'"".  
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |  
//                 \ \ `-. \_ __\ /__ _/ .-` / /  
//         ======`-.____`-.___\_____/___.-`____.-'======  
//                            `=---='  
//  
//         .............................................  
//                  佛祖保佑             永无BUG 
//          佛曰:  
//                  写字楼里写字间，写字间里程序员；  
//                  程序人员写程序，又拿程序换酒钱。  
//                  酒醒只在网上坐，酒醉还来网下眠；  
//                  酒醉酒醒日复日，网上网下年复年。  
//                  但愿老死电脑间，不愿鞠躬老板前；  
//                  奔驰宝马贵者趣，公交自行程序员。  
//                  别人笑我忒疯癫，我笑自己命太贱；  
//                  不见满街漂亮妹，哪个归得程序员？  
//i do not know ,will add later 
module half_div_no_rst(clk_in,clk_out) ;
input clk_in ;
output clk_out ;
reg clk_out;
initial begin
	clk_out <= 0;
end
always @(posedge clk_in)   begin 
	clk_out <= ~clk_out;
end

endmodule

module duty_div_x_no_rst(clk_in,clk_out,x) ;
input clk_in ;
input[3:0] x ;
output clk_out ;
reg clk_out;
reg[3:0] counter ;
initial begin
	clk_out <= 0;
	counter <=  0;
end
always @(posedge clk_in)   begin 
	counter =  counter + 1 ;
	if (counter === x )  begin 
		clk_out <= ~clk_out;
		counter <= 0 ;
	end

end

endmodule

/*
module duty_div_x_y_no_rst(clk_in,clk_out,x,y) ;
input clk_in ;
input[3:0] x;
input[3:0] y;
output clk_out ;
reg clk_out;
initial begin
	clk_out <= 0;
end
always @(posedge clk_in)   begin 
	clk_out <= ~clk_out;
end

endmodule

*/