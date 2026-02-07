module model (
    input [7:0] din,
    output reg [255:0] dout
);

reg [255:0] temp;

always @(*) begin
temp='1;
temp=temp>>255-din;
end
assign dout=temp;

endmodule


//this is super simple. 
// the trick is to know that you can initilaize a reg with all 1
// using reg='1;

