`timescale 1ns / 1ps

module rand_generator (
    input wire clk,
    input wire reset_n,
    input wire enable,       // Active-high enable signal
    output reg [11:0] rand_num // 12-bit output
);

    reg [11:0] LFSR; // 12-bit LFSR

    always @(posedge clk) begin
        if (!reset_n) begin
            LFSR <= 12'h123; // Initial seed with reduced size
            rand_num <= 12'b0;
        end else if (enable) begin
            // Feedback polynomial for 12-bit LFSR
            // The polynomial was chosen based on common taps for a 12-bit LFSR
            // You might want to choose another polynomial depending on your specific requirements
            LFSR <= {LFSR[10:0], LFSR[11]^LFSR[8]}; 
            rand_num <= LFSR; // Output the entire 12-bit LFSR
        end
    end

endmodule
