module model #(parameter
  DATA_WIDTH=32
) (
  input [DATA_WIDTH-1:0] din,
  output logic dout
);

integer i;
reg out;

always @(*) begin
  out=1;
  for (i=0;i<DATA_WIDTH;i=i+1) begin
    out = din[i]==din[DATA_WIDTH-1-i] ? out : 0;
  end

end

assign dout = out;

endmodule
