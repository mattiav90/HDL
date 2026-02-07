


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


initial begin
wr_clk=0;
forever #10 wr_clk=!wr_clk;
end

initial begin
rd_clk=0;
forever #2 rd_clk=!rd_clk;
end



initial begin

//reset
wr_rst_n=0;
rd_rst_n=0;
#50;
wr_rst_n=1;
rd_rst_n=1;


fork 
	begin: write

		for(i=0;i<30;i=i+1) begin
			@(posedge wr_clk);
			wait(!full);
				@(posedge wr_clk);
				wr_en=1;
				wr_data=i+10;
				@(posedge wr_clk);
				wr_en=0;
		end

		
	end

	begin: read
		j=0;
		#100;
		while(j<30) begin
			@(posedge rd_clk);
			if(!empty) begin
				rd_en=1;
				@(posedge rd_clk);
					rd_en=0;
					$display("data read: %d",rd_data);
					j=j+1;
			end

		end
		
	end

join



$finish;
end



initial begin
$dumpfile("wave.vcd");$dumpvars;
end


endmodule
