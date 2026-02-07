

module model #(parameter N)(
	input logic clk,
	input logic reset,
	//left
	input  logic [N-1:0] din,
	//right
	output logic [N-1:0] grant
);


logic [$clog2(N)-1:0] pointer,next;
logic found;


always_ff @(posedge clk) begin
	if(reset) begin
		pointer<=0;
	end else begin
		pointer<=next;
	end
end


always_comb begin
	int index;

	grant='0;
	next=pointer;
	found=0;
	
	for (int i=0; i<N; i++) begin
		index= (pointer+i)%N;

		if(!found && din[index]) begin
			grant[index]=1;
			next = (index+1)%N;
			found=1;
		end
		
	end

end

endmodule
