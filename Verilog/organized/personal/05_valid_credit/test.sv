module tb;

  logic clk, resetn;

  logic        valid_L;
  logic        credit_L;
  logic [15:0] in_data;

  logic        valid_R;
  logic        out_data;
  logic        credit_R;

  model dut (
    .clk      (clk),
    .resetn   (resetn),
    .valid_L  (valid_L),
    .credit_L (credit_L),
    .in_data  (in_data),
    .valid_R  (valid_R),
    .out_data (out_data),
    .credit_R (credit_R)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    resetn = 0;
    valid_L = 0;
    credit_R = 0;
    in_data = 16'hA5C3;

    #20;
    resetn = 1;

    // send one word (1-cycle valid)
    @(posedge clk);
    valid_L = 1;
    @(posedge clk);
    valid_L = 0;

    // wait until streaming starts
    wait (valid_R);

    // consume 16 bits
    for (int i = 0; i < 16; i++) begin
      @(negedge clk);
      credit_R = 1;

      if (out_data !== in_data[i])
        $fatal(1, "Bit mismatch at %0d: got %b exp %b",
                  i, out_data, in_data[i]);

      @(posedge clk);
      @(negedge clk);
      credit_R = 0;
    end

    // must be done
    @(posedge clk);
    if (valid_R) $fatal(1, "valid_R should be low after completion");

    // credit must be returned
    if (!credit_L) $fatal(1, "credit_L not asserted at end");

    $display("TEST PASSED");
    $finish;
  end

endmodule
