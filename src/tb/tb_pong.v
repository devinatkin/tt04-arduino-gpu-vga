module tb_pong();

  reg clk;
  reg rst_n;
  reg btn_up;
  reg btn_down;
  reg [9:0] x;
  reg [8:0] y;
  wire pixel;

  // Instantiate the pong module
  pong pong1 (
    .clk(clk),
    .rst_n(rst_n),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .x(x),
    .y(y),
    .pixel(pixel)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    // Initial conditions
    clk = 0;
    rst_n = 0;
    btn_up = 0;
    btn_down = 0;
    x = 0;
    y = 0;

    // Reset the game
    #10 rst_n = 1;
    #20 rst_n = 0;

    // Test moving the paddle up
    #30 btn_up = 1;
    #40 btn_up = 0;

    // Test moving the paddle down
    #50 btn_down = 1;
    #60 btn_down = 0;

    // Move through each pixel and monitor the pixel output
    for (x = 0; x < 640; x = x+1) begin
      for (y = 0; y < 480; y = y+1) begin
        #2; // Small delay to observe output
        if (pixel) $display("Pixel ON at x = %0d, y = %0d", x, y);
      end
    end

    $finish;
  end

endmodule
