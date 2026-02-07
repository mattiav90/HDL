module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] larg,second;

always @(posedge clk ) begin
  
  if (!resetn) begin
    larg<=0;
    second<=0;
  end else begin

    if(din>larg) begin
      second<=larg;
      larg<=din;
    end else if(din>=second && din<=larg) begin
      second<=din;
    end
  end

end


assign dout = second;

endmodule
