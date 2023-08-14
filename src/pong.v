module pong (
    input clk,
    input rst_n,
    input btn_up,
    input btn_down,
    input [9:0] x,
    input [8:0] y,
    output reg pixel
);

// Screen size
parameter SCREEN_WIDTH = 640;
parameter SCREEN_HEIGHT = 480;

// Ball speed and direction
reg [9:0] ball_x, ball_y;
reg [9:0] ball_dx, ball_dy;

// Paddle position and size
reg [8:0] paddle_y;
parameter PADDLE_HEIGHT = 40;

always @(posedge clk) begin
    if (!rst_n) begin
        ball_x <= SCREEN_WIDTH / 2;
        ball_y <= SCREEN_HEIGHT / 2;
        ball_dx <= 2'b01;  // arbitrary initial direction
        ball_dy <= 2'b01;
        paddle_y <= (SCREEN_HEIGHT - PADDLE_HEIGHT) / 2;
    end
end

always @(posedge clk) begin
    if (ball_x + ball_dx >= SCREEN_WIDTH || ball_x + ball_dx <= 0)
        ball_dx <= -ball_dx;
    if (ball_y + ball_dy >= SCREEN_HEIGHT || ball_y + ball_dy <= 0)
        ball_dy <= -ball_dy;

    ball_x <= ball_x + ball_dx;
    ball_y <= ball_y + ball_dy;
end

always @(posedge clk) begin
    // Check if ball collides with the paddle
    if (ball_x <= 10 && ball_y >= paddle_y && ball_y <= paddle_y + PADDLE_HEIGHT) begin
        ball_dx <= -ball_dx;
    end
end

always @(posedge clk) begin
    if (btn_up && paddle_y > 0) 
        paddle_y <= paddle_y - 1;
    else if (btn_down && paddle_y + PADDLE_HEIGHT < SCREEN_HEIGHT)
        paddle_y <= paddle_y + 1;
end

always @(posedge clk) begin
    pixel <= 0;
    if ((x == ball_x && y == ball_y) || (x <= 10 && y >= paddle_y && y <= paddle_y + PADDLE_HEIGHT)) begin
        pixel <= 1;
    end
end

endmodule