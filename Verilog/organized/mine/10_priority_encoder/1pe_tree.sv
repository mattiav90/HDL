
module PE_8b (
	input  logic [7:0] in,
	output logic [$clog2(8)-1:0] pos,
	output logic val
);

always_comb begin
	pos=0;
	casez(in)
	8'b00000001: pos=7;
	8'b0000001z: pos=6;
	8'b000001zz: pos=5;
	8'b00001zzz: pos=4;
	8'b0001zzzz: pos=3;
	8'b001zzzzz: pos=2;
	8'b01zzzzzz: pos=1;
	8'b1zzzzzzz: pos=0;
	endcase
end

assign val = |in;

endmodule





module PE_16b (
    input  [15:0] in,
    output [$clog2(16)-1:0] pos,
    output val
);

logic [$clog2(8)-1:0] pos1,pos2;
logic val1,val2;
logic pos3,val3;


PE_8b pe1 (in[15:8],pos1,val1);
PE_8b pe2 (in[7:0],pos2,val2);




assign val = |{val1,val2};
assign pos = val1 ? pos1 : {1'b1,pos2};

endmodule
