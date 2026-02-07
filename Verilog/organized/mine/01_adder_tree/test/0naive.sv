
module adder_naive #(   parameter IN=16,
				     	parameter W=8
)(
	input logic [W-1:0] in[0:IN-1],
	output logic [W-1+IN:0] sum
);

logic [W-1+IN:0] temp;

integer i;
always_comb begin
	temp=0;
	for (i=0;i<IN;i++) begin
		temp=temp+in[i];
	end
	sum =temp;
end



endmodule 
