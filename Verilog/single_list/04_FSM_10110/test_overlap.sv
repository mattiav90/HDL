
module test();



logic clk;
logic reset;
logic din;
logic det;


FSM_overlap dut (clk,reset,din,det);


initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
resett;
repeat (5) random;
full_sequence;
repeat(20) random;

repeat(5) overlap;

repeat(20) random;

#20;
$finish;
end


task resett;
begin
	din=0;
	reset=0;
	@(posedge clk);
	reset=1;
	repeat(2) @(posedge clk);
	reset=0;
end
endtask


task random;
begin
	@(negedge clk);
	din = $urandom_range(0,1);
end
endtask

task full_sequence;
begin
	@(negedge clk); din=1;
	@(negedge clk); din=0;
	@(negedge clk); din=1;
	@(negedge clk); din=1;
	@(negedge clk); din=0;
end
endtask


task overlap;
begin
	@(negedge clk); din=1;
	@(negedge clk); din=1;
	@(negedge clk); din=0;
end 
endtask

initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
