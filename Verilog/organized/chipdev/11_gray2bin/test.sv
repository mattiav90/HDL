`timescale 1ns/1ps

module tb;

  localparam BW = 4;

  logic [BW-1:0] gray;
  logic [BW-1:0] bin;

  // DUT
  model #(.BW(BW)) dut (
    .gray(gray),
    .bin (bin)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Test a few known values
    gray = 4'b0000; #1;
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    gray = 4'b0001; #1;
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    gray = 4'b0011; #1;  // gray of 2
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    gray = 4'b0010; #1;  // gray of 3
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    gray = 4'b0110; #1;  // gray of 4
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    gray = 4'b0111; #1;  // gray of 5
    $display("gray=%b bin=%b (dec %0d)", gray, bin, bin);

    $display("Done.");
    $finish;
  end

endmodule
