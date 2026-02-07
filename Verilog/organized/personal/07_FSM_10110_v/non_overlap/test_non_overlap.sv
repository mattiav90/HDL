
module test();


logic clk;
logic reset;
logic din;
logic det;


FSM_non_overlap dut (clk,reset,din,det);


initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin

resett;

repeat(5) random_bit;
sequence_10110;
repeat(100) random_bit;

#20;
$finish;

end


task resett;
reset=1;
din=0;
repeat (2) @(posedge clk);
reset=0;
endtask

//random bit task
task random_bit;
	begin
	@(negedge clk);
	din = $urandom_range(0,1);
	end
endtask


//sequence task
task sequence_10110;
	begin
	@(negedge clk); din=1;
	@(negedge clk); din=0;
	@(negedge clk); din=1;
	@(negedge clk); din=1;
	@(negedge clk); din=0;
	end
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars();
end


endmodule
