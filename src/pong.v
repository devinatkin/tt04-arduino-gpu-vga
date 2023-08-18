`timescale 1ns/1ps

module pong (
    input clk,
    input rst_n,
    input btn_up_raw, // Raw button input for up
    input btn_down_raw, // Raw button input for down
    input [9:0] x,
    input [8:0] y,
    output reg pixel
);

    // Screen size
    parameter SCREEN_WIDTH = 640;
    parameter SCREEN_HEIGHT = 480;

    // Ball speed and direction
    reg [9:0] ball_x, ball_y;
    reg [2:0] ball_dx, ball_dy;

    // Paddle position and size
    reg [8:0] paddle_y;
    parameter PADDLE_HEIGHT = 40;

    // Debounced button signals
    wire btn_up; // Debounced button input for up
    wire btn_down; // Debounced button input for down

    // Instantiate debounce module for btn_up
    debounce debounce_up (
        .clk(clk),
        .rst_n(rst_n),
        .button_in(btn_up_raw),
        .button_out(btn_up)
    );

    // Instantiate debounce module for btn_down
    debounce debounce_down (
        .clk(clk),
        .rst_n(rst_n),
        .button_in(btn_down_raw),
        .button_out(btn_down)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            ball_x <= SCREEN_WIDTH / 2;
            ball_y <= SCREEN_HEIGHT / 2;
            ball_dx <= 2'b01; // arbitrary initial direction
            ball_dy <= 2'b01;
            paddle_y <= (SCREEN_HEIGHT - PADDLE_HEIGHT) / 2;
        end else begin
            // Existing code for ball movement and collision
            // ...

            // Paddle movement using debounced button signals
            paddle_y <= paddle_y + btn_down - btn_up;

            // Existing code for pixel output
            // ...
        end
    end

endmodule
