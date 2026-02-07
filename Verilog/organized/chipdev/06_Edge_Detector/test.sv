`timescale 1ns/1ps

module tb;

  logic clk;
  logic resetn;
  logic din;
  logic dout;

  // DUT
  model dut (
    .clk    (clk),
    .resetn (resetn),
    .din    (din),
    .dout   (dout)
  );

  // Clock generation (10 ns period)
  initial clk = 0;
  always #5 clk = ~clk;

  // Internal reference model state: previous din at last clock
  logic prev_din;

  // Task: drive inputs for one cycle and check output
  task automatic step_and_check(input logic din_val,
                                input logic resetn_val);
    logic exp_dout;
    begin
      // Drive inputs for the upcoming clock edge
      din    = din_val;
      resetn = resetn_val;

      // Advance one clock, then sample after nonblocking updates
      @(posedge clk);
      #1;

      // Expected dout on THIS cycle:
      //  - If in reset, dout must be 0
      //  - Else, pulse when we see a rising edge of din
      if (!resetn_val)
        exp_dout = 1'b0;
      else
        exp_dout = (!prev_din && din_val);  // rising edge now -> pulse now

      // Check
      if (dout !== exp_dout) begin
        $display("ERROR @%0t: din=%0b resetn=%0b dout=%0b expected=%0b (prev_din=%0b)",
                 $time, din_val, resetn_val, dout, exp_dout, prev_din);
        $fatal;
      end else begin
        $display("OK    @%0t: din=%0b resetn=%0b dout=%0b",
                 $time, din_val, resetn_val, dout);
      end

      // Update reference model state for NEXT cycle
      if (!resetn_val)
        prev_din = 1'b0;
      else
        prev_din = din_val;
    end
  endtask

  // Stimulus
  initial begin
    // VCD for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Init ref model
    prev_din = 1'b0;

    // Start in reset
    din    = 0;
    resetn = 0;

    // A few cycles in reset (dout must stay 0)
    step_and_check(0, 0);
    step_and_check(1, 0);  // din ignored during reset
    step_and_check(0, 0);

    // Release reset
    resetn = 1;

    // Pattern to test multiple rising edges and gaps
    // First rising edge of din
    step_and_check(0, 1);  // no pulse
    step_and_check(1, 1);  // rising edge -> pulse THIS cycle
    step_and_check(1, 1);  // still high, no new edge -> no pulse
    step_and_check(1, 1);  // still high, no pulse
    step_and_check(0, 1);  // falling edge -> no pulse

    // Another rising edge later
    step_and_check(0, 1);
    step_and_check(1, 1);  // rising edge -> pulse
    step_and_check(1, 1);  // no pulse
    step_and_check(0, 1);  // back to 0

    // Assert reset again mid-stream
    step_and_check(1, 0);
    step_and_check(0, 0);

    // Release reset and do a couple more cycles
    step_and_check(0, 1);
    step_and_check(1, 1);  // rising edge -> pulse
    step_and_check(0, 1);

    $display("Test finished OK.");
    $finish;
  end

endmodule
