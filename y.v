/*暂存器Y，存放ALU的运算结果*/
module y(din, clk, rst,yload, dout);
input [7:0] din;
output [7:0]dout;
reg [7:0]dout;
input clk,rst,yload;
always@(posedge clk or negedge rst)
begin
	if(rst==0)
		dout<=0;
	else if(yload)
		dout<=din;
end
endmodule