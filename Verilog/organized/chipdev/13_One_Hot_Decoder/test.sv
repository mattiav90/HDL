`timescale 1ns/1ps

module tb;

  localparam BW = 8;  // can set to 16 if you like

  logic [BW-1:0] din;
  logic          onehot;

  // DUT
  model #(.BW(BW)) dut (
    .din    (din),
    .onehot (onehot)
  );

  // Simple task to apply and print
  task automatic check(input [BW-1:0] val);
    bit expected;
    begin
      din = val;
      #1;  // combinational settle

      // expected: exactly one bit set
      expected = (val != 0) && ((val & (val - 1)) == 0);

      if (onehot !== expected) begin
        $display("ERROR: din=%b onehot=%0b expected=%0b",
                 din, onehot, expected);
        $fatal;
      end else begin
        $display("OK   : din=%b onehot=%0b",
                 din, onehot);
      end
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Non–one-hot
    check(8'b0000_0000);
    check(8'b0000_0011);
    check(8'b1010_0000);
    check(8'b1111_0000);

    // One-hot
    check(8'b0000_0001);
    check(8'b0000_0010);
    check(8'b0001_0000);
    check(8'b1000_0000);

    // A few randoms
    repeat (10) check($random);

    $display("All tests passed.");
    $finish;
  end

endmodule
