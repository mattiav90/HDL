`timescale 1ns/1ps

module test();

parameter W = 32;
parameter BL = 8;

logic [W-1:0] a, b, sum, check;

carry_select #(W,BL) cs (a, b, sum);

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
