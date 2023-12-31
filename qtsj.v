/*启停电路*/
//实现了一个启停电路，根据输入的按钮信号和清零信号来控制时钟信号的启停，以及根据选择信号来选择输出的时钟频率。
//可以根据需要启停时钟信号，以及选择不同的时钟频率。
module qtsj(clk_quick,clk_slow,clk_delay,clr,rst,SW_choose,A1,cpustate,clk_run,clk_choose);
input clk_quick,clk_slow;//两种不同频率的时钟信号
input clk_delay;//延时时钟信号
input clr;//清零信号
input rst;//复位信号
input SW_choose;//选择信号
input A1;//按钮
input [1:0] cpustate;//状态信号
output clk_run,clk_choose;//输出的时钟信号

reg A_d1,A_d2,clk_enable;//用于延时A1信号1个和2个时钟周期。
//clk_enable用于控制时钟信号的启停。当A1信号有效时，clk_enable为1；当clr信号有效时，clk_enable为0。
reg clr_d1,clr_d2;//用于延时clr信号1个和2个时钟周期
wire reset;
wire A_Neg;
wire clr_Neg;

//wire clk_choose;
//wire clk_run;
assign reset = rst&(cpustate == 2'b11);
assign clk_choose = (SW_choose)?clk_quick:clk_slow;

always @(posedge clk_delay or negedge reset)//将A1延时1个时钟
begin
	if(!reset) A_d1 <= 1;
	else A_d1 <= A1;
end
always @(posedge clk_delay or negedge reset)//将A1延时2个时钟
begin
	if(!reset) A_d2 <= 1;
	else A_d2 <= A_d1;
end
assign A_Neg = (~A_d1)&A_d2;//若A1有效，则将A1变为延时1个时钟的有效脉冲信号

always @(posedge clk_choose or negedge reset)//将clr延时1个时钟
begin
	if(!reset) clr_d1 <= 1;
	else clr_d1 <= clr;
end
always @(posedge clk_choose or negedge reset)//将clr延时2个时钟
begin
	if(!reset) clr_d2 <= 1;
	else clr_d2 <= clr_d1;
end
assign clr_Neg = (~clr_d2)&clr_d1;//若clr有效，则将clr变为延时1个时钟的有效脉冲信号


always @(posedge clk_delay or negedge reset)//A1有效时，clk_enable为1；clr有效时，clk_enable为0
begin	
	if(!reset) clk_enable <= 0;
	else 
	begin
		if(clr_Neg) clk_enable <= 0;
		else if(A_Neg) clk_enable <= 1;
		else clk_enable <= clk_enable;
	end
end

assign clk_run = clk_choose & clk_enable;//生成clk_run时钟信号


endmodule 