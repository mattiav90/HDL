
/*
Basic synchronous RAM usage for key-value storage.
Simple hashing (address = lower bits).
1-cycle read latency, write-through.
No collision resolution, so overwrites can happen (common naive limitation).


*/


module hash_table_naive #(
    parameter KEY_W = 8,
    parameter VAL_W = 16,
    parameter SIZE  = 16  // table size, power of two
)(
    input  logic                  clk,
    input  logic                  we,
    input  logic [KEY_W-1:0]      key_in,
    input  logic [VAL_W-1:0]      val_in,
    input  logic [KEY_W-1:0]      key_lookup,
    output logic [VAL_W-1:0]      val_out
);

    localparam ADDR_W = $clog2(SIZE);

    // Simple XOR hash: XOR lower and upper ADDR_W bits of key
    function automatic [ADDR_W-1:0] hash(input logic [KEY_W-1:0] key);
        hash = key ^ key>>1 ;
    endfunction

    wire [ADDR_W-1:0] addr_write = hash(key_in);
    wire [ADDR_W-1:0] addr_read  = hash(key_lookup);

    logic [VAL_W-1:0] tablee [0:SIZE-1];

    always_ff @(posedge clk) begin
        if (we) begin
            tablee[addr_write] <= val_in;
        end
    end

    always_ff @(posedge clk) begin
		if(~we) begin
	    	val_out <= tablee[addr_read];
		end
    end

endmodule
