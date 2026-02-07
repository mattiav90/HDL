

module async_fifo #(
 parameter W=8,
 parameter L=8	
)(
input  logic wr_clk,
input  logic wr_rst_n,
input  logic wr_en,
input  logic [W-1:0] wr_data,
output logic full,

input  logic rd_clk,
input  logic rd_rst_n,
input  logic rd_en,
output logic [W-1:0] rd_data,
output logic empty
);

localparam LW=$clog2(L);

logic [W-1:0] mem [0:L-1];

//pointers
logic [LW:0] wr_ptr_bin, wr_ptr_gray;
logic [LW:0] rd_ptr_bin, rd_ptr_gray;

//synchronize across domain
logic [LW:0] wr_sync1, wr_sync2;
logic [LW:0] rd_sync1, rd_sync2;


//functions for data conversion
function [LW:0] bin2gray (input [LW:0] din);
	bin2gray = (din>>1)^din;
endfunction


function [LW:0] gray2bin (input [LW:0] din);
integer i;
begin
	gray2bin[LW] = din[LW];
	for(i=LW-1;i>=0;i--) begin
		gray2bin[i] = din[i] ^ gray2bin[i+1];
	end
end
endfunction


//write
always_ff @(posedge wr_clk or negedge wr_rst_n) begin
	if (!wr_rst_n) begin
		wr_ptr_bin<=0;
		wr_ptr_gray<=0;
	end else if (wr_en && !full) begin
		mem[wr_ptr_bin[LW-1:0]] <= wr_data;
		wr_ptr_bin<=wr_ptr_bin+1;
		wr_ptr_gray<=bin2gray(wr_ptr_bin+1);
	end
end


//read
always_ff @(posedge rd_clk or negedge rd_rst_n) begin
	if (!rd_rst_n) begin
		rd_ptr_bin<=0;
		rd_ptr_gray<=0;
		rd_data<=0;
	end else  if (rd_en && !empty) begin
		rd_data<=mem[rd_ptr_bin[LW-1:0]];
		rd_ptr_bin<=rd_ptr_bin+1;
		rd_ptr_gray<=bin2gray(rd_ptr_bin+1);
	end
end



//write cross
always_ff @(posedge wr_clk or negedge wr_rst_n) begin
	if(!wr_rst_n) begin
		rd_sync1<=0;
		rd_sync2<=0;
	end else begin
		rd_sync1<= rd_ptr_gray;
		rd_sync2<= rd_sync1;
	end
end


//read cross
always_ff @(posedge rd_clk or negedge rd_rst_n) begin
	if(!rd_rst_n) begin
		wr_sync1<=0;
		wr_sync2<=0;
	end else begin
		wr_sync1<=wr_ptr_gray;
		wr_sync2<=wr_sync1;
	end
end

//full and empty
wire [LW:0] rd_sync = gray2bin(rd_sync2);
assign full = (wr_ptr_bin[LW]^rd_sync[LW]) && (wr_ptr_bin[LW-1:0]==rd_sync[LW-1:0]);


wire [LW:0] wr_sync = gray2bin(wr_sync2);
assign empty = (wr_sync == rd_ptr_bin);


endmodule
