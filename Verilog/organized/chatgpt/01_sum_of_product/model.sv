module model #(
  parameter int BW = 8,
  parameter int K  = 16
)(
  input  logic clk,
  input  logic reset,

  // input side
  input  logic [BW-1:0] x, w,
  input  logic          in_valid,
  output logic          in_ready,

  // output side
  output logic [OUT_W-1:0] out,
  output logic             out_valid,
  input  logic             out_ready
);

  localparam int OUT_W   = 2*BW + $clog2(K) + 1;
  localparam int COUNT_W = $clog2(K+1); // can represent 0..K

  logic [OUT_W-1:0] psum;
  logic [COUNT_W-1:0] count;

  wire accept_in  = in_valid && in_ready;
  wire accept_out = out_valid && out_ready;

  // Ready when we are still collecting inputs (not full).
  // When count == K, we are holding an output and must not accept more.
  assign in_ready  = (count < K);

  // Valid when we have collected K samples and are holding output.
  assign out_valid = (count == K);

  // Keep out stable; downstream uses out_valid to qualify it.
  assign out = psum;

  always_ff @(posedge clk) begin
    if (reset) begin
      psum  <= '0;
      count <= '0;
    end else begin
      // If output is being accepted, clear state for next accumulation.
      if (accept_out) begin
        psum  <= '0;
        count <= '0;
      end

      // Accept input only when ready.
      // Note: if accept_out and accept_in happen same cycle, this code
      // as written will first clear then add the new product (good for throughput).
      if (accept_in) begin
        psum  <= psum + {{(OUT_W-2*BW){1'b0}}, (x * w)};
        count <= count + 1'b1;
      end
    end
  end

endmodule
