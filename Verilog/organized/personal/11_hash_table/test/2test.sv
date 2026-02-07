`timescale 1ns/1ps

module tb_hash_table_opt;

    localparam KEY_W = 8;
    localparam VAL_W = 16;
    localparam SIZE  = 16;

    logic clk;
    logic we;
    logic [KEY_W-1:0] key_in;
    logic [VAL_W-1:0] val_in;
    logic [KEY_W-1:0] key_lookup;
    logic [VAL_W-1:0] val_out;
    logic hit;

    // DUT instance
    hash_table_opt2 #(
        .KEY_W(KEY_W),
        .VAL_W(VAL_W),
        .SIZE(SIZE)
    ) dut (
        .clk(clk),
        .we(we),
        .key_in(key_in),
        .val_in(val_in),
        .key_lookup(key_lookup),
        .val_out(val_out),
        .hit(hit)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("=== Hash Table Test Start ===");
        
        // Init
        we = 0;
        key_in = 0;
        val_in = 0;
        key_lookup = 0;
        
        @(posedge clk);

        // Write some key-value pairs
        write_entry(8'h12, 16'hAAAA);
        write_entry(8'h34, 16'hBBBB);
        write_entry(8'h56, 16'hCCCC);

        // Read them back
        read_entry(8'h12);
        read_entry(8'h34);
        read_entry(8'h56);

        // Try reading a non-existing key
        read_entry(8'h78);

        $display("=== Test Done ===");
        $finish;
    end

    // Task to write
    task write_entry(input [KEY_W-1:0] key, input [VAL_W-1:0] val);
        begin
            @(posedge clk);
            we      = 1;
            key_in  = key;
            val_in  = val;
            @(posedge clk);
            we      = 0;
            $display("[WRITE] key=%h, val=%h", key, val);
        end
    endtask

    // Task to read
    task read_entry(input [KEY_W-1:0] key);
        begin
            @(posedge clk);
            key_lookup = key;
            @(posedge clk); // Wait for read
            $display("[READ] key=%h -> hit=%0d, val=%h", key, hit, val_out);
        end
    endtask


    initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
    end

endmodule
