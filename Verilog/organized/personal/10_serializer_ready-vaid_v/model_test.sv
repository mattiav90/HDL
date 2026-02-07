


module model_ok (
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


logic fireL, fireR;
logic [15:0] din;
logic [$clog2(15):0] c;
logic go;

assign fireL= valid_L && realy_L;
assign fireR = varid_R && ready_R;

always_ff @(posedge clk) beging
	if(!resetn) begin
		din<=0;
		c<=0;
		go<=0;
	end else begin

		if(fireL) begin
			din<=in_data;
			go<=1;
			c<=0;
		end else if (fireR) begin
			c<= c==15 ? 0 : c+1;
			go<= c== 15 ? 0 : go;
	end
	
end

assign readyL= !go;
assign validR = go;

assign out_data = din[c];


endmodule
