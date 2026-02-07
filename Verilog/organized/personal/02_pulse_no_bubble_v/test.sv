
module test();

logic 		clk;
logic 		rst;
logic 		valid;
logic [3:0] pulse_length;
logic 		pulse;
logic 		ready;


pulse_gen PG (
	.clk(clk),
	.rst(rst),
	.valid(valid),
	.pulse_length(pulse_length),
	.pulse(pulse),
	.ready(ready)
);

initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin

	reset();

    pulsa(0);

    repeat(3) @(posedge clk);

    pulsa(10);

    repeat(4) @(posedge clk);

    pulsa(3);

    repeat(5) @(posedge clk);

    pulsa(0);

    repeat(15) @(posedge clk);

    

    $finish;
end




task pulsa (input [3:0] length);
begin
    @(negedge clk);
    valid        = 1;
    pulse_length = length;
    @(negedge clk);
    valid=0;
    pulse_length=0;
    $display("t=%0t valid=1, pulse_length=%0d", $time, length);
end
endtask


task reset();
begin
@(posedge clk);
    // Initialize everything at time 0
    rst          = 1;
    valid        = 0;
    pulse_length = 0;
	repeat(2) @(posedge clk);
	rst=0;
end
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end


endmodule
