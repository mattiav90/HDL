`timescale 1ns/1ps

module tb;

  logic clk;
  logic resetn;
  logic div2;
  logic div4;
  logic div6;

  // DUT
  model dut (
    .clk   (clk),
    .resetn(resetn),
    .div2  (div2),
    .div4  (div4),
    .div6  (div6)
  );

  // Clock: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // VCD for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Start in reset
    resetn = 0;

    // Hold reset for a few cycles
    repeat (3) @(posedge clk);

    // Release reset
    resetn = 1;

    // Run for some cycles and print the outputs
    repeat (40) begin
      @(posedge clk);
      $display("time=%0t clk=%0b resetn=%0b div2=%0b div4=%0b div6=%0b",
               $time, clk, resetn, div2, div4, div6);
    end

    $display("Simulation finished.");
    $finish;
  end

endmodule
