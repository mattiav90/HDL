/*
When you add two binary numbers bit-by-bit, each bit’s sum depends on a carry-in from the previous bit.
The classic ripple-carry adder waits for the carry to “ripple” through all bits — slow for large numbers.

Carry lookahead speeds this up by figuring out the carries in parallel using two signals per bit:
Generate (g): This bit will produce a carry no matter what the input carry is.
Propagate (p): This bit will pass the carry along if there is one.

in this way all the carry of the addition chain are computed in parallel with comb logic. 
there is no need to wait for the ripple carry. 

*/


module carry_lookahead #(
    parameter WIDTH = 16
)(
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic             cin,
    output logic [WIDTH-1:0] sum,
    output logic             cout
);

    logic [WIDTH-1:0] g;  // generate
    logic [WIDTH-1:0] p;  // propagate
    logic [WIDTH:0]   c;  // carry

    assign g = a & b;	  //each bit has a 1 if both a and b are 1.
    assign p = a ^ b;	  //each bit is 1 if a and b are different

    assign c[0] = cin;

    //compute all the carry in parallel, do not wait for the carry propagation.
    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : carry_calc
            assign c[i+1] = g[i] | (p[i] & c[i]);			//compute all the carry for the addition chain.
        end
    endgenerate

    assign sum = p ^ c[WIDTH-1:0];	//this is equivalent to a[i]^b[i]^c[i];
    assign cout = c[WIDTH];			//c out is the last carry of the chain.

endmodule
