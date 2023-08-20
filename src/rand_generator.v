`timescale 1ns / 1ps

module rand_generator (
    input wire clk,
    input wire reset_n,
    output reg [11:0] rand_num
);

    reg [31:0] LFSR; // Reduced to 32-bit LFSR

    always @(posedge clk) begin
        if (!reset_n) begin
            LFSR <= 32'h12345678; // Initial seed with reduced size
            rand_num <= 12'b0;
        end else begin
            LFSR <= {LFSR[30:0], LFSR[31]^LFSR[21]^LFSR[1]^LFSR[0]}; // New polynomial
            rand_num <= LFSR[11:0];
        end
    end

endmodule
