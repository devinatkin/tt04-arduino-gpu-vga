`timescale 1ns / 1ps

module rand_generator (
    input wire clk,
    input wire reset_n,
    output reg [11:0] rand_num
);

    reg [23:0] LFSR; // Reduced to 24-bit LFSR

    always @(posedge clk) begin
        if (!reset_n) begin
            LFSR <= 24'h123456; // Initial seed with reduced size
            rand_num <= 12'b0;
        end else begin
            LFSR <= {LFSR[22:0], LFSR[23]^LFSR[22]^LFSR[21]^LFSR[16]}; // New polynomial
            rand_num <= LFSR[11:0];
        end
    end

endmodule
