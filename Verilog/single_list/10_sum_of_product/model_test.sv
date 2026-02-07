module model #(parameter int BW=8, K=16)(
  input  logic clk,
  input  logic reset,

  // left
  input  logic [BW-1:0] x, w,
  input  logic          in_valid,
  output logic          in_ready,

  // right
  input  logic          out_ready,
  output logic          out_valid,
  output logic [(BW*2+K):0] out
);


logic [$clog2(K):0] count;
logic [(BW*2+K):0]  psum;
logic full, grab, push;


assign in_ready  = !full;
assign out_valid = full;

assign grab = in_ready && in_valid;
assign push = full && out_valid;

assign out = psum;


always_ff @(posedge clk) begin
	if(reset) begin
		count<=0;
		psum<=0;
		full<=0;
	end else begin

		//push
		if(push) begin
			psum <=0;
			count<=0;
			full<=0;
		end
		
		//grab
		if(grab) begin

			psum<= count==0 ? w*x : psum+x*w;
			if(count==K-1) begin
				full<=1;
				count<=count+1;
			end else begin
				count<=count+1;
			end		
		end

		
	end
end


endmodule
