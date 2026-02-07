`timescale 1ns/1ps

module tb;

  localparam BW = 8;  // you can set to 16 to match the DUT

  logic [BW-1:0] din;
  logic [$clog2(BW):0] dout;

  // DUT
  model #(.BW(BW)) dut (
    .din (din),
    .dout(dout)
  );

  // Reference popcount function
  function automatic int popcount(input [BW-1:0] x);
    int c = 0;
    for (int i = 0; i < BW; i++)
      c += x[i];
    return c;
  endfunction

  // Task to apply and check
  task automatic apply_and_check(input [BW-1:0] val);
    int expected;
    begin
      din = val;
      #1; // allow combinational logic to settle

      expected = popcount(val);

      if (dout !== expected) begin
        $display("ERROR: din=%b dout=%0d expected=%0d", din, dout, expected);
        $fatal;
      end else begin
        $display("OK   : din=%b dout=%0d", din, dout);
      end
    end
  endtask

  // Stimulus
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Directed tests
    apply_and_check(8'b0000_0000);
    apply_and_check(8'b1111_1111);
    apply_and_check(8'b0000_0001);
    apply_and_check(8'b1000_0000);
    apply_and_check(8'b1010_1010);
    apply_and_check(8'b1100_0011);

    // Random tests
    repeat (10) apply_and_check($random);

    $display("All tests PASSED.");
    $finish;
  end

endmodule
