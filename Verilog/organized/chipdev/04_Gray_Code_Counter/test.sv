`timescale 1ns/1ps

module tb;

  localparam DW = 4;   // you can set this to 32 if you want

  logic clk;
  logic resetn;
  logic [DW-1:0] dout;

  // DUT
  model #(.DW(DW)) dut (
    .clk    (clk),
    .resetn (resetn),
    .dout   (dout)
  );

  // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Popcount: count the number of 1 bits
  function automatic int popcount(input [DW-1:0] x);
    int i, c;
    begin
      c = 0;
      for (i = 0; i < DW; i = i + 1)
        c = c + x[i];
      popcount = c;
    end
  endfunction

  logic [DW-1:0] prev_dout;
  bit first_sample;

  // Task: step the clock, then check reset / Gray property
  task automatic step_and_check;
    logic [DW-1:0] dout_sample, diff;
    begin
      @(posedge clk);
      #1;              // let nonblocking assignments update dout
      dout_sample = dout;

      if (first_sample) begin
        first_sample = 0;
        prev_dout    = dout_sample;
        $display("time=%0t (first sample) resetn=%0b dout=%b",
                 $time, resetn, dout_sample);
      end else begin
        if (!resetn) begin
          // During synchronous active-low reset: dout must be 0
          if (dout_sample !== '0) begin
            $display("ERROR @%0t: resetn=0 but dout=%b (expected 0)",
                     $time, dout_sample);
            $fatal;
          end
        end else begin
          // After reset: check Gray property (only 1 bit changes)
          diff = prev_dout ^ dout_sample;
          if (popcount(diff) != 1) begin
            $display("ERROR @%0t: Gray violation: prev=%b dout=%b diff=%b popcount=%0d",
                     $time, prev_dout, dout_sample, diff, popcount(diff));
            $fatal;
          end
        end

        $display("time=%0t resetn=%0b dout=%b",
                 $time, resetn, dout_sample);
        prev_dout = dout_sample;
      end
    end
  endtask

  // Stimulus
  initial begin
    // VCD for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Init
    resetn       = 0;   // assert synchronous active-low reset
    first_sample = 1;
    prev_dout    = '0;

    // Keep reset low for a few cycles
    step_and_check();
    step_and_check();
    step_and_check();

    // Release reset, run some Gray codes
    resetn = 1;
    repeat (10) step_and_check();

    // Assert reset again to test restart
    resetn = 0;
    repeat (3) step_and_check();

    // Release reset again
    resetn = 1;
    repeat (10) step_and_check();

    $display("Test finished OK.");
    $finish;
  end

endmodule
