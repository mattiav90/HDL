
module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  input din_en,
  output logic dout
);

logic [DATA_WIDTH-1:0] data;
logic [$clog2(DATA_WIDTH):0] count;
logic go;

always @(posedge clk) begin
  if(!resetn) begin
    data<=0;
    count<=0;
  end else begin

	if(din_en) begin
		data<=din;
		count<=0;
		go<=1;
	end else if(go && count<DATA_WIDTH) begin
		count<=count+1;
	end else if(go && count==DATA_WIDTH) begin
		count<=0;
		go<=0;
	end		

  end
end

assign dout =data[count];

endmodule
