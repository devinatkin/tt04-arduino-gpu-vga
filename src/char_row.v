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
    parameter y_end = y_start + 5;
    parameter x_start = 0;
    parameter x_end = x_start + 16*4;
    //characters are 8 pixels wide and 10 pixels tall

    reg [5:0] memory_array [0:15]; // Memory array
    
    reg [4:0] address;               // Address for memory array
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

        end else if (write) begin
            memory_array[address] <= char_in;
        end else begin
            if(xcoor >= x_start && xcoor <= x_end) begin
                address <= (xcoor[4:0] - x_start[4:0]);
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
