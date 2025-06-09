

module test();

reg clk;
reg rstn;
reg data_in;
wire match;

pattern_fsm pfsm(clk,rstn,data_in,match);


initial begin
clk=0;
forever #2 clk=!clk;
end


initial begin
rstn=0;
data_in=0;
#6;
rstn=1;
run(40);
$finish;
end





task run;
input integer N;
integer i;
begin
 for(i=0; i<N; i=i+1) begin
	@(negedge clk);
	data_in = $random %2; //only 0 and 1
	$display("data_in: ",data_in);
 end
end
endtask




initial begin
$dumpfile("wave.vcd"); $dumpvars;
end



endmodule
