

// This is a priority encoder for 32 bit. 
// It is pipelined in 2 stages for high throughput. 
// the first stage is composed of 4 8bit encoders in parallel
// followed by one 4 bit encoder at the end. (this creates the 2 stage pipeline)

// 32 bit input priority encoder

module pe_32b (
					input wire [31:0]   		in,
					input wire 					clk,
					input wire 					rst,
					output reg 					val,
					output reg [$clog2(32):0] 	out
);

wire [3:0]	val_t;
wire [3:0]	out_t[3:0];

wire   		val_2s;

reg [3:0]   val_t_reg;
reg [2:0]   out_t_reg [3:0];
wire [1:0]  out_2s;
reg [1:0]   out_2s_reg;


// this 4 priority encoders works in parallel.
// this is the first stage of the pipeline.
// this is all combinatorial logic!!
pe_8b pe_0 (
	.in(in[31:24]),
	.val(val_t[0]),
	.out(out_t[0])
);

pe_8b pe_1 (
	.in(in[23:16]),
	.val(val_t[1]),
	.out(out_t[1])	
);

pe_8b pe_2 (
	.in(in[15:8]),
	.val(val_t[2]),
	.out(out_t[2])	
);

pe_8b pe_3 (
	.in(in[7:0]),
	.val(val_t[3]),
	.out(out_t[3])	
);


// first pipeline stage.
always @ (posedge clk or posedge rst) begin

	if (rst) begin
		val_t_reg <=0;
		out_t_reg[0] <=0;
		out_t_reg[1] <=0;
		out_t_reg[2] <=0;
		out_t_reg[3] <=0;
	end else begin
		val_t_reg[0] <= val_t[3]; out_t_reg[0] <= out_t[3];
		val_t_reg[1] <= val_t[2]; out_t_reg[1] <= out_t[2];
		val_t_reg[2] <= val_t[1]; out_t_reg[2] <= out_t[1];
		val_t_reg[3] <= val_t[0]; out_t_reg[3] <= out_t[0];	
		$display("1st pipe val: %b  ",val_t_reg);			
	end
end

//another stage of combinatorial logic. 
pe_4b pe_4(
	.in(val_t_reg),
	.val(val_2s),
	.out(out_2s)
);


// second stage of the pipeline
// latch it to the output register.
// 
always @ (posedge clk or posedge rst) begin

	if (rst) begin
		out<=0;
		val<=0;
	end
	else begin
		//{ winning_group_2_bits , winning_bit_in_group }
		out<= {out_2s,out_t_reg[out_2s]};
		val<= val_2s;
	end


end




endmodule
