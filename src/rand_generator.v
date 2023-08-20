`timescale 1ns / 1ps

module rand_generator (
    input wire clk,
    input wire reset_n,
    input wire enable,      // Active-high enable signal
    output reg [11:0] rand_num // Reduced to 20-bit output
);

    reg [19:0] LFSR; // Reduced to 20-bit LFSR

    always @(posedge clk) begin
        if (!reset_n) begin
            LFSR <= 20'h12345; // Initial seed with reduced size
            rand_num <= 20'b0;
        end else if (enable) begin // Added enable condition here
            // Feedback polynomial for 20-bit LFSR
            // You may want to choose a different polynomial that suits your application
            LFSR <= {LFSR[18:0], LFSR[19]^LFSR[17]^LFSR[16]^LFSR[15]}; 
            rand_num <= LFSR[11:0]; // Output the entire 20-bit LFSR
        end
    end

endmodule
