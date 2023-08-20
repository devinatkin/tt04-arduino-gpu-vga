`timescale 1ns/1ps


module pwm_module
#(parameter bit_width = 3)
(
clk,        // 1-bit input: clock
rst_n,      // 1-bit input: reset
enable,     // 1-bit input: enable
duty,       // bitwidth-bit input: duty cycle
max_value,  // bitwidth-bit input: maximum value
pwm_out,     // 1-bit output: pwm output
counter     // bitwidth-bit output: counter
);
input clk, rst_n, enable;
input [bit_width-1:0] duty;
input [bit_width-1:0] max_value;
output reg pwm_out;
output reg [bit_width-1:0] counter;

// pwm output is high when counter is less than duty
// otherwise, pwm output is low
always @(posedge clk)
begin
    if (~rst_n) begin
        counter <= 0;
        pwm_out <= 0;
    end else if (enable) begin // Check if enable signal is active
        if (counter == max_value) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
        pwm_out <= (counter < duty);
    end else begin
        // Define the behavior when enable is not asserted
        // This could be maintaining current state or setting specific default values
        // Example: keep counter and pwm_out at their current values
    end
end
endmodule
