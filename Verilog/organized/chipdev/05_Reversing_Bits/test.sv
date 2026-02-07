`timescale 1ns/1ps

module tb;

  localparam BW = 8;   // You can set to 32 for full test

  logic [BW-1:0] din;
  logic [BW-1:0] dout;

  // Instantiate DUT
  model #(.BW(BW)) dut (
    .din  (din),
    .dout (dout)
  );

  // --------------------------------------------
  // Reference function for bit reversal
  // --------------------------------------------
  function automatic [BW-1:0] reverse_bits(input [BW-1:0] v);
    int i;
    begin
      for (i = 0; i < BW; i++)
        reverse_bits[i] = v[BW-1-i];
    end
  endfunction

  // --------------------------------------------
  // Task: apply din, wait, compare
  // --------------------------------------------
  task automatic apply_and_check(input [BW-1:0] v);
    logic [BW-1:0] expected;
    begin
      din = v;
      #1;                  // allow combinational logic to settle
      expected = reverse_bits(v);

      if (dout !== expected) begin
        $display("ERROR: din=%b dout=%b expected=%b",
                 din, dout, expected);
        $fatal;
      end else begin
        $display("OK   : din=%b dout=%b", din, dout);
      end
    end
  endtask

  // --------------------------------------------
  // Stimulus
  // --------------------------------------------
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    apply_and_check(8'b0000_0000);
    apply_and_check(8'b0000_0001);
    apply_and_check(8'b1000_0000);
    apply_and_check(8'b1111_0000);
    apply_and_check(8'b0000_1111);
    apply_and_check(8'b1010_1010);
    apply_and_check(8'b1111_1111);

    // random tests
    repeat (10) apply_and_check($random);

    $display("All tests PASSED.");
    $finish;
  end

endmodule
