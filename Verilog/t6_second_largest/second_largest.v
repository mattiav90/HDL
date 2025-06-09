module second_largest #( parameter WIDTH=16 )
(
  input  wire [WIDTH-1:0] din,
  input  wire resetn,
  input  wire clk,
  output wire [WIDTH-1:0] dout
);

  reg [WIDTH-1:0] max = 0, max2 = 0;

  always @ (posedge clk) begin
    if (!resetn) begin
      max  = 0;
      max2 = 0;
    end else begin
      if (din >= max) begin
        max2 = max;
       	max  = din;
      end else if (din >= max2 & din< max) begin
        max2 = din;
      end
    end
  end

  assign dout = max2;

endmodule
