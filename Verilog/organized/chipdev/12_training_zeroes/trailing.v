module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);

reg [$clog2(DATA_WIDTH):0] c;
reg go;

integer i;


always @(*) begin
  c=0;
  go=1;
 for (i=0; i<DATA_WIDTH; i=i+1) begin
  c= c + (!din[i] && go);
  go = din[i] ? 0 : go;
 end

end

assign dout = c;

endmodule
