

module mux_naive #(
	parameter W=16,
	parameter IN=32
)(
input  logic [W-1:0] in[0:IN-1],
input  logic [$clog2(IN)-1:0] sel,
output logic [W-1:0] out
);


assign out = in[sel];


endmodule
