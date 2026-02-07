
`timescale 1ns/1ps;

module test();

parameter W=8;

reg          clk;
reg  [1:0]   sel;
reg  [W-1:0] d;
wire [W-1:0] q;

var_shift vs (clk,d,sel,q);

initial begin
clk=0;
forever #5 clk=~clk;
end

//main
initial begin
repeat (20) go;
$finish;
end


task go;
begin
	@(negedge clk);
	d=$random;
	sel=$random;
	@(negedge clk);
	$display("d: %d, sel: %d q: %d",d,sel,q);
end
endtask


initial begin
$dumpfile("wave.vcd"); $dumpvars;
end



endmodule
