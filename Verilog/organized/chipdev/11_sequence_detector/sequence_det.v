module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

localparam S0=0;
localparam S1=1;
localparam S2=2;
localparam S3=3;
localparam S4=4;

reg [2:0] state;

always @(posedge clk) begin
  
  if (!resetn) begin
    state<=S0;
  end else  begin
    case(state) 
      S0: state = din==1 ? S1 : S0;
      S1: state = din==0 ? S2 : S1;
      S2: state = din==1 ? S3 : S0;
      S3: state = din==0 ? S4 : S1;
      S4: state = din==1 ? S3 : S0;
    endcase
  end
end

assign dout = (state==S4);

endmodule
