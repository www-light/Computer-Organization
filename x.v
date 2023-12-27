/*数据暂存器x，存放ALU的一个输入，另外一个输入来自于总线*/
module x(din, clk, rst,xload, dout);
input [7:0] din;
output [7:0]dout;
reg [7:0]dout;
input clk,rst,xload;
always@(posedge clk or negedge rst)
begin
	if(rst==0)
		dout<=0;
	else if(xload)
		dout<=din;
end
endmodule