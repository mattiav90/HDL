

module test();

localparam N=8;

logic [N-1:0] req;
logic [N-1:0] grant;

arb #(N) dut (req,grant);


initial begin
	// list of tests
	gen(1);
	gen(2);
	gen(4);
	gen(8);
	gen(10);
	gen(15);
	gen(60);
	gen(128);
	gen(255);
	$finish;
end


task gen(logic [N-1:0] in);
begin
	#10 
	req=in;
	#5
	$display(" req: %b",req,"  grant: %b",grant);
end
endtask


initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end

endmodule
