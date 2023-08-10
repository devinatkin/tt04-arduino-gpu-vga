`timescale 1ns/1ps

module mux_5_1(
    input [2:0] sel,  // 3-bit select input
    input [3:0] in0,  // 4-bit input 0
    input [3:0] in1,  // 4-bit input 1
    input [3:0] in2,  // 4-bit input 2
    input [3:0] in3,  // 4-bit input 3
    input [3:0] in4,  // 4-bit input 4
    output reg [3:0] out // 4-bit output
);

    // Always block to continuously evaluate the select inputs
    always @(*) begin
        case (sel)
            3'b000: out = in0; // If select is 000, output will be in0
            3'b001: out = in1; // If select is 001, output will be in1
            3'b010: out = in2; // If select is 010, output will be in2
            3'b011: out = in3; // If select is 011, output will be in3
            3'b100: out = in4; // If select is 100, output will be in4
            default: out = 4'b0000; // For any other select input, output is 0
        endcase
    end

endmodule
