module byte_selector #(
    parameter int SHIFT = 0    // which byte to select
)(
    input  logic        clk,
    input  logic        resetn,
    input  logic        valid,
    input  logic [31:0] data_in,
    output logic [7:0]  data_out,
    output logic        out_valid
);

    // Counter of how many 32-bit words we have received
    logic [31:0] word_count;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            word_count <= 0;
            out_valid  <= 0;
            data_out   <= '0;
        end else begin
            out_valid <= 0;  // default

            if (valid) begin
                word_count <= word_count + 1;

                // compute which word and which byte inside it
                int target_word = SHIFT / 4;
                int target_byte = SHIFT % 4;

                if (word_count == target_word) begin
                    data_out  <= data_in[8*target_byte +: 8];
                    out_valid <= 1;
                end
            end
        end
    end
endmodule


//something like this, but the second part was only with combinatorial logic. 

//something like this

module byte_selector #(
    parameter int SHIFT = 0    // which byte to select
)(
    input  logic        clk,
    input  logic        resetn,
    input  logic        valid,
    input  logic [31:0] data_in,
    output logic [7:0]  data_out,
    output logic        out_valid
);

    // Counter of how many 32-bit words we have received
    logic [31:0] word_count;
    localparam  TARGET_WORD = SHIFT / 4;
    localparam  TARGET_BYTE = SHIFT % 4;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            word_count <=  0;
            out_valid  <=  0;
            data_out   <= '0;
        end else if (valid) begin
        if (word_count == TARGET_WORD)
        	word_count <= 0;  // reset after hitting target
        else
        	word_count <= word_count + 1;
        end
    end

    assign out_valid = word_count==TARGET_WORD && valid ;
    assign data_out  = data_in[ ((TARGET_BYTE+1)*8)-1 : TARGET_BYTE*8 ];
    
endmodule
