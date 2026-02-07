

//CARRY select
//need to define the add1, add16. 
//here basically I speed up the sum, by computing in parallel both
//partial sums with the carry =0 and =1.
//I compute in parallel both parts, and then I concatenate the 2 proper
//results. redundand but faster. 


module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1, c20,c21;
    wire [15:0] temp0,temp1;
    
    add16 a1  (a[15:0], b[15:0], 1'b0,sum[15:0],cout1);
    add16 a2_0(a[31:16],b[31:16],1'b0,temp0,    c20);
    add16 a2_1(a[31:16],b[31:16],1'b1,temp1,    c21);
    
    assign sum[31:16] = cout1 ? temp1 : temp0;

endmodule
