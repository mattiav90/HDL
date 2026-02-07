module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic onehot
);

reg [$clog2(DATA_WIDTH):0] c;
integer i;

always @(*) begin
  c=0;
  for (i=0; i<DATA_WIDTH; i=i+1) begin
    c=c+din[i];
  end
end

assign onehot = c==1;

endmodule
