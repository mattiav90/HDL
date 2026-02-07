`timescale 1ns/1ps

module tb_model;

  logic        clk;
  logic        resetn;
  logic [7:0]  din;
  logic [17:0] dout;
  logic        run;

  // DUT
  model dut (
    .clk    (clk),
    .resetn (resetn),
    .din    (din),
    .dout   (dout),
    .run    (run)
  );

  // Clock: 10 ns
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    int errors = 0;
    int expected;

    // Initial values
    clk    = 0;
    resetn = 0;
    din    = 8'd0;

    // Hold reset low for a couple of cycles
    repeat (2) @(posedge clk);
    resetn = 1;

    // One extra cycle after releasing reset
    @(posedge clk);

    // === Test 1: A = [3,4,5], B = [2,1,3] ===
    // Expected dot = 3*2 + 4*1 + 5*3 = 25
    expected = 3*2 + 4*1 + 5*3;

    din = 8'd3; @(posedge clk);  // a1
    din = 8'd4; @(posedge clk);  // a2
    din = 8'd5; @(posedge clk);  // a3
    din = 8'd2; @(posedge clk);  // b1
    din = 8'd1; @(posedge clk);  // b2
    din = 8'd3; @(posedge clk);  // b3

    // After the 6th input, wait one more clock for count to wrap to 0
    din = 8'd0;
    @(posedge clk);  // here dout should be the dot product

    if (dout !== expected) begin
      $display("ERROR: Dot product mismatch. Expected %0d, got %0d", expected, dout);
      errors++;
    end else begin
      $display("Dot product correct: %0d", dout);
    end

    // Optional: watch stability for a couple more cycles
    @(posedge clk);
    if (dout !== expected) begin
      $display("ERROR: dout did not remain stable. Expected %0d, got %0d", expected, dout);
      errors++;
    end

    // === Final result ===
    if (errors == 0) begin
      $display("====================================");
      $display("           TEST PASSED ✅");
      $display("====================================");
    end else begin
      $display("====================================");
      $display("           TEST FAILED ❌");
      $display("        Errors: %0d", errors);
      $display("====================================");
    end

    $finish;
  end

  // Simple monitor to see what happens each clock
  always @(posedge clk) begin
    $display("t=%0t resetn=%0b din=%0d dout=%0d run=%0b count=%0d",
             $time, resetn, din, dout, run, dut.count);
  end

endmodule
