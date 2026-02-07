module model (
  input  logic        clk,
  input  logic        resetn,

  // left: valid + credit-return (1-word buffer)
  input  logic        valid_L,
  output logic        credit_L,     // pulse: buffer freed
  input  logic [15:0] in_data,

  // right: valid + credit (credit = consumed)
  output logic        valid_R,
  output logic        out_data,
  input  logic        credit_R
);


logic [15:0] data;
logic capture;
logic [$clog2(16):0] count;


always_ff @(posedge clk) begin

	if(!resetn) begin
		data<=0;
		capture<=0;
		count<=0;
		credit_L<=0;
	end else begin

		credit_L<=0;

		// left is sending something 
		if(valid_L && !capture) begin
			data<=in_data;
			count<=0;
			capture<=1;
		end

		// right can receive
		if(credit_R && capture) begin
			count    <= count==15 ? 0 : count+1;
			capture  <= count==15 ? 0 : capture;
			credit_L <= count==15 ? 1 : 0;			// notice that I send one credit to L whwen I am done sending R. 
		end
	end
	
end


assign valid_R = resetn && capture;
assign out_data = data[count];




endmodule
