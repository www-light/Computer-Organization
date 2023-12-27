/*r1通用寄存器*/
module r1(din, clk, rst,r1load, dout);
input clk,rst,r1load;
input [7:0] din;
output [7:0] dout;
reg [7:0] dout;
always@(posedge clk or negedge rst)
begin
	if(rst==0)            
		dout<=0;
	else if(r1load)
		dout<=din;
end
endmodule
