


//this is simple, just shift everything right of one spot, then
//put the new din in dout[0]

module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input din,
  output logic [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] temp;

integer i;

always @ (posedge clk) begin

  if(!resetn) begin
    temp=0;
  end else begin
    temp=temp<<1;
    temp[0]=din;
  end
end

assign dout = temp;

endmodule

