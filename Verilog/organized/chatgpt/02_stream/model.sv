module mac10_stream (
  input  logic        clk, reset,

  input  logic        a_valid,
  output logic        a_ready,
  input  logic        a_bit,

  input  logic        b_valid,
  output logic        b_ready,
  input  logic        b_bit,

  output logic        out_valid,
  input  logic        out_ready,
  output logic [19:0] out_data
);

  logic [7:0]  A, B;
  logic [2:0]  bitc;      // 0..7
  logic [3:0]  macc;      // 0..9
  logic [19:0] psum;

  // simplest: only accept when not holding an output; require aligned bits (a&b same cycle)
  assign a_ready  = !out_valid;
  assign b_ready  = !out_valid;
  assign out_data = psum;

  always_ff @(posedge clk) begin
    if (reset) begin
      A <= '0; B <= '0; bitc <= '0; macc <= '0; psum <= '0; out_valid <= 1'b0;
    end else begin
      // hold result until consumed
      if (out_valid) begin
        if (out_ready) begin
          out_valid <= 1'b0;
          psum      <= '0;
          macc      <= '0;
          bitc      <= '0;
        end
      end else if (a_valid && b_valid) begin
        // capture 1 bit from each stream (LSB-first)
        logic [7:0] A_next, B_next;
        A_next = A;  B_next = B;
        A_next[bitc] = a_bit;
        B_next[bitc] = b_bit;
        A <= A_next; B <= B_next;

        if (bitc == 3'd7) begin
          psum <= psum + (A_next * B_next);   // 8x8->16, accumulated into 20b
          bitc <= '0;

          if (macc == 4'd9) begin
            out_valid <= 1'b1;   // 10th accumulation done
          end else begin
            macc <= macc + 4'd1;
          end
        end else begin
          bitc <= bitc + 3'd1;
        end
      end
    end
  end

endmodule
