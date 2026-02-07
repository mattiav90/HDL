`timescale 1ns/1ps

module async_fifo_tb;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;

reg wr_clk = 0,   rd_clk = 0;
reg wr_rst_n = 0, rd_rst_n = 0;
reg wr_en = 0,    rd_en = 0;
reg [DATA_WIDTH-1:0]  wr_data = 0;
wire [DATA_WIDTH-1:0] rd_data;
wire full, empty;

integer i;

// Instantiate FIFO
async_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
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
always #1 wr_clk = ~wr_clk;  // 100 MHz
always #10 rd_clk = ~rd_clk;  // ~71 MHz

// Initial block
initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0, async_fifo_tb);

    // Reset
    wr_rst_n = 0;
    rd_rst_n = 0;
    #20;
    wr_rst_n = 1;
    rd_rst_n = 1;

    // Write 10 values
    fork
        begin : write_process
            for (i = 0; i < 30; i = i + 1) begin

                @(posedge wr_clk);   
	                wait(!full);
	                wr_en <= 1;
	                wr_data <= i + 100;

	                @(posedge wr_clk);
	               	 	wr_en <= 0;
            end
        end

        begin : read_process
            integer j;
            j = 0;
            #100; // delay before reading starts
            while (j < 30) begin

                @(posedge rd_clk);
	                if (!empty) begin
	                    rd_en <= 1;
	                    @(posedge rd_clk);
		                    rd_en <= 0;
		                    $display("Read data: %d", rd_data);
		                    j = j + 1;
                end
            end
        end
    join

    #100;
    $display("Simulation complete.");
    $finish;
end

endmodule
