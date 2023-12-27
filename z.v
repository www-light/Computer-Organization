/*标志寄存器*/
module z(din,clk,rst, zload,dout);
input [7:0] din;
output dout;
reg dout;
input clk,rst,zload;
always@(posedge clk or negedge rst)
begin
	if(rst==0)
		dout<=0;
	else if(zload)
		dout<=din;
end
endmodule