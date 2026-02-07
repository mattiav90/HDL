
// this is more common for syntax replication and is evaluated
// in compile time. 
// immediately the direct syntax that is written is replicated. 
// this is a cleaner implementation for this solution



module reverse #(parameter W=8)(
	input wire [W-1:0] din,
	output wire [W-1:0] dout
);

genvar i;
generate
 for (i=0;i<W;i=i+1) begin
	assign dout[i] = din[W-1-i];
 end

endgenerate



endmodule



// this is simulated in runtime-style. 
// so the simulator will use the variable integer i to
// run a for loop. 
// when synthesizing, there is no difference from the other case. 
// the loop is unrolled into asign statement of wires. 
module bit_reverse_naive #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] in,
    output reg  [WIDTH-1:0] out
);

integer i;
always @(*) begin
    for (i = 0; i < WIDTH; i = i + 1) begin
        out[i] = in[WIDTH - 1 - i];
    end
end

endmodule
