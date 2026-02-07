module test();

parameter DATA_WIDTH=8;
parameter ADDR_WIDTH=4;
reg wr_clk, wr_rst_n, wr_en;
reg rd_clk, rd_rst_n, rd_en;
reg [DATA_WIDTH-1:0] wr_data;
wire [DATA_WIDTH-1:0] rd_data;
wire full, empty;
integer i,j;

async_fifo #(
    .W(DATA_WIDTH),
    .L(ADDR_WIDTH)
) dut (
    .wr_clk(wr_clk),
    .wr_rst_n(wr_rst_n),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .full(full),

    .rd_clk(rd_clk),
    .rd_rst_n(rd_rst_n),
    .rd_en(rd_en),
    .rd_data(rd_data),
    .empty(empty)
);

// Clock generation
initial begin
    wr_clk=0;
    forever #10 wr_clk = !wr_clk;
end

initial begin
    rd_clk=0;
    forever #2 rd_clk = !rd_clk;
end

// ------------------
// Write Task
// ------------------
task automatic write_task;
begin
    for(i=0; i<30; i=i+1) begin
        @(posedge wr_clk);
        wait(!full);
        @(posedge wr_clk);
        wr_en = 1;
        wr_data = i + 10;
        $display("[%0t] WRITE: Data = %0d (full=%b)", $time, wr_data, full);
        @(posedge wr_clk);
        wr_en = 0;
    end
end
endtask

// ------------------
// Read Task
// ------------------
task automatic read_task;
begin
    j = 0;
    #100; // delay before starting read
    while(j < 30) begin
        @(posedge rd_clk);
        if(!empty) begin
            rd_en = 1;
            @(posedge rd_clk);
            rd_en = 0;
            $display("[%0t] READ : Data = %0d (empty=%b)", $time, rd_data, empty);
            j = j + 1;
        end
    end
end
endtask

// Main test sequence
initial begin
    // Reset
    wr_rst_n = 0;
    rd_rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    #50;
    wr_rst_n = 1;
    rd_rst_n = 1;

    // Run write & read in parallel
    fork
        write_task();
        read_task();
    join

    $finish;
end

// Dump waves
initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule
