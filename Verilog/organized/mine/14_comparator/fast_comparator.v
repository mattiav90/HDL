

module fast_comparator #(parameter W=32)(
	input wire [W-1:0] a,
	input wire [W-1:0] b,
	output wire a_gt_b	
);

integer i;
reg done;
reg result;

always @ (*) begin

	for (i=0;i<W;i=i+1) begin
		if (!done) begin
			if(a[i]!=b[i]) begin
				done=1;
				result=a[i];
			end
		end
	end


end

endmodule
