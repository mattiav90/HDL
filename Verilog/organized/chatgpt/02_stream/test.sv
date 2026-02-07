module tb;

  logic clk, reset;

  logic a_valid, a_ready, a_bit;
  logic b_valid, b_ready, b_bit;

  logic out_valid, out_ready;
  logic [19:0] out_data;

  mac10_stream dut (
    .clk(clk), .reset(reset),
    .a_valid(a_valid), .a_ready(a_ready), .a_bit(a_bit),
    .b_valid(b_valid), .b_ready(b_ready), .b_bit(b_bit),
    .out_valid(out_valid), .out_ready(out_ready),
    .out_data(out_data)
  );

  // clock
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    // init
    reset     = 1;
    a_valid   = 0;
    b_valid   = 0;
    a_bit     = 0;
    b_bit     = 0;
    out_ready = 1;

    repeat (2) @(posedge clk);
    reset = 0;

    // send 10 pairs of bytes
    repeat (10) begin
      send_byte(8'd3, 8'd4);   // product = 12
    end

    // wait for result
    wait (out_valid);
    $display("[%0t] OUT = %0d (expected %0d)",
             $time, out_data, 10*3*4);

    @(posedge clk);
    $finish;
  end

  // send one byte on a and b, LSB-first
  task send_byte(input logic [7:0] A, input logic [7:0] B);
    for (int i = 0; i < 8; i++) begin
      @(negedge clk);
      a_bit   = A[i];
      b_bit   = B[i];
      a_valid = 1;
      b_valid = 1;

      @(posedge clk);
      // aligned streams → no need to wait separately for ready
    end

    @(negedge clk);
    a_valid = 0;
    b_valid = 0;
  endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end
endmodule
