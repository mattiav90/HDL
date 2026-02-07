

module test();

logic clk;
logic resetn;

//input
logic in_valid;
logic [15:0] in_data;
logic in_ready;

//output
logic out_ready;
logic out_valid, out_data;


model DUT (clk,resetn,in_valid,out_ready,in_data,out_valid,out_data,in_ready);


initial begin
	clk=0;
	forever #5 clk=~clk;
end



initial begin

	reset;


	@(negedge clk);
	in_valid=1;
	in_data=16'b1100101010101110;
	@(negedge clk);
	in_valid=0;
	in_data='0;
	
	


	repeat(4) @(posedge clk);
	in_ready=1;

	repeat(10) @(posedge clk);
	in_ready=0;

	repeat(5) @(posedge clk);
	in_ready=1;
		


end



task reset;
	@(posedge clk);
	resetn=0;
	in_valid=0;
	in_data=0;
	in_ready=0;
	repeat(2) @(posedge clk);
	resetn=1;
endtask


initial begin
#1000
$finish;
end



initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end

endmodule


