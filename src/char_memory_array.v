`timescale 1ns/1ps

module char_memory_array (
    input wire clock,
    input wire rst_n,
    input wire write,
    input wire [1:0] x,
    input wire [2:0] y,
    input wire data_in,
    output reg [35:0] data_out
);

    // Custom reset values for 36 instances
parameter [575:0] RESET_VALUES = {
    16'b0000011101010111, // A
    16'b0000010001100101, // B
    16'b0000011101000100, // C
    16'b0001000101110101, // D
    16'b0111010001110100, // E
    16'b0111010001110100, // F
    16'b0010010101110001, // G
    16'b0000010101110101, // H
    16'b0000011100100010, // I
    16'b0000001100010001, // J
    16'b1000101010010101, // K
    16'b1000000000000000, // L
    16'b1000110001100011, // M
    16'b1000100010001000, // N
    16'b0111100000000001, // O
    16'b1111110000011100, // P
    16'b0111100001100001, // Q
    16'b1111110000110101, // R
    16'b0111110000000001, // S
    16'b1111100000010000, // T
    16'b1000000000000000, // U
    16'b1000001000010000, // V
    16'b1000001100001100, // W
    16'b1000101001001010, // X
    16'b1000000000000100, // Y
    16'b1111100000100101, // Z
    16'b0110100110011001, // 0
    16'b0010011000100010, // 1
    16'b0110100100100100, // 2
    16'b1110000111100001, // 3
    16'b1001100101110001, // 4
    16'b1111100011100001, // 5
    16'b1111100011101001, // 6
    16'b1111000100100100, // 7
    16'b1111100111111001, // 8
    16'b1111100111110001  // 9
};


    // Instantiating 36 char_memory modules
    genvar i;
    generate
        for(i = 0; i < 36; i = i + 1) begin: char_memory_instances
            char_memory #(.RESET_VALUE(RESET_VALUES[((i*16)+15):((i*16))])) char_memory_instance (
                .clock(clock),
                .rst_n(rst_n),
                .write(write),
                .x(x),
                .y(y),
                .data_in(data_in),
                .data_out(data_out[i]) // Output from each instance to respective bit in data_out
            );
            //defparam char_memory_instance.RESET_VALUE = RESET_VALUES[((i*16)+15):((i*16))]; // Assigning reset values
        end
    endgenerate

endmodule
