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
parameter [431:0] RESET_VALUES = {
    12'b011101010111, // A
    12'b010001100101, // B
    12'b011101000100, // C
    12'b000101110101, // D
    12'b010001110100, // E
    12'b010001110100, // F
    12'b010101110001, // G
    12'b010101110101, // H
    12'b011100100010, // I
    12'b001100010001, // J
    12'b101010010101, // K
    12'b000000000000, // L
    12'b110001100011, // M
    12'b100010001000, // N
    12'b100000000001, // O
    12'b010000011100, // P
    12'b100001100001, // Q
    12'b110000110101, // R
    12'b110000000001, // S
    12'b100000010000, // T
    12'b000000000000, // U
    12'b001000010000, // V
    12'b001100001100, // W
    12'b101001001010, // X
    12'b000000000100, // Y
    12'b100000100101, // Z
    12'b100110011001, // 0
    12'b011000100010, // 1
    12'b100100100100, // 2
    12'b000111100001, // 3
    12'b100101110001, // 4
    12'b100011100001, // 5
    12'b100011101001, // 6
    12'b000100100100, // 7
    12'b100111111001, // 8
    12'b100111110001  // 9
};


    // Instantiating 36 char_memory modules
    genvar i;
    generate
        for(i = 0; i < 36; i = i + 1) begin: char_memory_instances
            char_memory #(.RESET_VALUE(RESET_VALUES[((i*12)+11):((i*12))])) char_memory_instance (
                .clock(clock),
                .rst_n(rst_n),
                .write(write),
                .x(x),
                .y(y),
                .data_in(data_in),
                .data_out(data_out[i]) // Output from each instance to respective bit in data_out
            );
            //defparam char_memory_instance.RESET_VALUE = RESET_VALUES[((i*12)+15):((i*12))]; // Assigning reset values
        end
    endgenerate

endmodule
