/*数据寄存器，存放双指令中低8位指向地址的存放值*/
module dr(din, clk,rst, drload, dout);
input [7:0] din;
output [7:0] dout;
reg [7:0] dout;
input clk,rst,drload;
always@(posedge clk or negedge rst)
begin
	if(rst==0)
		dout<=0;
	else if(drload)
		dout<=din;
end
endmodule