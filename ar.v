/*地址寄存器，输出要执行的下一指令地址*/
/*arload：加载信号，当该信号为高电平时，将输入数据加载到寄存器中。
arinc：递增信号，当该信号为高电平时，将寄存器的值递增。*/
module ar(din, clk, rst,arload, arinc, dout);
input[15:0] din;
input clk,rst,arload, arinc;
output [15:0] dout;
reg [15:0] dout;
always@(posedge clk or negedge rst)//时钟上升沿触发
if(!rst)  //复位信号为低电平
	dout<=0;
else//复位信号为高电平
	if(arload)
	dout<=din;
	else if(arinc)
	dout<=dout+16'd1;
endmodule