

module naive #(parameter W=32)(
	input logic [W-1:0] in,
	input logic [$clog2(W)-1:0] shift,
	output logic [W-1:0] out
);


always_comb begin
out = in<<shift;
end


endmodule
