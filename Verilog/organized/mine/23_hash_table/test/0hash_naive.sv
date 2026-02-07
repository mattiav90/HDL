
module hash_table_naive #(
	parameter KEY_W=8,
	parameter VAL_W=8,
	parameter SIZE=16
)(
	input  logic clk,
	input  logic we,
	input  logic [KEY_W-1:0] key_in,
	input  logic [VAL_W-1:0] val_in,
	input  logic [KEY_W-1:0] key_lookup,
	output logic [VAL_W-1:0] val_out
);

localparam SIZE_W = $clog2(SIZE);
logic [VAL_W-1:0] mem [0:SIZE-1];
logic [SIZE_W-1:0] read_add, write_add;


function [SIZE_W-1:0] hash (input logic [KEY_W-1:0] key);
	hash = key ^ key>>1;
endfunction


assign write_add = hash(key_in);
assign read_add  = hash(key_lookup);

always_ff @(posedge clk) begin
	if (we) begin
		mem[write_add]<=val_in;	
	end else begin
		val_out<= mem[read_add];
	end
end




endmodule
