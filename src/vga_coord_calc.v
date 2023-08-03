`timescale 1ns/1ps

module VGA_Coord_Calc(
    input [9:0] x,
    input [9:0] y,
    input clk,
    input rst_n, // active low reset
    output reg [9:0] xcoor,
    output reg [9:0] ycoor
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        xcoor <= 0;
    end else if (x < 145 || x > 624) begin
        xcoor <= 0;
    end else begin
        xcoor <= (x - 144);
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        ycoor <= 0;
    end else if (y < 13 || y > 492) begin
        ycoor <= (y < 13) ? 0 : 480;
    end else begin
        ycoor <= (y - 12);
    end
end

endmodule
