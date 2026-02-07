

module naive #(
	parameter W=32
)(
	input  logic [W-1:0] in,
	output logic [$clog2(W)-1:0] idx,
	output logic valid
);

logic found;

integer i;
always_comb begin
	found=0;
	for(i=W-1; i>=0; i--) begin

		if (in[i]==1 & found==0) begin
			idx=i;
			valid=1;
			found=1;
		end
	end
end



endmodule
