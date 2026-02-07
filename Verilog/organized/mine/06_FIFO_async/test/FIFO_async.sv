

module async_fifo #(
	parameter W=16,
	parameter L=16
)(
input  logic wr_clk,
input  logic wr_en,
input  logic wr_rst_n,
input  logic [W-1:0] wr_data,
output logic full,

input  logic rd_clk,
input  logic rd_en,
input  logic rd_rst_n,
output logic [W-1:0] rd_data,
output logic empty
);

parameter ADDW = $clog2(L);

//registers and wires
logic [W-1:0] mem [0:L-1];

logic [ADDW:0] rd_add_bin,wr_add_bin;
logic [ADDW:0] rd_add_gray,wr_add_gray;

logic [ADDW:0] wr_sync1,wr_sync2;
logic [ADDW:0] rd_sync1,rd_sync2;



// gray code functions
function [ADDW:0] bin2gray (input logic [ADDW:0] din);
	bin2gray = din ^ din>>1;
endfunction


function [ADDW:0] gray2bin (input logic [ADDW:0] din);
	integer i;
	begin
		gray2bin[ADDW] = din[ADDW];
		for (i=ADDW-1; i>=0; i--) begin
			gray2bin[i] = din[i] ^ gray2bin[i+1];
		end
	end
endfunction

//write logic
always_ff @(posedge wr_clk or negedge wr_rst_n) begin
	 if (!wr_rst_n) begin
		wr_add_bin<=0;
		wr_add_gray<=0;
	 end else if (wr_en && !full) begin
		mem[wr_add_bin[ADDW-1:0]]<=wr_data;
		wr_add_bin<=wr_add_bin+1;
		wr_add_gray<=bin2gray(wr_add_bin+1);
	 end
end


//read logic
always_ff @(posedge rd_clk or negedge rd_rst_n ) begin
	if (!rd_rst_n) begin
		rd_add_bin<=0;
		rd_add_gray<=0;
	end else if (rd_en && !empty) begin 
		rd_data<=mem[rd_add_bin[ADDW-1:0]] ;
		rd_add_bin<=rd_add_bin+1;
		rd_add_gray<=bin2gray(rd_add_bin+1);
	end
end


//write cross domain
always_ff @(posedge wr_clk or negedge wr_rst_n) begin
	if (!wr_rst_n) begin
		rd_sync1<=0;
		rd_sync2<=0;
	end else begin
		rd_sync1<=rd_add_gray;
		rd_sync2<=rd_sync1;
	end
end


//read cross domain
always_ff @(posedge rd_clk or negedge rd_rst_n ) begin
	if (!rd_rst_n) begin
		wr_sync1<=0;
		wr_sync2<=0;
	end else begin
		wr_sync1<=wr_add_gray;
		wr_sync2<=wr_sync1;
	end
end


//full and empty
logic [ADDW:0] rd_sync, wr_sync;

assign rd_sync = gray2bin(rd_sync2);
assign wr_sync = gray2bin(wr_sync2);


assign empty = rd_add_bin == wr_sync;
assign full = {~wr_add_bin[ADDW], wr_add_bin[ADDW-1:0] } == rd_sync;





endmodule
