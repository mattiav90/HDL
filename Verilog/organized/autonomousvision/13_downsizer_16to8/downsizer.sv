module downsizer (
  input  logic        clk,
  input  logic        rst,

  input  logic [15:0] din,
  input  logic        valid_L,
  output logic        ready_L,

  output logic [7:0]  dout,
  output logic        valid_R,
  input  logic        ready_R
);

  logic [15:0] data;
  logic        have_word;   // 1 when data is valid
  logic        sel;         // 0 => send MSB, 1 => send LSB

  assign ready_L = !have_word;   // only 1-word buffer
  assign valid_R = have_word;

  always_ff @(posedge clk) begin
    if (rst) begin
      data      <= '0;
      have_word <= 1'b0;
      sel       <= 1'b0;
      dout      <= '0;
    end else begin
      // load new word when empty
      if (ready_L && valid_L) begin
        data      <= din;
        have_word <= 1'b1;
        sel       <= 1'b0;
        dout      <= din[15:8];       // present first byte immediately (registered)
      end

      // advance only on successful right-side transfer
      if (valid_R && ready_R) begin
        if (!sel) begin
          // MSB was just transferred, now present LSB
          sel  <= 1'b1;
          dout <= data[7:0];
        end else begin
          // LSB transferred, done
          have_word <= 1'b0;
          sel       <= 1'b0;
          // dout can hold last value; no need to clear
        end
      end
    end
  end

endmodule
