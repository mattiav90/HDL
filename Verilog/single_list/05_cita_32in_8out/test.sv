
module test();

parameter CATCH=1;

logic clk;
logic resetn;
logic validin;
logic [31:0] din;
logic [7:0] dout;
logic validout;


model #(.CATCH(CATCH)) DUT
(
.clk(clk),
.resetn(resetn),
.validin(validin),
.din(din),
.dout(dout),
.validout(validout)	
);



initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
#1000
$finish;
end


initial begin

	reset;

    // forever generate random activity
	repeat(30) gendata;

	#10;
	$finish;
end


task reset;
begin
    resetn = 0;
    validin = 0;
    din = '0;

    // release reset
    repeat (3) @(posedge clk);
    resetn = 1;
end
endtask


task gendata;
begin
	@(negedge clk);

	// random valid once in a while (about 20%)
	validin = ($urandom_range(0,4) == 0);	
	din = $urandom();
   
end
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
