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
forever #2 clk=~clk;
end


initial begin


$display("Time\tclk\trst\td\tq");
$monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, rst, d, q);

d=0;
rst=0;
#10;
rst=1;
#10;


d=1;
#10;
d=0;
#10;
d=1;
#10;
d=0;
#10;

$finish;

end


initial begin 
$dumpfile("wave.vcd"); $dumpvars();
end

endmodule
