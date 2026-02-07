
module gray2binary_ok #(parameter N=16)(
	input logic [N-1:0] din,
	output logic [N-1:0] dout
);

logic [N-1:0] temp;

always_comb begin
	for(int i=0; i<N; i=i+1) begin
		temp[i] = ^(din>>i);
	end
end

assign dout=temp;

endmodule
