

module model #(parameter W=8) (
	input  logic [W-1:0] din;
	output logic [(2**W)-1:0] dout		
);


genvar i;
generate
	for(i=0; i<(2^**W); i=i+1) begin
		assign dout[i]= i<din ? 1 : 0;
	end
endgenerate



endmodule
