

module model (
	input  logic clk,
	input  logic reset,

	//left
	input  logic [7:0] din,
	input  logic l_valid,
	output logic l_ready,

	//right
	output logic [15:0] dout,
	output logic r_valid,
	input  logic r_ready
);


logic count;
logic [7:0] w1,w2;
logic start;

logic grab_l, push_r;

always_ff @(posedge clk) begin
	if(reset) begin
		start<=0;
		w1<=0;
		w2<=0;
		count<=0;
	end else begin

		if (grab_l) begin
			count <= count+1;
			w1    <= count==0 ? din : w1;
			w2    <= count==1 ? din : w2;
			start <= 1;
		end
		
	end
end

always_comb begin
	if(reset) 
		dout=0;
	else
		dout = count==0 && start && push_r ? {w1,w2} : dout;
end

assign l_ready = r_ready;
assign r_valid = count==0 & start;

assign grab_l = l_valid && l_ready;
assign push_r = r_valid && r_ready;


endmodule
