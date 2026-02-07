
module test();

parameter N=8;

logic clk, reset;
logic [N-1:0] din, grant;


model #(N) dut(clk,reset,din,grant);


initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin
	@(posedge clk);
	reset=1;
	repeat(3) @(posedge clk);
	reset=0;
	@(posedge clk);


	genin(8'b00000000);
	genin(8'b00000010);
	genin(8'b00000010);
	genin(8'b00001000);
	genin(8'b00100100);
	genin(8'b00100100);

	genin(8'b00111100);
	genin(8'b00111100);
	genin(8'b00111100);
	genin(8'b00111100);
	genin(8'b00111100);
	genin(8'b00111100);

	#10
	$finish;
end


task genin (input logic [N-1:0] in);
begin
	@(negedge clk);
	din=in;
	@(posedge clk);
	$display("din: %b grant: %b",din,grant);
end
endtask



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end 


endmodule
