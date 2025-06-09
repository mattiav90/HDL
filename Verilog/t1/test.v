module tb;


reg clk;
reg d;
reg rst;
wire q;


ff ff0(
	.clk(clk),
	.rst(rst),
	.d(d),
	.q(q)
);


// clock
initial begin
clk=0;
forever #1 clk=~clk;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars(0,tb);

d<=0;
rst<=1;

$display("Time\tclk\trst\td\tq");
$monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, rst, d, q);

#10;
d<=1;
#10


$finish;

end


endmodule
