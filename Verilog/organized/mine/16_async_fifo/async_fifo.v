
// asynchrous-FIFO. 
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
	//write ports
    input  wire wr_clk,
    input  wire wr_rst_n,
    input  wire wr_en,
    input  wire [DATA_WIDTH-1:0] wr_data,
    output wire full,

	//read ports
    input  wire rd_clk,
    input  wire rd_rst_n,
    input  wire rd_en,
    output reg  [DATA_WIDTH-1:0] rd_data,
    output wire empty
);

localparam DEPTH = 1 << ADDR_WIDTH;

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

// Write domain pointers
reg [ADDR_WIDTH:0] wr_ptr_bin = 0;
reg [ADDR_WIDTH:0] wr_ptr_gray = 0;
reg [ADDR_WIDTH:0] rd_ptr_gray_sync1 = 0, rd_ptr_gray_sync2 = 0;

// Read domain pointers
reg [ADDR_WIDTH:0] rd_ptr_bin = 0;
reg [ADDR_WIDTH:0] rd_ptr_gray = 0;
reg [ADDR_WIDTH:0] wr_ptr_gray_sync1 = 0, wr_ptr_gray_sync2 = 0;

// Bin 2 gray converted
function [ADDR_WIDTH:0] bin2gray(input [ADDR_WIDTH:0] bin);
    bin2gray = (bin >> 1) ^ bin;
endfunction

// Gray to bin converter
function [ADDR_WIDTH:0] gray2bin(input [ADDR_WIDTH:0] gray);
 	integer i;
    begin
        gray2bin[ADDR_WIDTH] = gray[ADDR_WIDTH]; // MSB stays the same
        for (i = ADDR_WIDTH-1; i >= 0; i = i - 1) begin
            gray2bin[i] = gray2bin[i+1] ^ gray[i];
        end
    end
endfunction


// Write logic
always @(posedge wr_clk or negedge wr_rst_n) begin
    if (!wr_rst_n) begin
        wr_ptr_bin <= 0;
        wr_ptr_gray <= 0;
    end else if (wr_en && !full) begin
        mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
        wr_ptr_bin <= wr_ptr_bin + 1;
        wr_ptr_gray <= bin2gray(wr_ptr_bin + 1);
    end
end


// Read logic
always @(posedge rd_clk or negedge rd_rst_n) begin
    if (!rd_rst_n) begin
        rd_ptr_bin <= 0;
        rd_ptr_gray <= 0;
        rd_data <= 0;
    end else if (rd_en && !empty) begin
        rd_data <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
        rd_ptr_bin <= rd_ptr_bin + 1;
        rd_ptr_gray <= bin2gray(rd_ptr_bin + 1);
    end
end


// Sync rd_ptr_gray into write domain.
// just pass it through 2 ff.
always @(posedge wr_clk or negedge wr_rst_n) begin
    if (!wr_rst_n) begin
        rd_ptr_gray_sync1 <= 0;
        rd_ptr_gray_sync2 <= 0;
    end else begin
        rd_ptr_gray_sync1 <= rd_ptr_gray;
        rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
    end
end


// Sync wr_ptr_gray into read domain
// just pass it through 2 ff. 
always @(posedge rd_clk or negedge rd_rst_n) begin
    if (!rd_rst_n) begin
        wr_ptr_gray_sync1 <= 0;
        wr_ptr_gray_sync2 <= 0;
    end else begin
        wr_ptr_gray_sync1 <= wr_ptr_gray;
        wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
    end
end


// Compute full (in write clock domain)
wire [ADDR_WIDTH:0] rd_ptr_bin_sync = gray2bin(rd_ptr_gray_sync2);
assign full = ( (wr_ptr_bin[ADDR_WIDTH] != rd_ptr_bin_sync[ADDR_WIDTH]) && ( wr_ptr_bin[ADDR_WIDTH-1:0] == rd_ptr_bin_sync[ADDR_WIDTH-1:0]) );

// Compute empty (in read clock domain)
wire [ADDR_WIDTH:0] wr_ptr_bin_sync = gray2bin(wr_ptr_gray_sync2);
assign empty = (rd_ptr_bin == wr_ptr_bin_sync);


endmodule
