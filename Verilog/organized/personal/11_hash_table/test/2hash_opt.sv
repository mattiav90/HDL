

/*
if high throughput and low latency are needed. 
make sure to overlap  hashing, memory access, and comparison.
--
use read and write in 2 separate blocks to parallelize them (dual-port behavior).

(key >> 1) ^ key, is a simple hash function. 
but you can precompute/pipeline it for higher clock rates.

-----------
if you want the read available in the same cycle, do not use ff for that
but just combinatorial logic. 
*/

module hash_table_opt2 #(
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
logic [MEM_W-1:0] add_read_r, add_write_r;


function [MEM_W-1:0] hash (input logic [KEY_W-1:0] key);
	hash = (key>>1) ^ key;
endfunction


always_ff @(posedge clk) begin
    add_read_r  <= hash(key_lookup);
    add_write_r <= hash(key_in);
end

always_ff @(posedge clk) begin
    if (we) begin
        mem_val[add_write_r] <= val_in;
        mem_key[add_write_r] <= key_in;
    end
end

always_ff @(posedge clk) begin
    val_read <= mem_val[add_read_r];
    key_read <= mem_key[add_read_r];
end

assign val_out = key_read==key_lookup ? mem_val[add_read_r] : 0;
assign hit =  key_read==key_lookup;




endmodule
