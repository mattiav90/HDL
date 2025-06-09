module tb;


reg clk;
reg d;
wire q;


ff ff0(
	.clk(clk),
	.d(d),
	.rst(rst),
	.q(q)
);

initial begin 
clk=0;
forever #1 clk=~clk;
end 


