


module carry_select #(
	parameter W=32,
	parameter BL=8
)
(
	input logic [W-1:0] a,
	input logic [W-1:0] b,
	output logic [W-1:0] sum
);


localparam N=W/BL;
logic [N:0] carry;

assign carry[0]=0;


genvar i;
generate
	for(i=0;i<N;i++) begin
	logic [BL-1:0] sum0,sum1;
	logic c0,c1;

	assign {c0,sum0} = a[BL*i +:BL] + b[BL*i +:BL] + 1'b0;
	assign {c1,sum1} = a[BL*i +:BL] + b[BL*i +:BL] + 1'b1;

	assign sum[BL*i +:BL] = carry[i] ? sum1 : sum0;
	assign carry[i+1] = carry[i] ? c1 : c0;
		
	end
endgenerate




endmodule
