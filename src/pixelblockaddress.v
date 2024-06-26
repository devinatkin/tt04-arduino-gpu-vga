`timescale 1ns / 1ps

module PixelBlockAddress(
    input [9:0] x,
    input [9:0] y,
    output reg [10:0] address
);
    // x and y blocks are the coordinates divided by the block size (16). Making the total number of blocks 40x30
    // The division by 16 is accomplished by shifting right by 4 (equivalent to divide by 16), 
    // which is a close approximation but simplifies the operation.
    wire [9:0] x_block = x >> 4;
    wire [9:0] y_block = y >> 4;

    always @(*) begin
        // The address is calculated by multiplying the y block position by the number of blocks per row (64) 
        // and adding the x block position. The multiplication by 64 is accomplished by shifting left by 6.
        address = (y_block << 5) + (y_block << 3) + x_block;
    end

endmodule
