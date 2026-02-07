
module bin2gray_ok #(parameter N=16)(
	input logic [N-1:0] din,
	output logic [N-1:0] dout
);


assign dout = din ^ (din>>1);

endmodule 
