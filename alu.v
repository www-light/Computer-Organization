/*算术逻辑单元，x来自于Rs，bus来自于Rd*/
module alu(alus,x, bus, dout,zout);
input [7:0]x,bus;
input[3:0]alus;	//可实现8种运算
output reg[7:0] dout;
output reg zout;
always@(*)
begin
	case(alus)
		4'b0000:	dout = 8'b00000000;
		4'b0001:	dout = x + bus;
		4'b0010:	dout = bus + 8'b00000001;
		4'b0011:	dout = x - bus;
		4'b0100:	dout = x & bus;
		4'b0101:	dout = x | bus;
		4'b0110:	dout = bus - 8'b00000001;
		4'b0111:	dout = bus<<1;
		4'b1000: dout = ~bus;
		default:dout = 8'bx;
	endcase
if(dout==8'b00000000)
	zout<=1;
else
	zout<=0;
end
endmodule
