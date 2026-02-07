

module add_carry_save #(parameter W=8)(
	input wire [W-1:0] a,
	input wire [W-1:0] b,
	input wire [W-1:0] c,
	output wire [W-1:0] sum, //partial sum
	output wire [W-1:0] carry //carry shifter left
);


assign sum   = a^b^c;
assign carry = (a&b) | (a&c) | (b&c); 

endmodule
