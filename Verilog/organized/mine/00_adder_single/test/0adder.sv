

module adder0 #(parameter W=32)
(
	input logic [W-1:0] a,
	input logic [W-1:0] b,
	output logic [W-1:0] out
);

assign out = a+b;

endmodule
