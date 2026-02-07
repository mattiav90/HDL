`timescale 1ns/1ps

module test();

parameter W = 32;

logic [W-1:0] a, b, sum, check;
logic cout;

carry_lookahead #(W) cs (a, b,1'b0, sum,cout);

initial begin
    repeat (10) ciao;
    $finish;
end

task  ciao;
begin
    a = $random;
    b = $random;
    check = a + b;
    #2;

    if (check === sum) begin
        $display("ok. %0d + %0d = %0d", a, b, sum);
    end else begin
        $display("error. %0d + %0d = %0d (expected %0d)", a, b, sum, check);
    end
end
endtask

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule
