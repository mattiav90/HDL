`timescale 1ns/1ps

module tb;

  localparam BW = 16;
  localparam N  = 10;  // how many Fibonacci terms to check

  logic              clk;
  logic              resetn;
  logic [BW-1:0]     dout;

  // DUT
  model #(.BW(BW)) dut (
    .clk    (clk),
    .resetn (resetn),
    .dout   (dout)
  );

  // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Expected Fibonacci sequence (first N terms)
  logic [BW-1:0] fib [0:N-1];

  initial begin
    fib[0] = 16'd1;
    fib[1] = 16'd1;
    fib[2] = 16'd2;
    fib[3] = 16'd3;
    fib[4] = 16'd5;
    fib[5] = 16'd8;
    fib[6] = 16'd13;
    fib[7] = 16'd21;
    fib[8] = 16'd34;
    fib[9] = 16'd55;
  end

  // Task: drive reset value for one cycle and check dout against expected
  task automatic check_term(input logic resetn_val,
                            input [BW-1:0] expected,
                            input int       idx);
    begin
      resetn = resetn_val;

      @(posedge clk);
      #1;  // let nonblocking assignments settle

      if (dout !== expected) begin
        $display("ERROR @%0t: idx=%0d resetn=%0b dout=%0d (0x%h) expected=%0d (0x%h)",
                 $time, idx, resetn_val, dout, dout, expected, expected);
        $fatal;
      end else begin
        $display("OK    @%0t: idx=%0d resetn=%0b dout=%0d",
                 $time, idx, resetn_val, dout);
      end
    end
  endtask

  // Stimulus
  initial begin
    // VCD dump for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Start in reset
    resetn = 0;

    // First term while in reset (F0 = 1)
    check_term(0, fib[0], 0);

    // Release reset, check next terms F1..F(N-1)
    for (int i = 1; i < N; i++) begin
      check_term(1, fib[i], i);
    end

    // Assert reset mid-stream and verify it restarts sequence
    $display("---- Asserting reset mid-stream ----");
    check_term(0, fib[0], 0);  // F0 again
    check_term(1, fib[1], 1);  // F1 again
    check_term(1, fib[2], 2);  // F2 again

    $display("Test finished OK.");
    $finish;
  end

endmodule
