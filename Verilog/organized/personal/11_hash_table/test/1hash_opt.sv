

module hash_table_opt #(
	parameter VAL_W=16,
	parameter KEY_W=8,
	parameter SIZE=16
)(
input  logic clk,
input  logic we,
input  logic [KEY_W-1:0] key_in,
input  logic [VAL_W-1:0] val_in,
input  logic [KEY_W-1:0] key_lookup,
output logic [VAL_W-1:0] val_out,
output logic hit
);

localparam MEM_W=$clog2(SIZE);
logic [VAL_W-1:0] mem_val [0:SIZE-1];
logic [KEY_W-1:0] mem_key [0:SIZE-1];
logic [MEM_W-1:0] add_write, add_read;
logic [VAL_W-1:0] val_read;
logic [KEY_W-1:0] key_read;

function [MEM_W-1:0] hash (input logic [KEY_W-1:0] key);
	hash = (key>>1) ^ key;
endfunction


assign add_write = hash(key_in);
assign add_read = hash(key_lookup);


always_ff @(posedge clk) begin
	if(we) begin
		mem_val[add_write] <= val_in;
		mem_key[add_write] <= key_in;
	end else begin
		val_read <= mem_val[add_read];
		key_read <= mem_key[add_read];
	end
end


assign val_out = key_read==key_lookup ? val_read : 0;
assign hit =  key_read==key_lookup;




endmodule
