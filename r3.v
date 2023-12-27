/*r3通用寄存器*/
module r3(din, clk, rst,r3load, dout);
input clk,rst,r3load;
input [7:0] din;
output [7:0]dout;
reg [7:0]dout;
//使用always块来描述模块的行为
always@(posedge clk or negedge rst)
begin
//复位信号为0
	if(rst==0)//将dout的值设置为0，表示将寄存器清零。
		dout<=0;
	else if(r3load)//load为高电平
		dout<=din;
end
endmodule