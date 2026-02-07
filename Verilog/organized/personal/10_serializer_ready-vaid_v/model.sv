module model (
  input  logic        clk,
  input  logic        resetn,

  // left
  input  logic        valid_L,
  output logic        ready_L,
  input  logic [15:0] in_data,

  // right
  output logic        valid_R,
  output logic        out_data,
  input  logic        ready_R
);

  logic [15:0] data;
  logic [3:0]  count;
  logic        capture;

always_ff @(posedge clk) begin
	if (!resetn) begin
		count<=0;
		data<=0;
		capture<=0;
	end else begin
		if(valid_L && ready_L) begin
			data<=in_data;
			count<=0;
			capture<=1;	
		end else if(valid_R && ready_R) begin
			count   <= count==15 ? 0 : count+1;
			capture <= count==15 ? 0 : capture;
		end
	end

end

assign ready_L  = resetn && !capture;
assign valid_R  = resetn && capture;
assign out_data = data[count]; 
 
endmodule
