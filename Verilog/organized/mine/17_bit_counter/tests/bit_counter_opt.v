

module bit_counter_opt #(parameter W=32)(
	input wire [W-1:0] in,
	output reg [$clog2(W):0] count
);


localparam half=W/2;

wire [$clog2(half):0] h1,h2;
wire [$clog2(W):0] counter;


bit_counter_sim #(half) b1 (in[W-1:half],h1);
bit_counter_sim #(half) b2 (in[half-1:0],h2);


assign counter = h1 + h2;


always @(*) begin
count<=counter;
end






endmodule
