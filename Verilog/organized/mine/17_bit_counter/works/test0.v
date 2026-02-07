
`timescale 1ns/1ps


module test();

parameter W=32;

reg  [W-1:0] in;
wire [$clog2(W)-1:0] count;

BC0 #(W) bc (in,count);



initial begin
repeat (10) gen;
end

task gen;
	begin
		in=$random;
		#5;
		$display("in: %b out: %d",in,count);
		#5;
	end 
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
