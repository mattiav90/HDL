
module model #(
parameter DIV_LOG2 = 3,
OUT_WIDTH=32,
IN_WIDTH=OUT_WIDTH+DIV_LOG2
)(
	input logic [IN_WIDTH-1:0] din,
	output logic [OUT_WIDTH-1:0] dout
);

logic [OUT_WIDTH:0] temp;

assign temp = (din>>DIV_LOG2) + din[DIV_LOG2-1];
assign dout = temp[OUT_WIDTH] ? {OUT_WIDTH{1'b1}} : temp; 


endmodule
