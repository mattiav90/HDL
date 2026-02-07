
`timescale 1ns/1ps


module test();

parameter W=8;
parameter L=8;


reg clk;
reg resetn;
reg w_en;
reg r_en;
reg [W-1:0] data_in;
wire [W-1:0] data_out;
wire full;
wire empty;

FIFO #(W,L) fifo (
.clk(clk),
.resetn(resetn),
.w_en(w_en),
.r_en(r_en),
.data_in(data_in),
.data_out(data_out),
.full(full),
.empty(empty)
);


initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
resetn=0;
w_en=0;
r_en=0;
data_in=0;
#20
resetn=1;

fork 
	begin
		repeat (20) push;
	end
	
	begin
		#130
		repeat (20) pop;
	end
join

$finish;
end


task push;
begin
	if (!full) begin
		data_in=$random;
		@(negedge clk);
		w_en=1;
		@(negedge clk);
		w_en=0;	
		$display("pushing. data: %d",data_in);
	end else begin
		$display("fifo is full. cannot write");
	end 
end
endtask


task pop;
begin
	if(!empty) begin
		@(negedge clk);
		r_en=1;
		$display("pulled data: %d",data_out);
		@(negedge clk);
		r_en=0;
	end else begin
		$display("cannot pop. fifo is empty");
	end

end
endtask



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end


endmodule
