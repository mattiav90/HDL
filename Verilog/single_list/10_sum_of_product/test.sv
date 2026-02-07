`timescale 1ns/1ps
module tb;

parameter BW=8;
parameter K =5;

reg clk, reset;
reg  [BW-1:0] x, w;
reg  in_valid;
wire in_ready;

wire [(BW*2+K):0] out;
wire out_valid;
reg  out_ready;

model #(.BW(BW),.K(K)) dut (
  .clk(clk), 
  .reset(reset),
  .x(x), 
  .w(w),
  .in_valid(in_valid), 
  .in_ready(in_ready),
  .out(out), 
  .out_valid(out_valid), 
  .out_ready(out_ready)
);

integer i;
reg [31:0] exp;

initial begin
clk=0;
forever #5 clk = ~clk;
end

// resett;
task resett;
begin
	reset=1;
	x=0; 
	w=0; 
	in_valid=0; 
	out_ready=0; 
	exp=0;
	@(posedge clk);
	@(posedge clk);
	reset=0;
end
endtask


task gendata(input logic [BW-1:0] dd);
begin
	@(negedge clk);
	x=dd;
	w=dd+1;
end
endtask

task randd;
begin
	@(negedge clk);
	x=$urandom_range(1,10);
	w=$urandom_range(1,10);
end
endtask




initial begin

resett;

@(negedge clk);
in_valid=1;
out_ready=1;

gendata(1);
out_ready=0;
gendata(2);
gendata(3);
out_ready=1;
gendata(4);


randd;

randd;
randd;
randd;
randd;

randd;





$display("COMPLETED simulation");
  #20;
  $finish;
end

initial begin
$dumpfile("wave.vcd");
$dumpvars();
end

endmodule
