

// this is a 16 bit one hot to binary encoder. 
// it is entirely made with combinatorial logic. only 4 stages of logic.
// this is ideal for 300-400MHz FPGA.
// works well with low latency systems, or small input (16 bits) encodings. 


// suppising that I have to work with a 600+MHz FPGA, then I might have to pipeline it. 
// or the encoder gets wider, like 64 or more bits. 
// then I migh need to split it up in multiple pipeline stages. 

module onehot2bit_tree (
    input  wire [15:0] onehot,
    output wire [3:0] binary
);

    wire upper8_set,upper4_set,upper2_set;

	// if any of the upper bits is 1.
    assign upper8_set = |onehot[15:8];

    assign binary[3] = upper8_set;

	// if any of the upper 8 is one, select the upper 8 portion.
	// otherwise select the lower 8 portion. 
    wire [7:0] level1 = upper8_set ? onehot[15:8] : onehot[7:0];

    // now check the MSB 4 bit of that portion. 
    assign upper4_set = |level1[7:4];

    //assign the OR to the second msb bit of binary out. 
    assign binary[2] = upper4_set;


    // Now select either [7:4] or [3:0] from that group
    wire [3:0] level2 = upper4_set ? level1[7:4] : level1[3:0];
    assign upper2_set = |level2[3:2];
    assign binary[1] = upper2_set;

    // Final level: either [3:2] or [1:0]
    wire [1:0] level3 = upper2_set ? level2[3:2] : level2[1:0];
    assign binary[0] = level3[1];

endmodule




// this is the same thing but pipelineed at every stage. 

module onehot2bit_tree_pipelined (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] onehot_in,
    output reg  [3:0]  binary_out
);

    // Stage 0: Input register.
    reg [15:0] s0_onehot;
    always @(posedge clk or posedge rst) begin
        if (rst)
            s0_onehot <= 16'd0;
        else
            s0_onehot <= onehot_in;
    end

    // Stage 1: MSB decision (bit 3)
    reg        s1_msb3;
    reg [7:0]  s1_selected8;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s1_msb3     <= 1'b0;
            s1_selected8 <= 8'd0;
        end else begin
            s1_msb3     <= |s0_onehot[15:8];
            s1_selected8 <= (|s0_onehot[15:8]) ? s0_onehot[15:8] : s0_onehot[7:0];
        end
    end

    // Stage 2: Next bit (bit 2)
    reg        s2_msb2;
    reg [3:0]  s2_selected4;
    reg        s2_bit3;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s2_msb2      <= 1'b0;
            s2_selected4 <= 4'd0;
            s2_bit3      <= 1'b0;
        end else begin
            s2_msb2      <= |s1_selected8[7:4];
            s2_selected4 <= (|s1_selected8[7:4]) ? s1_selected8[7:4] : s1_selected8[3:0];
            s2_bit3      <= s1_msb3;
        end
    end

    // Stage 3: Next bit (bit 1)
    reg        s3_msb1;
    reg [1:0]  s3_selected2;
    reg [1:0]  s3_bits_high;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s3_msb1       <= 1'b0;
            s3_selected2  <= 2'd0;
            s3_bits_high  <= 2'd0;
        end else begin
            s3_msb1       <= |s2_selected4[3:2];
            s3_selected2  <= (|s2_selected4[3:2]) ? s2_selected4[3:2] : s2_selected4[1:0];
            s3_bits_high  <= {s2_bit3, s2_msb2};  // Carry forward bits [3:2]
        end
    end

    // Stage 4: Final bit (bit 0) + output register
    always @(posedge clk or posedge rst) begin
        if (rst)
            binary_out <= 4'd0;
        else
            binary_out <= {s3_bits_high, s3_msb1, s3_selected2[1]};
    end

endmodule
