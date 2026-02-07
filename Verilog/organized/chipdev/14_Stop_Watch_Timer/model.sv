module model #(parameter
  DATA_WIDTH = 16,
  MAX = 99
) (
    input clk,
    input reset, start, stop,
    output logic [DATA_WIDTH-1:0] count
);

logic [DATA_WIDTH-1:0] temp;
logic go;

always_ff @(posedge clk) begin
  if(reset) begin
    go<=0;
    temp<=0;
  end else if(stop) begin
    go<=0;
  end else if (go || start) begin
    go<=1;
    temp <= temp==MAX ? 0 : temp+1;
  end
end

assign count=temp;


endmodule
