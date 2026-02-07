`timescale 1ns/1ps

module tb_model;

  // Parameters
  localparam SIZE = 32;

  // DUT signals
  logic [SIZE-1:0] din;
  logic            enable;
  logic [$clog2(SIZE-1):0] addr;
  logic [SIZE-1:0] dout0, dout1, dout2, dout3;

  // Instantiate DUT
  model #(.SIZE(SIZE)) dut (
    .din   (din),
    .enable(enable),
    .addr  (addr),
    .dout0 (dout0),
    .dout1 (dout1),
    .dout2 (dout2),
    .dout3 (dout3)
  );

  initial begin
    // For waveform viewing (optional)
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_model);

    // Init
    din    = '0;
    enable = 1'b0;
    addr   = '0;
    #5;

    // --- Test enable = 1, addr = 0 ---
    din    = 32'h1111_1111;
    enable = 1'b1;
    addr   = 0;
    #5;
    $display("T1: en=%0b addr=%0d din=%h  d0=%h d1=%h d2=%h d3=%h",
             enable, addr, din, dout0, dout1, dout2, dout3);

    // --- Test enable = 1, addr = 1 ---
    din    = 32'h2222_2222;
    enable = 1'b1;
    addr   = 1;
    #5;
    $display("T2: en=%0b addr=%0d din=%h  d0=%h d1=%h d2=%h d3=%h",
             enable, addr, din, dout0, dout1, dout2, dout3);

    // --- Test enable = 1, addr = 2 ---
    din    = 32'h3333_3333;
    enable = 1'b1;
    addr   = 2;
    #5;
    $display("T3: en=%0b addr=%0d din=%h  d0=%h d1=%h d2=%h d3=%h",
             enable, addr, din, dout0, dout1, dout2, dout3);

    // --- Test enable = 1, addr = 3 ---
    din    = 32'h4444_4444;
    enable = 1'b1;
    addr   = 3;
    #5;
    $display("T4: en=%0b addr=%0d din=%h  d0=%h d1=%h d2=%h d3=%h",
             enable, addr, din, dout0, dout1, dout2, dout3);

    // --- Test enable = 0 (outputs should go to 0) ---
    din    = 32'hFFFF_FFFF;
    enable = 1'b0;
    addr   = 2;
    #5;
    $display("T5: en=%0b addr=%0d din=%h  d0=%h d1=%h d2=%h d3=%h",
             enable, addr, din, dout0, dout1, dout2, dout3);

    $display("Testbench finished.");
    $finish;
  end

endmodule
