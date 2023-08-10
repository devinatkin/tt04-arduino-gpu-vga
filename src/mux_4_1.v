`timescale 1ns/1ps

module mux_4_1(
    input [1:0] sel, // 2-bit select input
    input in0,       // 1-bit input 0
    input in1,       // 1-bit input 1
    input in2,       // 1-bit input 2
    input in3,       // 1-bit input 3
    output reg out  // 1-bit output
);

    // Always block to continuously evaluate the select inputs
    always @(*) begin
        case (sel)
            2'b00: out = in0; // If select is 00, output will be in0
            2'b01: out = in1; // If select is 01, output will be in1
            2'b10: out = in2; // If select is 10, output will be in2
            2'b11: out = in3; // If select is 11, output will be in3
        endcase
    end

endmodule
