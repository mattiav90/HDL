`timescale 1ns/1ps

module test;

    parameter W = 64;
    localparam STAGES = $clog2(W);
    localparam LATENCY = STAGES+2; // pipeline latency of the popcount_tree_pipe

    logic clk;
    logic rst;
    logic [W-1:0] in;
    logic [$clog2(W+1)-1:0] count;
    logic [$clog2(W+1)-1:0] fifo [0:LATENCY-1]; // FIFO to hold expected results delayed by latency
    logic [10:0] write,read;

    integer i;

    // Instantiate the pipelined popcount module
    popcount_tree_pipe #(.W(W)) pop (
        .clk(clk),
        .rst(rst),
        .in(in),
        .count(count)
    );

    // Clock generation (10ns period)
    always begin
    clk = 0;
    forever  #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        rst = 1;
        in = 0;
        write=LATENCY-1;
        read=0;
        #20;
        rst = 0;
        repeat (20) push_input;
        $finish;
    end

    // Task to generate random input and calculate expected popcount
    task  push_input;
        integer j;
        begin
        	@(negedge clk);
            in = {$random,$random};
            // Compute expected popcount for current input
            fifo[write]=0;
            for (i=0;i<W;i++) begin
				fifo[write]=fifo[write]+in[i];
            end

			@(posedge clk);
            if(count==fifo[read])begin
				$display("ok. reset: %b in: %b count: %d",rst,in,count);
            end else begin
				$display("error. reset: %b in: %b count: %0d check: %0d",rst,in,count,fifo[read]);
            end


            write=write+1;
            read=read+1;
            write = write==LATENCY? 0 : write;
            read  = read ==LATENCY? 0 : read;

            
        end
    endtask



    // Dump waveform
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

endmodule
