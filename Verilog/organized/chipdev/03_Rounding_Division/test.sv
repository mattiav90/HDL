`timescale 1ns/1ps

module tb_model;

  // Match DUT parameters
  localparam DIV_LOG2  = 3;
  localparam OUT_WIDTH = 32;
  localparam IN_WIDTH  = OUT_WIDTH + DIV_LOG2;

  // DUT I/O
  logic [IN_WIDTH-1:0]  din;
  logic [OUT_WIDTH-1:0] dout;

  // Instantiate DUT
  model #(
    .DIV_LOG2 (DIV_LOG2),
    .OUT_WIDTH(OUT_WIDTH),
    .IN_WIDTH (IN_WIDTH)
  ) dut (
    .din  (din),
    .dout (dout)
  );

  // ----------------------------------------------------------
  // Reference model: divide by 2^DIV_LOG2, round to nearest,
  // saturate if overflow
  // ----------------------------------------------------------
  function automatic [OUT_WIDTH-1:0] ref_div_round(input [IN_WIDTH-1:0] val);
    // Use an extra bit to detect overflow
    logic [IN_WIDTH:0]      extended;
    logic [IN_WIDTH:0]      q;
    logic [DIV_LOG2-1:0]    rem;
    integer                 half;

    begin
      extended = {1'b0, val};            // zero-extend input
      q        = extended >> DIV_LOG2;   // integer division
      rem      = extended[DIV_LOG2-1:0]; // remainder bits
      half     = 1 << (DIV_LOG2-1);      // 0.5 * 2^DIV_LOG2

      // Round up if remainder >= 0.5
      if (rem >= half)
        q = q + 1;

      // Saturate to all 1s if overflow
      if (q > {1'b0, {OUT_WIDTH{1'b1}}})
        ref_div_round = {OUT_WIDTH{1'b1}};
      else
        ref_div_round = q[OUT_WIDTH-1:0];
    end
  endfunction

  // ----------------------------------------------------------
  // Task: apply a value, wait, and check result
  // ----------------------------------------------------------
  task automatic apply_and_check(input [IN_WIDTH-1:0] v);
    logic [OUT_WIDTH-1:0] expected;
    begin
      din = v;
      #1; // let combinational logic settle

      expected = ref_div_round(v);

      if (dout !== expected) begin
        $display("ERROR: din=%0d (0x%h) dout=%0d (0x%h) expected=%0d (0x%h)",
                 v, v, dout, dout, expected, expected);
        $fatal;
      end else begin
        $display("OK   : din=%0d (0x%h) dout=%0d (0x%h)",
                 v, v, dout, dout);
      end
    end
  endtask

  // ----------------------------------------------------------
  // Stimulus
  // ----------------------------------------------------------
  initial begin
    // Waveform dump
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_model);

    // Some directed tests
    apply_and_check(0);                        // 0
    apply_and_check(1);                        // small
    apply_and_check(1 << (DIV_LOG2-1));        // exactly 0.5
    apply_and_check((1 << DIV_LOG2) - 1);      // just below 1.0
    apply_and_check(8);                        // generic
    apply_and_check(15);
    apply_and_check(16);
    apply_and_check(1234);

    // Near saturation / overflow tests
    apply_and_check({IN_WIDTH{1'b1}});         // all 1s
    apply_and_check({1'b0, {IN_WIDTH-1{1'b1}}});

    $display("All tests completed.");
    $finish;
  end

endmodule
