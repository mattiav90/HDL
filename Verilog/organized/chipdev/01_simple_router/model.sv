
module model #(parameter SIZE=32) (
input  logic [SIZE-1:0] din,
input  logic 	       enable,
input logic  [$clog2(SIZE-1):0] addr, 
output logic [SIZE-1:0] dout0,
output logic [SIZE-1:0] dout1,
output logic [SIZE-1:0] dout2,
output logic [SIZE-1:0] dout3
);

assign dout0 = enable & addr==0 ? din : 0;
assign dout1 = enable & addr==1 ? din : 0; 
assign dout2 = enable & addr==2 ? din : 0;
assign dout3 = enable & addr==3 ? din : 0; 

endmodule
