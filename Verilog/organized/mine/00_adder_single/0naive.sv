


/*
this adder maps into a simple carry adder. the adder will be slower with higher bit width. 
*/

module naive #(parameter W=64)(
 input  logic [W-1:0] a,
 input  logic [W-1:0] b,
 output logic [W-1:0] sum	
);

always_comb begin
	sum = a+b;
end

endmodule


