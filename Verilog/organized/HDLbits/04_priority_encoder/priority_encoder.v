
//remember that a priority encoder push out the number of the first less 
//significative bit that is one. 
//for example here: 8'b10010000 would output 3'd4, because bit[4] is
// first bit that is high.
//


// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    always @(*) begin
        casex(in)
            4'bxxx1: pos=0;
            4'bxx10: pos=1;
            4'bx100: pos=2;
            4'b1000: pos=3;
            default: pos=0;
        endcase
    end

endmodule
