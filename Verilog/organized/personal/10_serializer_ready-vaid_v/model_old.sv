module model_ok (
	// general
	input  logic        clk,
	input  logic        resetn,
	
	// left (upstream)
	input  logic        valid_L,
	output logic        ready_L,
	input  logic [15:0] in_data,

	// right (downstream)
	output logic        valid_R,
	output logic        out_data,
	input  logic        ready_R
);

logic [3:0]  count;
logic [15:0] data;
logic        go;

// FF is needed only for DATA, COUNTER and GO.
always_ff @(posedge clk) begin
	if (!resetn) begin
		go    <= 1'b0;
		count <= 4'd0;
	end else if (!go && valid_L) begin
		data <= in_data;
		go   <= 1'b1;
	end else if (go && ready_R) begin
		count <= (count < 15) ? count + 1 : 0;
		go    <= (count < 15) ? go        : 0;
	end
end

// combinatorial 
assign ready_L = resetn && ~go;
assign valid_R = resetn && ready_R && go;
assign out_data = (go && ready_R) ? data[count] : 1'b0;

endmodule
