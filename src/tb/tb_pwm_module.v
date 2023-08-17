`timescale 1ns/1ps

module tb_pwm_module;

  // Parameters
  localparam bit_width = 10;
  localparam CLK_PERIOD = 10; // Time period of the clock (in simulation time units)
  localparam [bit_width-1:0] max_value = (1<<bit_width)-1; // Maximum value of the PWM counter
  // Inputs
  logic clk;
  logic rst_n;
  logic [bit_width-1:0] duty;

  // Outputs
  wire pwm_out;

  // Variables
  integer i;
  integer clk_cycles;
  integer sum_pwm;
  real avg_pwm;

  // Instantiate the DUT (Device Under Test)
  pwm_module #(
    .bit_width(bit_width)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .duty(duty),
    .max_value(max_value), // Set maximum value to 2^32-1 (2^bit_width-
    .pwm_out(pwm_out)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Initialize inputs
  initial begin
    clk = 0;
    rst_n = 0; // Assert reset (active-low)
    duty = 0;  // Set initial duty cycle
    #20;       // Wait for a few cycles
    rst_n = 1; // Release reset
  end

  // Test cases
  initial begin
    #100; // Simulate for 100 time units

    // Test with different duty cycle values
    for (i = 0; i <= max_value; i = i + 1) begin
      duty = i; // Apply duty cycle value
      sum_pwm = 0;
      clk_cycles = 0;

      // Run a few hundred clock cycles before incrementing the duty cycle
      for (clk_cycles = 0; clk_cycles < max_value; clk_cycles = clk_cycles + 1) begin
        @(posedge clk);
        sum_pwm = sum_pwm + pwm_out; // Accumulate pwm_out values
      end

      avg_pwm = real'(sum_pwm)/clk_cycles;
      // Calculate the average duty cycle
      $display("Duty: %0d, PWM_SUM: %0d, Average PWM Output: %0f", duty, sum_pwm, avg_pwm);
    end

    #50; // Allow some extra time before ending the simulation
    $finish;
  end

endmodule
