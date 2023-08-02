`timescale 1ns/1ps

module rgb_active (
    input wire active,                  // Active video signal
    input wire [1:0] red_pixel,         // red_pixel 2-bit input
    input wire [1:0] green_pixel,       // green_pixel 2-bit input
    input wire [1:0] blue_pixel,        // blue_pixel 2-bit input
    output wire [5:0] vga_out           // vga_out 6-bit output
);

assign vga_out[0] = active & red_pixel[0];
assign vga_out[1] = active & red_pixel[1];
assign vga_out[2] = active & green_pixel[0];
assign vga_out[3] = active & green_pixel[1];
assign vga_out[4] = active & blue_pixel[0];
assign vga_out[5] = active & blue_pixel[1];

endmodule
