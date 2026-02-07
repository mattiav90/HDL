
module test();

parameter CATCH=7;

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
    forever begin
        @(negedge clk);
        //#4

        // random valid once in a while (about 20%)
        validin = ($urandom_range(0,4) == 0);

        // random data only when valid
        din = $urandom();

        
       // if (validin)
       //     din = $urandom();
       // else
       //     din = '0;   // or keep previous, doesn't matter
    end
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


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
