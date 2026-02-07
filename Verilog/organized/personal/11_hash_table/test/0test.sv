`timescale 1ns/1ps

module tb_hash_table_naive;

    // Parameters
    localparam KEY_W = 8;
    localparam VAL_W = 16;
    localparam SIZE  = 16;

    // Signals
    logic                  clk;
    logic                  we;
    logic [KEY_W-1:0]      key_in;
    logic [VAL_W-1:0]      val_in;
    logic [KEY_W-1:0]      key_lookup;
    logic [VAL_W-1:0]      val_out;

    // DUT instance
    hash_table_naive #(
        .KEY_W(KEY_W),
        .VAL_W(VAL_W),
        .SIZE (SIZE)
    ) dut (
        .clk       (clk),
        .we        (we),
        .key_in    (key_in),
        .val_in    (val_in),
        .key_lookup(key_lookup),
        .val_out   (val_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz clock

    // Stimulus
    initial begin
        $display("=== Starting hash_table_naive testbench ===");
        we = 0;
        key_in = '0;
        val_in = '0;
        key_lookup = '0;

        @(posedge clk);

        // Write some key-value pairs
        write_kv(8'h12, 16'hAAAA);
        write_kv(8'h34, 16'hBBBB);
        write_kv(8'h56, 16'hCCCC);

        // Read them back
        read_kv(8'h12);
        read_kv(8'h34);
        read_kv(8'h56);

        // Demonstrate overwrite (collision or same key)
        write_kv(8'h12, 16'hDEAD);
        read_kv(8'h12);

        // Example of hash collision: keys that map to same address
        // Depending on hash, adjust keys so that collisions happen
        write_kv(8'h0F, 16'h1111);
        write_kv(8'h8F, 16'h2222); // likely collision if ADDR_W=4
        read_kv(8'h0F);
        read_kv(8'h8F);

        $display("=== Test complete ===");
        $finish;
    end

    // Tasks for cleaner code
    task write_kv(input [KEY_W-1:0] k, input [VAL_W-1:0] v);
        begin
            @(posedge clk);
            we = 1;
            key_in = k;
            val_in = v;
            $display("[%0t] WRITE  key=%h  val=%h", $time, k, v);
            @(posedge clk);
            we = 0;
        end
    endtask

    task read_kv(input [KEY_W-1:0] k);
        begin
            @(posedge clk);
            key_lookup = k;
            @(posedge clk); // wait 1 cycle for latency
            $display("[%0t] READ   key=%h  => val=%h", $time, k, val_out);
        end
    endtask


    initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
    end

endmodule
