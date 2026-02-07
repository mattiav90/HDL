`timescale 1ns/1ps

module tb_mux_naive;

    // Parameters
    localparam WIDTH  = 64;
    localparam IN     = 16;

    // DUT signals
    logic [WIDTH-1:0] inputs [0:IN-1];
    logic [$clog2(IN)-1:0] sel;
    logic [WIDTH-1:0] out;

    // DUT instance
    mux_naive #(
        .W(WIDTH),
        .IN(IN)
    ) dut (
        .in(inputs),
        .sel(sel),
        .out(out)
    );

    // Task: drive all inputs with random data
    task drive_inputs;
        integer i;
        begin
            for (i = 0; i < IN; i++) begin
                inputs[i] = $random;
            end
        end
    endtask

    // Test sequence
    initial begin
        $display("Starting MUX test...");

        // Initialize
        drive_inputs();

        // Cycle through selections
        for (int s = 0; s < IN; s++) begin
            sel = s;
            #1; // small delay for propagation

            // Check
            if (out !== inputs[s]) begin
                $error("Mismatch at sel=%0d: expected %h, got %h", s, inputs[s], out);
            end else begin
                $display("sel=%0d OK: %h", s, out);
            end
        end

        // Try random inputs/selections
        repeat (10) begin
            drive_inputs();
            sel = $urandom_range(0, IN-1);
            #1;
            if (out !== inputs[sel]) begin
                $error("Random mismatch: sel=%0d expected=%h got=%h", sel, inputs[sel], out);
            end else begin
                $display("Random sel=%0d OK: %h", sel, out);
            end
        end

        $display("MUX test finished.");
        $finish;
    end

endmodule
