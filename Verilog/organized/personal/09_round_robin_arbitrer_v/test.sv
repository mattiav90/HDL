

module test();

parameter N=8;
parameter BW=$clog2(N);

logic clk, reset;
logic [N-1:0] req, grant;


rr_arb dut (clk,reset,req,grant);


//Test bench
initial begin
//reset
@(posedge clk);
reset=1;
repeat(3) @(posedge clk);
reset=0;

gen_in(8'b00000001);
gen_in(8'b00000100);
gen_in(8'b00010000);
gen_in(8'b01000000);
gen_in(8'b00000001);


gen_in(8'b11111111);
gen_in(8'b11111111);
gen_in(8'b11111111);
gen_in(8'b11111111);
gen_in(8'b11111111);
gen_in(8'b11111111);




#200;
$finish;
end




task gen_in(input logic [N-1:0] reqin);
begin
	@(negedge clk);
	req=reqin;

	@(posedge clk);
	$display("req: %b",req," grant: %b",grant);
end
endtask





initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end




endmodule 
