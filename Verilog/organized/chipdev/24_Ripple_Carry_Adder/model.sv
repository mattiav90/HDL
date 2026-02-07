`include "FA.sv"

module model #(
	parameter BW=32
)(
	input logic [BW-1:0] a,
	input logic [BW-1:0] b,
	output logic [BW:0] sum,
	output logic [BW-1:0] cout
);

FA f0(
	.a(a[0]),
	.b(b[0]),
	.cin(1'b0),
	.sum(sum[0]),
	.cout(cout[0])
);

genvar i;
generate 
	for(i=1;i<BW;i=i+1) begin
		FA fi(
			.a(a[i]),
			.b(b[i]),
			.cin(cout[i-1]),
			.sum(sum[i]),
			.cout(cout[i])
		);
	end
endgenerate


assign sum[BW] = cout[BW-1];



endmodule
