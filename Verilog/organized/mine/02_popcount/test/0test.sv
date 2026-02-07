

module test();

parameter W=16;
logic [W-1:0] in;
logic [$clog2(W):0] count, temp;


pop_count_naive #(W) dut (in,count);




task go;
integer i;
begin
in=$random;


temp=0;
for (i=0;i<W;i++)  begin
 temp = temp+in[i];
end

#10;
if (temp==count) begin
$display("OK. in: %b count: %d",in,count);
end else begin
$display("ERROR. in: %b count: %d",in,count);

end

end
endtask


initial begin

repeat (10) go;
$finish;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;

end




endmodule
