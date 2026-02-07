
// this module can add or subtract. 
// it uses the 2 complement to do it. 
// if sub=0, a+b
// if sub=1, a+(~b)+1
//some modules are missing

module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire [31:0] b_new;
    wire c1,c2;
    assign b_new = {32{sub}} ^ b[31:0];
    
    add16 a1 (a[15:0], b_new[15:0], sub, sum[15:0], c1);
    add16 a2 (a[31:16],b_new[31:16],c1 ,sum[31:16],c2);


endmodule
