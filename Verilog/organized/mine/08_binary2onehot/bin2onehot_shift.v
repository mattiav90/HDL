

// this gets synthesized into a shifter. 
// it is another way of implementing the binary to one hot encoding. 

module bin2onehot_shift #(parameter W=4)
(
input  wire [W-1:0] in,
output reg [(2**W)-1:0] out
);


always @ (*) begin
	out=0;
	out = 1<<in;
end

endmodule
