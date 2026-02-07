

module test();


localparam N=3;

logic clk, reset, valid, ready;
logic [N:0] din;
logic pulse;

model dut(clk,reset,valid,din,ready,pulse);



initial begin
clk=0;
forever #1 clk=~clk;
end


initial begin

	resett;
	@(posedge clk);

	gend(3);
	repeat(5) @(posedge clk);

	gend (8);
	repeat(3) @(posedge clk);

	gend(5);
	repeat(10) @(posedge clk);


	#10;
	$finish;
end



task resett;
begin
	@(negedge clk);
	reset=1;
	valid=0;
	din=0;
	repeat(3) @(posedge clk);
	reset=0;
end
endtask


task gend (input logic [N:0] in);
begin
	@(negedge clk)
	valid=1;
	din=in;
	@(negedge clk);
	$display("din generated. %d",din);
	valid=0;
	din=0;
end
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end



endmodule
