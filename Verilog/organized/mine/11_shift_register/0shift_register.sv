module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] rr;
    
    always @(posedge clk) begin
        if (!resetn) begin
        	rr<=0;
        end else begin
            rr<={in,rr[3:1]};
        end
    end
    
    assign out = rr[0];

endmodule
