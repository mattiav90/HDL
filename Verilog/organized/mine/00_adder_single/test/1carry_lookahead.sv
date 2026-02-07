


//carry lookahead 

module carry_lookahead #(
	parameter W=32
)(
	input logic [W-1:0] a,
	input logic [W-1:0] b,
	input logic cin,
	output logic [W-1:0] sum,
	output logic cout
);

logic [W-1:0] gen, prop;
logic [W:0] carry;

assign gen = a&b;
assign prop = a^b;

assign carry[0] = cin;


genvar i;
generate
	for (i=0;i<W;i++) begin
		assign carry[i+1] = gen[i] | (prop[i]&carry[i]);
	end
endgenerate

assign sum = prop ^ carry[W-1:0];
assign cout = carry[W];



endmodule
