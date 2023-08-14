`timescale 1ns/1ps

module char_row (
    input [5:0] char_in,       // 6-bit character input
    input [9:0] xcoor,        // X-coordinate between 0 and 640
    input [8:0] ycoor,        // Y-coordinate between 0 and 480
    input write,              // Write enable
    output reg [5:0] char_out, // 6-bit character output
    input clk,                 // Clock input
    input rst_n                // Reset input
);
    parameter y_start = 100;
    parameter y_end = y_start + 10;
    parameter x_start = 0;
    parameter x_end = x_start + 64*4;
    //characters are 8 pixels wide and 10 pixels tall

    reg [5:0] memory_array [0:69]; // Memory array
    
    reg [9:0] address;               // Address for memory array
    always @(posedge clk) begin
        if(~rst_n) begin
            char_out <= 0;
            address <= 0;
            memory_array[0] <= 6'b000000;
            memory_array[1] <= 6'b000001;
            memory_array[2] <= 6'b000010;
            memory_array[3] <= 6'b000011;
            memory_array[4] <= 6'b000100;
            memory_array[5] <= 6'b000101;
            memory_array[6] <= 6'b000110;
            memory_array[7] <= 6'b000111;
            memory_array[8] <= 6'b001000;
            memory_array[9] <= 6'b001001;
            memory_array[10] <= 6'b001010;
            memory_array[11] <= 6'b001011;
            memory_array[12] <= 6'b001100;
            memory_array[13] <= 6'b001101;
            memory_array[14] <= 6'b001110;
            memory_array[15] <= 6'b001111;
            memory_array[16] <= 6'b010000;
            memory_array[17] <= 6'b010001;
            memory_array[18] <= 6'b010010;
            memory_array[19] <= 6'b010011;
            memory_array[20] <= 6'b010100;
            memory_array[21] <= 6'b010101;
            memory_array[22] <= 6'b010110;
            memory_array[23] <= 6'b010111;
            memory_array[24] <= 6'b011000;
            memory_array[25] <= 6'b011001;
            memory_array[26] <= 6'b011010;
            memory_array[27] <= 6'b011011;
            memory_array[28] <= 6'b011100;
            memory_array[29] <= 6'b011101;
            memory_array[30] <= 6'b011110;
            memory_array[31] <= 6'b011111;
            memory_array[32] <= 6'b100000;
            memory_array[33] <= 6'b100001;
            memory_array[34] <= 6'b100010;
            memory_array[35] <= 6'b100011;
            memory_array[36] <= 6'b000000;
            memory_array[37] <= 6'b000001;
            memory_array[38] <= 6'b000010;
            memory_array[39] <= 6'b000011;
            memory_array[40] <= 6'b000100;
            memory_array[41] <= 6'b000101;
            memory_array[42] <= 6'b000110;
            memory_array[43] <= 6'b000111;
            memory_array[44] <= 6'b001000;
            memory_array[45] <= 6'b001001;
            memory_array[46] <= 6'b001010;
            memory_array[47] <= 6'b001011;
            memory_array[48] <= 6'b001100;
            memory_array[49] <= 6'b001101;
            memory_array[50] <= 6'b001110;
            memory_array[51] <= 6'b001111;
            memory_array[52] <= 6'b010000;
            memory_array[53] <= 6'b010001;
            memory_array[54] <= 6'b010010;
            memory_array[55] <= 6'b010011;
            memory_array[56] <= 6'b010100;
            memory_array[57] <= 6'b010101;
            memory_array[58] <= 6'b010110;
            memory_array[59] <= 6'b010111;
            memory_array[60] <= 6'b011000;
            memory_array[61] <= 6'b011001;
            memory_array[62] <= 6'b011010;
            memory_array[63] <= 6'b011011;
        end else if (write) begin
            memory_array[address] <= char_in;
        end else begin
            if(xcoor >= x_start && xcoor <= x_end) begin
                address <= xcoor - x_start;
                if(ycoor >= y_start && ycoor <= y_end) begin
                    char_out <= memory_array[((address)/4)];
                end else begin
                    char_out <= 6'b111111;
                end
            end else begin
                char_out <= 6'b111111;
            end
            
        end
    end

endmodule
