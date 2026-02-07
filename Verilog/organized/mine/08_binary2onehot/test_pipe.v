


module test;

parameter W=4;

reg [W-1:0] in;
reg clk;
reg rstn;
wire [(2**W)-1:0] out;
wire [W-1:0] out1;

integer i;

bin2onehot_shift #(W) b2o (in,out);

onehot2bin_pipe #(W) o2b (clk,rstn,out,out1);



initial begin
clk=0;
forever #2 clk=!clk;
end


initial begin
rstn=0;
#12;
rstn=1;
#10;

for (i=0; i<(2**W)-1; i=i+1) begin
	in=i;
	#4;
	$display("in: %d out: %b out1: %d ",in,out,out1);

end
$finish;
end


initial begin
$dumpfile("wave.vcd"); $dumpvars;
end



endmodule
