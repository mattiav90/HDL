// dot_product_stream.sv
// Simple dot-product engine (length K) with ready/valid.
// Consumes one (a,b) pair per cycle when both valid and output not blocking.
// Outputs one result per K accepted pairs.

module dot_product_stream #(
  parameter int W  = 8,     // input width (signed)
  parameter int K  = 16,    // dot length
  parameter int ACCW = 2*W + $clog2(K+1)
)(
  input  logic                   clk,
  input  logic                   rst_n,

  input  logic                   clear,   // clears internal state (like "start over"), synchronous

  input  logic signed [W-1:0]    a_data,
  input  logic                   a_valid,
  output logic                   a_ready,

  input  logic signed [W-1:0]    b_data,
  input  logic                   b_valid,
  output logic                   b_ready,

  output logic signed [ACCW-1:0] out_data,
  output logic                   out_valid,
  input  logic                   out_ready
);

  localparam int CW = (K <= 1) ? 1 : $clog2(K);

  logic signed [ACCW-1:0] acc;
  logic [CW-1:0]          cnt;

  wire hold_out = out_valid && !out_ready;

  // Consume pairs only if we can progress and both are valid
  assign a_ready = !hold_out && b_valid;
  assign b_ready = !hold_out && a_valid;

  wire take = a_valid && a_ready && b_valid && b_ready;
  wire signed [ACCW-1:0] prod = a_data * b_data;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      acc       <= '0;
      cnt       <= '0;
      out_data  <= '0;
      out_valid <= 1'b0;
    end else begin
      // synchronous clear wipes state and drops any pending output
      if (clear) begin
        acc       <= '0;
        cnt       <= '0;
        out_data  <= '0;
        out_valid <= 1'b0;
      end else begin
        // output handshake
        if (out_valid && out_ready) begin
          out_valid <= 1'b0;
          acc <= '0;
          cnt <= '0;
        end

        // stall if output is being held
        if (hold_out) begin
          // no updates
        end else if (take) begin
          // accumulate
          if (cnt == K-1) begin
            // finish this dot product
            out_data  <= acc + prod;
            out_valid <= 1'b1;
            // acc/cnt reset when output is accepted (above)
          end else begin
            acc <= acc + prod;
            cnt <= cnt + 1'b1;
          end
        end
      end
    end
  end

endmodule
