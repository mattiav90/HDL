
module pop_count_naive #(
	parameter W=16
)(
	input logic [W-1:0] in,
	output logic [$clog2(W):0] count
);

logic  [$clog2(W):0] temp;
 integer i;
 always_comb begin
 	temp=0;
	for (i=0;i<W;i++) begin
		temp=temp+in[i];
	end
 end


 assign count = temp;




endmodule
