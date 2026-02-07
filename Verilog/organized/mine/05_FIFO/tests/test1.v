

module test();

parameter W=8;
parameter L=8;

reg clk, rstn;
reg w_en, r_en;
reg [W-1:0] data_in;
wire [W-1:0] data_out;
wire full,empty;

//fifo module
fifo1 #(W,L) fifo (clk,rstn,w_en,r_en,data_in,data_out,full,empty);

//clk
initial begin
clk=0;
forever #2 clk=!clk; 
end



//
initial begin 
w_en=0;
r_en=0;
rstn=0;
#6; rstn=1;		//remember to reset for some time!!! 

drive(20);
drive(30);
$finish;
end




task drive;
input integer delay;
begin
	w_en=0; r_en=0;
	fork
		begin
			repeat(10) begin @(negedge clk) #1 push(); end 
		end

		begin
		#delay;
			repeat(10) begin @(negedge clk) #1 pop(); end
		end
	join
end 
endtask





// push task
task push;
begin
	if (!full) begin
		w_en=1;
		data_in=$random;
		$display("writing data_in: ",data_in);
		#2; w_en=0;
	end else begin
		$display("FIFO full. cannot write");
	end
end
endtask



//pull task
task pop;
begin
	if(!empty) begin
		r_en=1;
		$display("reading data_out: ",data_out);
		#2; r_en=0;
	end else begin
		$display("FIFO empty. cannot read");
	end
end
endtask



//dumpfile and vars
initial begin
$dumpfile("wave.vcd"); $dumpvars;
end



endmodule
