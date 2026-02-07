`timescale 1ns/1ps

module tb;

  localparam DW = 32;

  // DUT signals
  logic clk;
  logic resetn;
  logic [DW-1:0] din;
  logic [DW-1:0] dout;

  // Instantiate DUT
  model #(.DW(DW)) dut (
    .clk    (clk),
    .resetn (resetn),
    .din    (din),
    .dout   (dout)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;   // 100 MHz

  // Stimulus
  initial begin
    
    // Reset
	reset();

    // Apply values
    send_value(10);
    send_value(5);
    send_value(20);
    send_value(15);
    send_value(30);
    send_value(25);

    $display("Simulation finished.");
    $finish;
  end

  // Simple task to apply inputs
  task send_value(input [DW-1:0] v);
	@(posedge clk);
    din = v;
    $display("din=%0d  -> dout(max1)=%0d", v, dout);
  endtask

  // Reset
  task reset;
    resetn = 0;
    din = 0;
    repeat (2) @(posedge clk);
    resetn = 1;
  endtask


  initial begin
	$dumpfile("wave.vcd");
	$dumpvars();
  end

endmodule
