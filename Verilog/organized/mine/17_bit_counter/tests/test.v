


module test();

	parameter W=32;
		
	reg [W-1:0] in;
	wire [$clog2(W):0] out;

	bit_counter_opt #(W) bc (in,out);



	initial begin
	in=1;
	#5;
	$display("in: ",in,"in: %b",in," out:",out);
	in=204;
	#5;
	$display("in: ",in,"in: %b",in," out:",out);
	in=1023;
	#5;
	$display("in: ",in,"in: %b",in," out:",out);
	in=255;
	#5;
	$display("in: ",in,"in: %b",in," out:",out);
				
	$finish;
	end


	initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
	end



endmodule 
