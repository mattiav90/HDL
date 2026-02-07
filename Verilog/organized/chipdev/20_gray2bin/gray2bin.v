module model #(parameter
  DATA_WIDTH = 16
) (
  input [DATA_WIDTH-1:0] gray,
  output logic [DATA_WIDTH-1:0] bin
);

integer i;
reg [DATA_WIDTH-1:0] temp;


always @(*) begin
  bin[DATA_WIDTH-1]=gray[DATA_WIDTH-1];
  for (i=DATA_WIDTH-1;i>0;i--) begin
    bin[i-1] = bin[i] ^ gray[i-1];
  end
end



endmodule
