module rx2_xor8 (
  input  logic       clk,
  input  logic       rst_n,
  input  logic       in_bit,
  input  logic       in_valid,
  output logic [7:0] out_data,
  output logic       out_valid
);

  logic [7:0] w0, w1;
  logic [3:0] bit_cnt;
  logic       done;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      w0       <= '0;
      w1       <= '0;
      bit_cnt  <= '0;
      done     <= 1'b0;
      out_data <= '0;
      out_valid<= 1'b0;
    end else begin
      out_valid <= 1'b0;   // default: pulse
      done      <= 1'b0;   // default: pulse

      if (in_valid) begin
        if (bit_cnt < 8)
          w0[bit_cnt[2:0]] <= in_bit;
        else
          w1[bit_cnt[2:0]] <= in_bit;

        if (bit_cnt == 15) begin
          bit_cnt <= '0;
          done    <= 1'b1;      // marks "pair complete" for next cycle output
        end else begin
          bit_cnt <= bit_cnt + 1'b1;
        end
      end

      // one-cycle-late output
      if (done) begin
        out_data  <= w0 ^ w1;
        out_valid <= 1'b1;
      end
    end
  end

endmodule
