
//this is the version with the shift register

module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

localparam L=4;

logic [L-1:0] temp;

always_ff @(posedge clk) begin
  if(~resetn) begin
    temp<=0;
  end else begin
    temp<= { temp[L-2:0] , din };
  end
end

assign dout = temp==4'b1010;

endmodule


// S0 ->(1) S1 ->(0) S2 ->(1) S3 ->(0) S4
// 

