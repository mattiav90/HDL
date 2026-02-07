module model #(parameter int BW=8, K=16)(
  input  logic clk,
  input  logic reset,

  // left
  input  logic [BW-1:0] x, w,
  input  logic          in_valid,
  output logic          in_ready,

  // right
  input  logic          out_ready,
  output logic          out_valid,
  output logic [(BW*2+K):0] out
);

  logic [(BW*2+K):0] acc;
  logic [$clog2(K):0] cnt;       // counts accepted samples: 0..K-1
  logic               full;      // output pending (out_valid)

  wire push = full && out_ready; // output handshake
  wire grab = in_valid && in_ready;

  // Input ready only when not holding an unconsumed output
  assign in_ready  = !full;

  assign out_valid = full;
  assign out       = full ? acc : '0;

  always_ff @(posedge clk) begin
    if (reset) begin
      acc  <= '0;
      cnt  <= '0;
      full <= 1'b0;
    end else begin
      // If output was accepted, clear pending state (start fresh)
      if (push) begin
        full <= 1'b0;
        cnt  <= '0;
        acc  <= '0;
      end

      // Accept inputs only when not full
      if (grab) begin
        // accumulate
        acc <= (cnt == 0) ? (x*w) : (acc + x*w);

        // after K-th sample (cnt==K-1), mark output as pending
        if (cnt == K-1) begin
          full <= 1'b1;
          cnt  <= cnt; // don't care once full, but keep stable
        end else begin
          cnt <= cnt + 1;
        end
      end
    end
  end

endmodule
