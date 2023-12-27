/*程序计数器，输出当前执行的指令地址
可仿照ar地址寄存器来写，注意替换控制信号*/
module pc(din, clk, rst,pcload, pcinc, dout);
input[15:0] din;
input clk,rst,pcload,pcinc;
output [15:0]dout;
reg [15:0]dout;
always@(posedge clk or negedge rst)//时钟上升沿触发
if(!rst)  //复位信号为低电平
	dout<=0;
else//复位信号为高电平
	if(pcload)
	dout<=din;
	else if(pcinc)
	dout<=dout+16'd1;
endmodule