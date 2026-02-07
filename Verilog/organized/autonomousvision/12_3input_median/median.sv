

module median #(parameter N=8)(
	input logic [N-1:0] a,
	input logic [N-1:0] b,
	input logic [N-1:0] c,
	output logic [N-1:0] out
);

logic [N-1:0] median;

always_comb begin
	if ((a<=b && a>=c) || (a<=c && a>=b)) begin
		median=a;
	end else if ((b<=a && b>=c) || (b<=c && b>=a)) begin
		median=b;
	end else begin
		median=c;
	end
end

assign out=median;

endmodule
