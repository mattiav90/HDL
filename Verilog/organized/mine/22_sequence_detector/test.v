

`timescale 1ns/1ps;



module test();

reg clk;
reg din;
reg resetn;
wire dout;



sequence seq (
	.clk(clk),
	.resetn(resetn),
	.din(din),
	.dout(dout)	
);


initial begin
clk=0;
forever #2 clk=!clk;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars(0,test);


resetn=0; #5
resetn=1; #5

//$monitor("dout:",dout);

din=1; #4
din=1; #4
din=1; #4
din=1; #4

din=1; #4
din=0; #4
din=1; #4
din=0; #4

din=0; #4
din=0; #4
din=0; #4
din=0; #4




$finish;
end



endmodule
