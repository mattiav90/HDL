

`timescale 1ns/1ps;



module test();

parameter WIDTH =16;

reg 			 clk;
reg 			 resetn;
reg  [WIDTH-1:0] din;
wire [WIDTH-1:0] dout;


second_largest #(WIDTH) sl(
	.clk(clk),
	.din(din),
	.resetn(resetn),
	.dout(dout)
);



initial begin
clk=0;
forever #2 clk = ! clk;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars(0,test);


resetn=0;
#4

resetn=1;
din=3;
#4;


din = 3;  #5;
$display("dout = %0d", dout);

din = 10; #5;
$display("dout = %0d", dout);

din = 2;  #5;
$display("dout = %0d", dout);

din = 7;  #5;
$display("dout = %0d", dout);

din = 20;  #5;
$display("dout = %0d", dout);




#10
$display("dout= ",dout);




$finish;
end




endmodule 
