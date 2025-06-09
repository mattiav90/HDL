
// I can check it it is a thermomether just by counting how 
// many times adjacent bits are different from each other. 
// instead of != I can also use XOR (^), it works the same way. 

module thermometer #(parameter W=16)(
	input wire [W-1:0] din,
	output wire dout
);

integer i;
reg [$clog2(W):0] counter;

always @(*) begin
counter=0;
for(i=0; i<W-1 ; i=i+1) begin
	counter = (din[i]^din[i+1]) ? counter+1 : counter;
end

end

assign dout = (counter==1);


endmodule
