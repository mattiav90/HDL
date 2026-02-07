

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


model DUT (
    .clk       (clk),
    .resetn    (resetn),
    .in_valid  (in_valid),
    .out_ready (out_ready),
    .in_data   (in_data),
    .out_valid (out_valid),
    .out_data  (out_data),
    .in_ready  (in_ready)
);


initial begin
	clk=0;
	forever #5 clk=~clk;
end



initial begin

	resett;

	//data
	gendata(16'b1010101010101010);

	
	repeat(4) @(posedge clk);
	out_ready=1;

	repeat(10) @(posedge clk);
	out_ready=0;

	repeat(5) @(posedge clk);
	out_ready=1;


	gendata(16'b1100110011001100);

	repeat(5) @(posedge clk);


	gendata(16'b1100110011001100);

	repeat(20) @(posedge clk);	
	
	#10;
	$finish;

end



task resett;
	@(posedge clk);
	resetn=0;
	in_valid=0;
	in_data=0;
	in_valid=0;
	out_ready=1;
	repeat(2) @(posedge clk);
	resetn=1;
endtask


task gendata (input logic [15:0] dd);
begin
@(negedge clk);
in_valid=1;
in_data=dd;
@(negedge clk);
in_valid=0;
in_data=0;
end
endtask;


initial begin
#1000
$finish;
end



initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end

endmodule


