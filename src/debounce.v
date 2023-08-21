`timescale 1ns/1ps

module debounce(
    input wire clk,        // Clock signal
    input wire rst_n,      // Active-low asynchronous reset
    input wire button_in,  // Raw button input
    output reg button_out  // Debounced button output
);

    parameter DEBOUNCE_TIME = 3'b111; // Define debounce time (must be within 8-bit range)

    reg [2:0] counter; // 5-bit counter to measure the debounce time

    always @(posedge clk) begin
        if (!rst_n) begin
            button_out <= 1'b0; // Reset debounced button output
            counter <= 3'd0;    // Reset counter
        end else begin
            if (button_in == button_out) begin
                counter <= 3'd0; // If button state matches debounced state, reset the counter
            end else begin
                if (counter == DEBOUNCE_TIME - 1'd1) begin
                    button_out <= button_in; // If debounce time has passed, update the debounced output
                end else begin
                    counter <= counter + 3'd1; // Otherwise, increment the counter
                end
            end
        end
    end

endmodule
