`timescale 1ns/1ps

module tb_rgb_active;

  // Inputs
  reg active;
  reg [1:0] red_pixel;
  reg [1:0] green_pixel;
  reg [1:0] blue_pixel;

  // Outputs
  wire [5:0] vga_out;

  // Instantiate the module under test
  rgb_active dut (
    .active(active),
    .red_pixel(red_pixel),
    .green_pixel(green_pixel),
    .blue_pixel(blue_pixel),
    .vga_out(vga_out)
  );

  // Clock generation (if necessary)
  // reg clk;
  // always #5 clk = ~clk;

  // Test case procedure
  initial begin
    $display("Testbench started.");

    // Test case 1
    active = 1;
    red_pixel = 2'b00;
    green_pixel = 2'b11;
    blue_pixel = 2'b01;
    #10; // Some delay to observe output
    $display("Test case 1: vga_out = %b", vga_out);

    // Test case 2
    active = 0;
    red_pixel = 2'b01;
    green_pixel = 2'b00;
    blue_pixel = 2'b11;
    #10; // Some delay to observe output
    $display("Test case 2: vga_out = %b", vga_out);

    // Add more test cases as needed...

    // End of simulation
    $display("Testbench finished.");
    $finish;
  end

endmodule
