module pwm_module
#(parameter bit_width = 3)
(
clk,        // 1-bit input: clock
rst_n,      // 1-bit input: reset
duty,       // 8-bit input: duty cycle
max_value,  // 8-bit input: maximum value
pwm_out     // 1-bit output: pwm output
);
input clk, rst_n;
input [bit_width-1:0] duty;
input [bit_width-1:0] max_value;
output reg pwm_out;

reg [bit_width:0] counter;

// pwm output is high when counter is less than duty
// otherwise, pwm output is low
always @(posedge clk)
begin
    if (~rst_n) begin
        counter <= 0;
        pwm_out <= 0;
    end else if (counter == duty) begin
        pwm_out <= 0;
        counter <= counter + 1;
    end else if (counter == max_value) begin
        counter <= 0;
        pwm_out <= 1;
    end else
        counter <= counter + 1;
end
endmodule
