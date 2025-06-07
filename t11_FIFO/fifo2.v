module fifo2 #(parameter DEPTH=8, DATA_WIDTH=8) (
  input clk, rst_n,
  input w_en, r_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output full, empty
);
  
  reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
  (* ram_style = "block" *) reg [DATA_WIDTH-1:0] fifo[0:DEPTH];
  reg [$clog2(DEPTH):0] count;
  reg [DATA_WIDTH:0] data_reg;
  
  // Set Default values on reset.
  // it is bad habit to control the same registers from multiple 
  //always blocks. so it is better to control count from 1 always only.
  always@(posedge clk) begin
    if(!rst_n) begin
      w_ptr <= 0; r_ptr <= 0;
      data_out <= 0;
      count <= 0;
      data_reg<=0;
    end
    else begin

      data_out<=data_reg;
      
      case({w_en,r_en})
        default: count <= count;
        2'b01: count <= count - 1'b1;
        2'b10: count <= count + 1'b1;
        default: count <= count;
      endcase


      if(w_en & !full)begin
        fifo[w_ptr] <= data_in;
        w_ptr <= w_ptr + 1;
      end

      if(r_en & !empty) begin
        data_reg <= fifo[r_ptr];
        r_ptr <= r_ptr + 1;
      end
    end
  end

  
  assign full = (count == DEPTH);
  assign empty = (count == 0);
endmodule
