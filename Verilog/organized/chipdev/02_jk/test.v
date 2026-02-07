module tb;

reg j;
reg k;
reg clk;
reg rst;
wire q;

jk jk0(
	.clk(clk),
	.rst(rst),
	.j(j),
	.k(k),
	.q(q)
);

// Generate clock
initial begin 
	clk = 0;
	forever #1 clk = ~clk;  // clk period = 4, rising edge at 2, 6, 10, ...
end 

// Stimulus
initial begin
	// Reset
	rst = 0;
	j = 0;
	k = 0;
	#1;
	rst = 1;   // Ensure rst is deasserted just before next clk posedge
	#3;        // Next rising edge is at time 4

	// CASE: j=0, k=1 → q <= 0
	j = 0; k = 1;
	#4;  // Wait one full clock cycle
	$display("t=%0t j=%b k=%b q=%b", $time, j, k, q);

	// CASE: j=1, k=0 → q <= 1
	j = 1; k = 0;
	#4;
	$display("t=%0t j=%b k=%b q=%b", $time, j, k, q);

	// CASE: j=1, k=1 → q <= !q
	j = 1; k = 1;
	#4;
	$display("t=%0t j=%b k=%b q=%b", $time, j, k, q);

	// CASE: j=0, k=0 → hold
	j = 0; k = 0;
	#4;
	$display("t=%0t j=%b k=%b q=%b", $time, j, k, q);

	#4;
	$finish;
end

initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end

endmodule
