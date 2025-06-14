

module onehot2bin #(parameter W=4)(
	input  wire [(2**W)-1:0] in,
	output reg  [W-1:0] out
);

integer i;

always @ (*) begin

for (i=0; i<(2**W)-1; i=i+1) begin
	if (in[i]) begin
		out=i;
	end
end

end


endmodule
