`timescale 1ns/1ps

module vga_controller(
    input wire clk,
    input wire rst_n,
    input wire enable,
    output wire hs,
    output wire vs,
    output wire [7:0] uo_out,
    output wire [9:0] x,
    output wire [9:0] y,
    input wire [11:0] rand_num,
    input wire [31:0] configuration,
    input wire character_out,
    input wire pong_pixel,
    output wire [9:0] xcoor,
    output wire [9:0] ycoor
);

    wire active;
    wire [1:0] red_pixel;
    wire [1:0] green_pixel;
    wire [1:0] blue_pixel;

    // VGA Timing Generator
    vga_timing_gen vga_timing(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .hs(uo_out[0]),
        .vs(uo_out[1]),
        .x(x),
        .y(y),
        .active(active)
    );

    // RGB Active Output Control
    rgb_active output_control(
        .active(active),
        .red_pixel(red_pixel),
        .green_pixel(green_pixel),
        .blue_pixel(blue_pixel),
        .vga_out(uo_out[7:2])
    );

    // VGA Coordinate Calculator
    VGA_Coord_Calc xy_calc (
        .x(x),
        .y(y),
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor)
    );

    // Pixel Multiplexer
    pixel_mux pixel_multiplexer (
        .input0(rand_num[5:0]),
        .input1(configuration[29:24]),
        .input2(configuration[29:24] & {6{character_out}}),
        .input3(configuration[29:24] & {6{pong_pixel}}),
        .select(configuration[31:30]),
        .out({red_pixel, green_pixel, blue_pixel})
    );

endmodule
