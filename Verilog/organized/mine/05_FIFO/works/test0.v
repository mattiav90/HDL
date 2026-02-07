

`timescale 1ns/1ps


module test();

parameter W=8;
parameter L=8;

reg  clk, resetn, w_en, r_en;
reg  [W-1:0] data_in;
wire [W-1:0] data_out;
wire full,empty;


fifo1 #(W,L) fifo (clk,resetn,w_en,r_en,data_in,data_out,full,empty);


initial begin 
clk=0;
forever #5 clk=~clk;
end


//main
initial begin
reset;

fork 
	begin
		repeat (20) push;
	end

	begin
		#150;
		repeat (20) pop;
	end
join

$finish;
end




//reset task
task reset;
begin
	resetn=0;
	data_in=0;
	w_en=0;
	r_en=0;
	#20;
	resetn=1;
end
endtask




//push task
task push;
begin
	if(!full) begin
		data_in=$random;
		@(negedge clk);
		w_en=1;
		$display("writing in data: %d",data_in);
		@(negedge clk);
		w_en=0;
	end else begin
		$display("the fifo is full. cannot push.");
	end
end
endtask


//read task
task pop;
begin
	if(!empty) begin
		@(negedge clk);
		r_en=1;
		@(negedge clk);
		r_en=0;
		$display("popped value: %d",data_out);			
	end else begin
		$display("fifo empty, cannot pop.");
	end
end
endtask




initial begin 
$dumpfile("wave.vcd");
$dumpvars;
end





endmodule
