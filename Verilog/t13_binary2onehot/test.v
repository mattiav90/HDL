


module test;

parameter W=4;

reg [W-1:0] in;
wire [(2**W)-1:0] out;
wire [W-1:0] out1;

integer i;


bin2onehot_shift #(W) b2o (in,out);

onehot2bin #(W) o2b (out,out1);



initial begin
	$display("testing binary 2 one hot");

	for (i=0; i<(2**W)-1; i=i+1 ) begin
		in=i;
		#2;
		$display("in: %d out: %b out1: %d ",in,out,out1);
	end
end






initial begin
$dumpfile("wave.vcd"); $dumpvars();
end



endmodule
