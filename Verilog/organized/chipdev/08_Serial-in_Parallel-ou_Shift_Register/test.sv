`timescale 1ns/1ps

module tb;

  // Keep it small for readability; behavior is the same for 16
  localparam BW = 4;

  logic              clk;
  logic              resetn;
  logic              din;
  logic [BW-1:0]     dout;

  // DUT
  model #(.BW(BW)) dut (
    .clk    (clk),
    .resetn (resetn),
    .din    (din),
    .dout   (dout)
  );

  // Clock: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Reference shift register
  logic [BW-1:0] temp_ref;

  // Task: drive one bit for one cycle and check dout
  task automatic step_and_check(
    input logic resetn_val,
    input logic din_val
  );
    logic [BW-1:0] next_temp;
    begin
      // Drive inputs for this cycle
      resetn = resetn_val;
      din    = din_val;

      // Compute expected next state
      if (!resetn_val)
        next_temp = '0;
      else
        next_temp = (temp_ref << 1) + din_val;

      // Advance clock and sample after nonblocking assignments
      @(posedge clk);
      #1;

      // Check DUT output
      if (dout !== next_temp) begin
        $display("ERROR @%0t: resetn=%0b din=%0b | temp_ref(old)=%b dout=%b expected=%b",
                 $time, resetn_val, din_val, temp_ref, dout, next_temp);
        $fatal;
      end else begin
        $display("OK    @%0t: resetn=%0b din=%0b | dout=%b",
                 $time, resetn_val, din_val, dout);
      end

      // Update reference state
      temp_ref = next_temp;
    end
  endtask

  // Stimulus
  initial begin
    // VCD for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    temp_ref = '0;
    din      = 0;
    resetn   = 0;

    // A few cycles in reset — dout must stay 0
    step_and_check(0, 0);
    step_and_check(0, 1);
    step_and_check(0, 0);

    // Release reset and shift a known pattern: 1,0,1,1,...
    step_and_check(1, 1);  // dout = 0001
    step_and_check(1, 0);  // dout = 0010
    step_and_check(1, 1);  // dout = 0101
    step_and_check(1, 1);  // dout = 1011

    // Keep shifting more bits to test overflow behavior
    step_and_check(1, 0);  // dout = 0110 (1011<<1 + 0 = 10110 -> 0110)
    step_and_check(1, 1);  // dout = 1101
    step_and_check(1, 0);  // dout = 1010
    step_and_check(1, 1);  // dout = 0101

    // Assert reset mid-stream and confirm it clears
    step_and_check(0, 1);
    step_and_check(0, 0);

    // Release reset and shift a different pattern
    step_and_check(1, 0);  // dout = 0000
    step_and_check(1, 1);  // dout = 0001
    step_and_check(1, 1);  // dout = 0011
    step_and_check(1, 0);  // dout = 0110
    step_and_check(1, 0);  // dout = 1100

    $display("Test finished OK.");
    $finish;
  end

endmodule
