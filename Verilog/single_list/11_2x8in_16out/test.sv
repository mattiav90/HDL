`timescale 1ns/1ps

module test();

logic        clk;
logic        reset;

logic [7:0]  din;
logic        l_valid;
logic        l_ready;

logic [15:0] dout;
logic        r_valid;
logic        r_ready;

model dut (
  .clk     (clk),
  .reset   (reset),
  .din     (din),
  .l_valid (l_valid),
  .l_ready (l_ready),
  .dout    (dout),
  .r_valid (r_valid),
  .r_ready (r_ready)
);

// clock
initial begin
clk = 0;
forever #5 clk = ~clk;
end


initial begin


resett;

@(negedge clk);
l_valid=1;
r_ready=1;


gendata (8'd1);
gendata (8'd2);
gendata (8'd3);
gendata (8'd4);
gendata (8'd5);
gendata (8'd6);
gendata (8'd7);
gendata (8'd8);

@(negedge clk);
r_ready=0;

repeat(3) @(posedge clk);

random();
random();
random();

r_ready=1;

random();
random();
random();


repeat(3) @(posedge clk);
$finish;
end


//gen data
task gendata (input logic [7:0] dd);
begin
	@(negedge clk);
	din=dd;
	$display("din: ",din);
end
endtask


task random;
begin
	@(negedge clk);
	din=$urandom_range(0,20);
	$display("din: ",din);
end
endtask


//reset
task resett;
begin
reset=1;
din=0;
l_valid=0;
r_ready=0;

repeat(3) @(posedge clk);
reset=0;
end
endtask


initial begin
  $dumpfile("wave.vcd");
  $dumpvars;
end

endmodule
