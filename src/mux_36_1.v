`timescale 1ns/1ps

module mux_36_1 (
    input [35:0] d,  // 36 input data lines
    input [5:0] sel, // 6-bit select line to select one of the 36 inputs
    output reg y     // output
);

always @(d or sel) begin
    case(sel)
        6'b000000: y = d[0];
        6'b000001: y = d[1];
        6'b000010: y = d[2];
        6'b000011: y = d[3];
        6'b000100: y = d[4];
        6'b000101: y = d[5];
        6'b000110: y = d[6];
        6'b000111: y = d[7];
        6'b001000: y = d[8];
        6'b001001: y = d[9];
        6'b001010: y = d[10];
        6'b001011: y = d[11];
        6'b001100: y = d[12];
        6'b001101: y = d[13];
        6'b001110: y = d[14];
        6'b001111: y = d[15];
        6'b010000: y = d[16];
        6'b010001: y = d[17];
        6'b010010: y = d[18];
        6'b010011: y = d[19];
        6'b010100: y = d[20];
        6'b010101: y = d[21];
        6'b010110: y = d[22];
        6'b010111: y = d[23];
        6'b011000: y = d[24];
        6'b011001: y = d[25];
        6'b011010: y = d[26];
        6'b011011: y = d[27];
        6'b011100: y = d[28];
        6'b011101: y = d[29];
        6'b011110: y = d[30];
        6'b011111: y = d[31];
        6'b100000: y = d[32];
        6'b100001: y = d[33];
        6'b100010: y = d[34];
        6'b100011: y = d[35];
        default: y = 1'b0; // default output, in case of unexpected `sel` value
    endcase
end

endmodule
