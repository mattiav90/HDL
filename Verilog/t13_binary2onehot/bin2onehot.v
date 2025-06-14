

module bin2onehot #(parameter W=4)(
	input wire [W-1:0] 		in,
	output reg [(2**W)-1:0] out
);


always @ (*) begin
	out=0;
	out[in] = 1; 
end


endmodule
