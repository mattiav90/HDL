module model #(parameter
  DIV_LOG2=3,
  OUT_WIDTH=32,
  IN_WIDTH=OUT_WIDTH+DIV_LOG2
) (
  input [IN_WIDTH-1:0] din,
  output logic [OUT_WIDTH-1:0] dout
);

	//notice that here it is keeping an extra bit more than the 
	//require output dimension
    logic [OUT_WIDTH:0] temp;

    
	//here it is keeping only the bits of the theorerical output
	//if you shift it right, and adding to them the MSB of the 
	//droppped bits
    assign temp = din[IN_WIDTH-1:DIV_LOG2] + din[DIV_LOG2-1];

    //if the addition of the MSB of the dropped bits causes 
    //oveflow, then we can see it because we have one extra bit
    //if that is the case, keep the bits of the original din
    //otherwise keep the new version with the added extra bit.
    assign dout = temp[OUT_WIDTH] ? din[IN_WIDTH-1:DIV_LOG2] : temp[OUT_WIDTH-1:0];
    
endmodule
