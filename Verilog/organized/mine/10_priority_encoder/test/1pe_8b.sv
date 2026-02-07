
module PE_8b (
	input  logic [7:0] in,
	output logic [$clog2(8)-1:0] pos,
	output logic val
);



always_comb begin
	pos=0;
	casez(in)
	8'b0000000z: pos=7;
	8'b000000z0: pos=6;
	8'b00000z00: pos=5;
	8'b0000z000: pos=4;
	8'b000z0000: pos=3;
	8'b00z00000: pos=2;
	8'b0z000000: pos=1;
	8'bz0000000: pos=0;
	endcase
end


assign val = |in;


endmodule
