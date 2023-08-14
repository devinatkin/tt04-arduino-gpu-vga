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
parameter [719:0] RESET_VALUES = {
    20'b00000111010101110101, // A
    20'b11101110101111101110, // B
    20'b11011000100010001101, // C
    20'b11001100110011001100, // D
    20'b11110000111100001111, // E
    20'b11111111000000001111, // F
    20'b11011110111111000011, // G
    20'b10000010000100000100, // H
    20'b00111100000111000111, // I
    20'b00000100001000011100, // J
    20'b10001010100101010010, // K
    20'b10000000000000001111, // L
    20'b10001100011000110001, // M
    20'b10001000100010000100, // N
    20'b01111000000000011110, // O
    20'b11111100000111000000, // P
    20'b01111000011000011101, // Q
    20'b11111100001101010010, // R
    20'b01111100000000011110, // S
    20'b11111000000100000100, // T
    20'b10000000000000000100, // U
    20'b10000010000100001000, // V
    20'b10000011000011000100, // W
    20'b10001010010010100010, // X
    20'b10000000000001000100, // Y
    20'b11111000001001011110, // Z
    20'b01101001100110010110, // 0
    20'b00100110001000100111, // 1
    20'b01101001001001001111, // 2
    20'b11100001111000011110, // 3
    20'b10011001011100010001, // 4
    20'b11111000111000011110, // 5
    20'b11111000111010011110, // 6
    20'b11110001001001001000, // 7
    20'b11111001111110011111, // 8
    20'b11111001111100010001  // 9
};


    // Instantiating 36 char_memory modules
    genvar i;
    generate
        for(i = 0; i < 36; i = i + 1) begin: char_memory_instances
            char_memory char_memory_instance (
                .clock(clock),
                .rst_n(rst_n),
                .write(write),
                .x(x),
                .y(y),
                .data_in(data_in),
                .data_out(data_out[i]) // Output from each instance to respective bit in data_out
            );
            defparam char_memory_instance.RESET_VALUE = RESET_VALUES[((i*20)+19):((i*20))]; // Assigning reset values
        end
    endgenerate

endmodule
