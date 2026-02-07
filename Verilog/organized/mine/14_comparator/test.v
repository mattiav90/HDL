module top;
    reg  [31:0] a, b;
    wire        a_gt_b;

    comparator_tree #(32) comp32 (
        .a(a),
        .b(b),
        .a_gt_b(a_gt_b)
    );

    initial begin
        a = 32'hABCDEF12;
        b = 32'hABCDEA00;
        #1 $display("a_gt_b = %b", a_gt_b); // Expect 1
    end
endmodule
