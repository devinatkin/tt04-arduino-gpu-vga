`timescale 1ns/1ps

module character_output_mode(
    input         clk,
    input         rst_n,
    input  [9:0]  xcoor,
    input  [9:0]  ycoor,
    input [31:0]  configuration,
    output        character_out
);
    wire [35:0] char_memory_out;
    wire [5:0] char_select;

    char_memory_array character_memory_array(
        .clock   (clk),            // Clock signal
        .rst_n   (rst_n),          // Reset signal (active low)
        .write   (1'b0),           // Future: configuration[22] will be the write signal
        .x       (xcoor[1:0]),     // X-coordinate (2 bits)
        .y       (ycoor[2:0]),     // Y-coordinate (3 bits)
        .data_in (1'b0),           // Future: configuration[23] will be the data input
        .data_out(char_memory_out) // Data output
    );

    char_row character_row (
        .char_in  (configuration[20:15]), // Character to be written
        .xcoor    (xcoor),                // X-coordinate
        .ycoor    (ycoor[8:0]),           // Y-coordinate (9 bits)
        .write    (configuration[21]),    // Write control
        .char_out (char_select),          // Character output
        .clk      (clk),                  // Clock signal
        .rst_n    (rst_n)                 // Reset signal (active low)
    );

    mux_36_1 character_mux (
        .d   (char_memory_out), // Data input
        .sel (char_select),     // Selector signal
        .y   (character_out)    // Output
    );
    
endmodule
