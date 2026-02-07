`timescale 1ns/1ps

module tb;

  // Use a small width to see things clearly; can set to 16 as in DUT
  localparam BW = 4;

  logic              clk;
  logic              resetn;
  logic              din_en;
  logic [BW-1:0]     din;
  logic              dout;

  // DUT
  model #(.BW(BW)) dut (
    .clk    (clk),
    .resetn (resetn),
    .din_en (din_en),
    .din    (din),
    .dout   (dout)
  );

  // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Reference model: internal shift register
  logic [BW-1:0] temp_ref;

  // Task: drive one cycle and check dout
  task automatic step_and_check(
    input logic        resetn_val,
    input logic        din_en_val,
    input logic [BW-1:0] din_val
  );
    logic [BW-1:0] next_temp;
    logic          exp_dout;
    begin
      // Drive inputs for the upcoming clock edge
      resetn = resetn_val;
      din_en = din_en_val;
      din    = din_val;

      // Advance one clock, then sample after nonblocking updates
      @(posedge clk);
      #1;

      // Compute reference next state (intended behavior):
      //  - sync active-low reset
      //  - if din_en, load din
      //  - else shift right
      if (!resetn_val)
        next_temp = '0;
      else if (din_en_val)
        next_temp = din_val;
      else
        next_temp = temp_ref >> 1;

      temp_ref = next_temp;
      exp_dout = temp_ref[0];

      if (dout !== exp_dout) begin
        $display("ERROR @%0t: resetn=%0b din_en=%0b din=%b | dout=%b expected=%b temp_ref=%b",
                 $time, resetn_val, din_en_val, din_val, dout, exp_dout, temp_ref);
        $fatal;
      end else begin
        $display("OK    @%0t: resetn=%0b din_en=%0b din=%b | dout=%b temp_ref=%b",
                 $time, resetn_val, din_en_val, din_val, dout, temp_ref);
      end
    end
  endtask

  // Stimulus
  initial begin
    // VCD for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Init reference state
    temp_ref = '0;

    // Start in reset
    resetn = 0;
    din_en = 0;
    din    = '0;

    // A few cycles in reset (dout must be 0, temp_ref=0)
    step_and_check(0, 0, 4'b0000);
    step_and_check(0, 1, 4'b1010);  // din ignored under reset
    step_and_check(0, 0, 4'b1111);

    // Release reset, load a value and shift it out
    step_and_check(1, 1, 4'b1011);  // load 1011 -> dout should be LSB = 1
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0101 -> dout=1
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0010 -> dout=0
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0001 -> dout=1
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0000 -> dout=0
    step_and_check(1, 0, 4'bxxxx);  // keep shifting 0 -> dout=0

    // Load a new value while mid-shift
    step_and_check(1, 1, 4'b1100);  // load new din, restart shifting from LSB=0
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0110 -> dout=0
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0011 -> dout=1
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0001 -> dout=1
    step_and_check(1, 0, 4'bxxxx);  // shift -> 0000 -> dout=0

    // Assert reset mid-stream and verify we go back to 0-shifted state
    step_and_check(0, 0, 4'bxxxx);
    step_and_check(0, 1, 4'b1111);

    // Release reset and shift another fresh value
    step_and_check(1, 1, 4'b0101);
    repeat (6) step_and_check(1, 0, 4'bxxxx);

    $display("Test finished OK.");
    $finish;
  end

endmodule
