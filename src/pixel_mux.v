`timescale 1ns/1ps

module pixel_mux (
    input wire [5:0] input0, input1, input2, input3, // Four 6-bit wide inputs
    input wire [1:0] select, // 2-bit selection line
    output reg [5:0] out // 6-bit output
);

always @(input0,input1,input2,input3,select) begin

    
    // Selects an input based on the select lines
    case (select)
        2'b00: out = input0;
        2'b01: out = input1;
        2'b10: out = input2;
        2'b11: out = input3;
        default: out = 6'b0; // In case of any other value, make output 0
    endcase
end

endmodule
