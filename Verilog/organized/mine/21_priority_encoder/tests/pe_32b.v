

// double pipelined implementation. 


module pe_32b (
		input wire clk,
		input wire rst,
		input wire [31:0] in,
		output reg [$clog2(32)-1:0] out,
		output wire val
);

// 8 bit
wire [2:0] lev1 [3:0];
wire [3:0] val1;
reg  [2:0] r_lev1 [3:0];
reg  [3:0] r_val1;

//4 bit
wire [1:0] lev2;
wire val2;
reg [1:0] r_lev2;
reg r_val2;


pe_8b pe0 (in[7:0]  , lev1[0], val1[0]);
pe_8b pe1 (in[15:8] , lev1[1], val1[1]);
pe_8b pe2 (in[23:16], lev1[2], val1[2]);
pe_8b pe3 (in[31:24], lev1[3], val1[3]);



always @ (posedge clk or negedge rst) begin
	if (!rst) begin
		r_lev1[0]<=0;	r_val1[0]<=0;
		r_lev1[1]<=0;	r_val1[1]<=0;
		r_lev1[2]<=0;	r_val1[2]<=0;
		r_lev1[3]<=0;	r_val1[3]<=0;
	end else begin
		r_lev1[0]<=lev1[0]; r_val1[0]<=val1[0]; 
		r_lev1[1]<=lev1[1];	r_val1[1]<=val1[1];
		r_lev1[2]<=lev1[2];	r_val1[2]<=val1[2];
		r_lev1[3]<=lev1[3];	r_val1[3]<=val1[3];
	end
end


pe_4b pe4 (r_val1,lev2,val2);

always @ (posedge clk or negedge rst) begin
	if(!rst)  begin
		r_lev2<=0; r_val2<=0;
	end else begin
		r_lev2<=lev2; r_val2<=val2;
	end
end

assign val = r_val2;


always @ (posedge clk or negedge rst) begin
	if(!rst)  begin
		out<=0;
	end else begin
		out<={r_lev2,r_lev1[r_lev2]};
	end
end


endmodule 
