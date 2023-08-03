`timescale 1ns / 1ps

module rand_generator (
    input wire clk,
    input wire reset_n,
    output reg [11:0] rand_num
);

    reg [47:0] LFSR;

    always @(posedge clk) begin
        if (!reset_n) begin
            LFSR <= 48'h123456789ABC; // Initial seed
            rand_num <= 12'b0;
        end else begin
            LFSR <= {LFSR[46:0], LFSR[47]^LFSR[35]};
            rand_num <= LFSR[11:0];
        end
    end

endmodule
