`timescale 1ns/1ps

module tb_mux_naive;

    // Parameters
    localparam WIDTH  = 64;
    localparam SEL_W  = 4;
    localparam N_INPUTS = 1 << SEL_W;

    // DUT signals
    logic [WIDTH-1:0] inputs [0:N_INPUTS-1];
    logic [SEL_W-1:0] sel;
    logic [WIDTH-1:0] out;

    // DUT instance
    mux_naive #(
        .WIDTH(WIDTH),
        .SEL_W(SEL_W)
    ) dut (
        .inputs(inputs),
        .sel(sel),
        .out(out)
    );

    // Task: drive all inputs with random data
    task drive_inputs;
        integer i;
        begin
            for (i = 0; i < N_INPUTS; i++) begin
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
        for (int s = 0; s < N_INPUTS; s++) begin
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
            sel = $urandom_range(0, N_INPUTS-1);
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
