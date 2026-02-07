module ff (
	input wire clk,
	input wire d,
	input wire rst,
	output ref q
);

wire temp;

always @ (posedge clk)
temp <= d;
end

assign q = temp & ~rst; 


endmodule


