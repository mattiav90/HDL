
/*

Why this is better:

Stores keys and values to detect collisions.
Only reports a hit when the stored key matches the lookup key.
Same 1-cycle latency.
Still no advanced collision resolution, but shows understanding of correctness.

hashing strategy: simple XOR for speed. 
in this verion there is no collision handling. if there is a collision, the memory
just gets overwritten. tuning the hash function to avoid collision is good enough for high
frequency applications.
this implementation has only one cycle latency. 

in this version I store also the key and return the result only if there was actually ah hit. 
in case there was not an hit, the stored key will be different than the requested one and
notthing is pushed back
*/


module hash_table_opt #(
    parameter KEY_W = 8,
    parameter VAL_W = 16,
    parameter SIZE  = 16
)(
    input  logic                  clk,
    input  logic                  we,
    input  logic [KEY_W-1:0]      key_in,
    input  logic [VAL_W-1:0]      val_in,
    input  logic [KEY_W-1:0]      key_lookup,
    output logic [VAL_W-1:0]      val_out,
    output logic                  hit
);

    localparam ADDR_W = $clog2(SIZE);

    // Simple XOR hash: XOR lower and upper ADDR_W bits of key
    function automatic [ADDR_W-1:0] hash(input logic [KEY_W-1:0] key);
        hash = key ^ key>>1;
    endfunction

    wire [ADDR_W-1:0] addr_write = hash(key_in);
    wire [ADDR_W-1:0] addr_read  = hash(key_lookup);

    logic [KEY_W-1:0] key_mem [0:SIZE-1];
    logic [VAL_W-1:0] val_mem [0:SIZE-1];

    logic [KEY_W-1:0] read_key;
    logic [VAL_W-1:0] read_val;

    always_ff @(posedge clk) begin
        if (we) begin
            key_mem[addr_write] <= key_in;
            val_mem[addr_write] <= val_in;
        end

        read_key <= key_mem[addr_read];
        read_val <= val_mem[addr_read];
    end

    assign hit     = (read_key == key_lookup);
    assign val_out = hit ? read_val : '0;

endmodule
