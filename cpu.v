/*CPU  modified by zhy 2022.12.25
增加了irout输出，用于控制light_show.v文件中rs和rd的值*/

//省略号中是自行设计的控制信号，需要自行补充
module cpu(data_in,clk_quick,clk_slow,clk_delay,rst,SW_choose,A1,cpustate,addr,data_out,r0dbus,r1dbus,r2dbus,r3dbus,clr,irout,read,write,pcbus,pcload,
arload,arinc,membus,drload,pcinc,irload,r0load,r1load,r2load,trload,r3load,xload,yload,zload,drhbus,drlbus,trbus,r0bus,r1bus,r2bus,r3bus,ybus,busmem,zout);

input[7:0] data_in;
input clk_quick,clk_slow,clk_delay;
input rst;
input SW_choose,A1;
input [1:0] cpustate;

output [15:0] addr; 
output [7:0] data_out;
output [7:0] r0dbus;//r0
output [7:0] r1dbus;//r1
output [7:0] r2dbus;//r2
output [7:0] r3dbus;//r3
output [7:0] irout;
//补充自行设计的控制信号的端口说明，都是output
//1位的控制信号
output arinc;
output pcload,pcinc;
output drload,trload,irload,r1load,r2load,r3load,xload,yload,zload;
output read,write,pcbus,membus,r0load,drhbus,drlbus,trbus,r0bus,r1bus,r2bus,r3bus,ybus,busmem,clr,arload;
output zout;

wire[3:0] alus;
wire clk_choose,clk_run;
wire[15:0] dbus,pcdbus;
wire[7:0]drdbus,trdbus,ydbus,xout;
wire zout;
//wire pcbus,membus,drhbus,drlbus,trbus,r0bus,r1bus,r2bus,r3bus,ybus,busmem;
//定义一些需要的内部信号
wire [7:0] alu_out;
wire alu_zout;

//reg  r1load,r2load,r3load,r0bus,r1bus,r2bus,r3bus;

//qtsj(clk_quick,clk_slow,clk_delay,clr,rst,SW_choose,A1,cpustate,clk_run,clk_choose);
qtsj qtdl(.clk_quick(clk_quick),.clk_slow(clk_slow),.clk_delay(clk_delay),.clr(clr),.rst(rst),.SW_choose(SW_choose),.A1(A1),.cpustate(cpustate),.clk_run(clk_run),.clk_choose(clk_choose));
//ar(din, clk, rst,arload, arinc, dout);
ar mar(.din(dbus),.clk(clk_choose),.rst(rst),.arload(arload),.arinc(arinc),.dout(addr));

//pc(din, clk, rst,pcload, pcinc, dout);
pc mpc(.din(dbus),.clk(clk_choose),.rst(rst),.pcload(pcload),.pcinc(pcinc),.dout(pcdbus));

//dr(din, clk,rst, drload, dout);补充dr实例化语句
dr mdr(.din(dbus),.clk(clk_choose),.rst(rst),.drload(drload),.dout(drdbus));

//tr(din, clk,rst, trload, dout);补充tr实例化语句，如果需要tr的话
tr mtr(.din(drdbus),.clk(clk_choose),.rst(rst),.trload(trload),.dout(trdbus));

//module ir(din,clk,rst,irload,dout);补充ir实例化语句
ir mir(.din(drdbus),.clk(clk_choose),.rst(rst),.irload(irload),.dout(irout));

//r0(din, clk, rst,r0load, dout);补充r0实例化语句
r0 mr0(.din(dbus),.clk(clk_choose),.rst(rst),.r0load(r0load),.dout(r0dbus));

//r1(din, clk, rst,r1load, dout);补充r1实例化语句
r1 mr1(.din(dbus),.clk(clk_choose),.rst(rst),.r1load(r1load),.dout(r1dbus));

//r2(din, clk, rst,r2load, dout);补充r2实例化语句
r2 mr2(.din(dbus),.clk(clk_choose),.rst(rst),.r2load(r2load),.dout(r2dbus));

//r3(din, clk, rst,r3load, dout);补充r3实例化语句
r3 mr3(.din(dbus),.clk(clk_choose),.rst(rst),.r3load(r3load),.dout(r3dbus));

// x(din, clk, rst,xload, dout);补充x实例化语句
x mx(.din(dbus), .clk(clk_choose), .rst(rst), .xload(xload), .dout(xout));

// y(din, clk, rst,yload, dout);补充y实例化语句
y my(.din(alu_out), .clk(clk_choose), .rst(rst), .yload(yload), .dout(ydbus));

//alu(alus,x, bus, dout);补充alu实例化语句
alu malu(.alus(alus),.x(xout),.bus(dbus),.dout(alu_out),.zout(alu_zout));

//z(din,clk,rst, zload,dout);补充z实例化语句，如果需要的话
z mz(.din(alu_zout), .clk(clk_choose), .rst(rst), .zload(zload),.dout(zout));

//module control(din,clk,rst,z,cpustate,read,write,pcbus,arload,membus,drload,pcinc,irload,r0load,r1load,r1load,r2load,trload,r3load,xload,yload,zload
//补充control实例化语句
control mcontrol(.din(irout),.clk(clk_run),.rst(rst),.z(zout),.cpustate(cpustate),.read(read),.write(write),.pcbus(pcbus),.arload(arload),
.membus(membus),.drload(drload),.pcinc(pcinc),.irload(irload),.r0load(r0load),.r1load(r1load),.r2load(r2load),.trload(trload),.r3load(r3load),
.xload(xload),.yload(yload),.zload(zload),.drhbus(drhbus),.drlbus(drlbus),.trbus(trbus),.r0bus(r0bus),.r2bus(r2bus),.r3bus(r3bus),.ybus(ybus),
.busmem(busmem),.alus(alus),.clr(clr),.arinc(arinc),.r1bus(r1bus),.pcload(pcload));


//allocate dbus
assign dbus[15:0]=(pcbus)?pcdbus[15:0]:16'bzzzzzzzzzzzzzzzz;
assign dbus[15:8]=(drhbus)?drdbus[7:0]:8'bzzzzzzzz;
assign dbus[7:0]=(drlbus)?drdbus[7:0]:8'bzzzzzzzz;
assign dbus[7:0]=(trbus)?trdbus[7:0]:8'bzzzzzzzz;

assign dbus[7:0]=(r1bus)?r1dbus[7:0]:8'bzzzzzzzz;
assign dbus[7:0]=(r0bus)?r0dbus[7:0]:8'bzzzzzzzz;
assign dbus[7:0]=(r2bus)?r2dbus[7:0]:8'bzzzzzzzz;
assign dbus[7:0]=(r3bus)?r3dbus[7:0]:8'bzzzzzzzz;

assign dbus[7:0]=(ybus)?ydbus[7:0]:8'bzzzzzzzz;

assign dbus[7:0]=(membus)?data_in[7:0]:8'bzzzzzzzz;
assign data_out=(busmem)?dbus[7:0]:8'bzzzzzzzz;



endmodule