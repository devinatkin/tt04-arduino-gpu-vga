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
    end else begin
        ball_x <= ball_x + ball_dx;
        ball_y <= ball_y + ball_dy;
        // ball_dx <= ball_dx;
        // ball_dy <= ball_dy;
        paddle_y <= paddle_y + btn_down - btn_up;

        if (ball_x == 0) begin // left wall collision
            ball_dx <= -ball_dx;
        end else if (ball_x == SCREEN_WIDTH - 1) begin // right wall collision
            ball_dx <= -ball_dx;
        end else if (ball_y == 0) begin // top wall collision
            ball_dy <= -ball_dy;
        end else if (ball_y == SCREEN_HEIGHT - 1) begin // bottom wall collision
            ball_dy <= -ball_dy;
        end else if (ball_x == 20 && ball_y >= paddle_y && ball_y <= paddle_y + PADDLE_HEIGHT) begin // paddle collision
            ball_dx <= -ball_dx;
        end

        
        pixel <= (x >= ball_x - 5 && x <= ball_x + 5 && y >= ball_y - 5 && y <= ball_y + 5);
    end
end

endmodule