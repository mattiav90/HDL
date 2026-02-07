module tb;

  logic clk;
  logic j, k;
  logic q, nq;

  jk_ff dut ( .clk(clk), .j(j), .k(k), .q(q), .nq(nq) );

  always #5 clk = ~clk;

  task tick;
    @(posedge clk);
    #1;
  endtask

  initial begin
    clk = 0;
    j = 0; k = 0;

    // init: drive to known state using reset behavior (J=0,K=1)
    j = 0; k = 1; tick;
    if (q !== 0)  $fatal(1, "Expected reset q=0, got %b", q);
    if (nq !== 1) $fatal(1, "Expected nq=1, got %b", nq);

    // hold
    j = 0; k = 0; tick;
    if (q !== 0)  $fatal(1, "Hold failed, q changed to %b", q);

    // set
    j = 1; k = 0; tick;
    if (q !== 1)  $fatal(1, "Set failed, q=%b", q);
    if (nq !== 0) $fatal(1, "nq mismatch, nq=%b", nq);

    // toggle (1->0)
    j = 1; k = 1; tick;
    if (q !== 0)  $fatal(1, "Toggle failed (1->0), q=%b", q);

    // toggle (0->1)
    j = 1; k = 1; tick;
    if (q !== 1)  $fatal(1, "Toggle failed (0->1), q=%b", q);

    // reset
    j = 0; k = 1; tick;
    if (q !== 0)  $fatal(1, "Reset failed, q=%b", q);

    $display("TEST PASSED");
    $finish;
  end

endmodule
