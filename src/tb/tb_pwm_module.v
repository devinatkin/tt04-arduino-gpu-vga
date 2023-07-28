module tb_pwm_module;

  // Parameters
  localparam bit_width = 3;
  localparam CLK_PERIOD = 10; // Time period of the clock (in simulation time units)

  // Inputs
  logic clk;
  logic rst_n;
  logic [bit_width-1:0] duty;

  // Outputs
  logic pwm_out;

  // Instantiate the DUT (Device Under Test)
  pwm_module #(
    .bit_width(bit_width)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .duty(duty),
    .max_value(3'h7),
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
    #100;     // Simulate for 100 time units

    // Test with different duty cycle values
    for (int i = 0; i <= (1<<bit_width); i++) begin
      duty = i; // Apply duty cycle value

      // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
            // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
            // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
            // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
            // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
            // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
    // Wait for a few clock cycles to observe the PWM output
      #10;
      // Display the output
      $display("Duty: %0d, PWM Output: %b", duty, pwm_out);
    end

    #50; // Allow some extra time before ending the simulation
    $finish;
  end

endmodule
