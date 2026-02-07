
module jk_ff (
	input  logic clk,
	input  logic j,
	input  logic k,
	output logic q,
	output logic nq 
);

	always_ff @(posedge clk) begin
		case ({j,k}) 
		2'b00: q<= q;
		2'b01: q<= 0;
		2'b10: q<= 1;
		2'b11: q<= ~q;
		endcase
	end

	assign nq=~q;

endmodule
