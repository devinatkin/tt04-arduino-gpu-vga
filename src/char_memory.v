`timescale 1ns/1ps

module char_memory (
    input wire clock,
    input wire rst_n,
    input wire write,
    input wire [1:0] x,
    input wire [2:0] y,
    input wire data_in,
    output reg data_out
);
    // Parameter to set the rst_n memory values for each bit
    parameter [19:0] RESET_VALUE = {
        4'b1010, 4'b0101, 4'b1010, 4'b1010, 4'b0101
    };

    // 4x5 memory array, 1-bit wide
    reg [4:0][3:0] memory;

    // Intermediary signal to hold the data read from the memory
    wire [3:0] row_data;
    
    // Instantiate the 5_1 mux to select the row
    mux_5_1 row_select (
        .sel(y),
        .in0(memory[0]),
        .in1(memory[1]),
        .in2(memory[2]),
        .in3(memory[3]),
        .in4(memory[4]),
        .out(row_data)
    );
    // Instantiate the 4_1 mux to select the column
    mux_4_1 col_select (
        .sel(x),
        .in0(row_data[0]),
        .in1(row_data[1]),
        .in2(row_data[2]),
        .in3(row_data[3]),
        .out(data_out)
    );

    // Memory Write Operation
    always @(posedge clock) begin
        if (!rst_n) begin
            integer i;
            for (i = 0; i < 5; i = i + 1) begin
                memory[i] <= RESET_VALUE[i*4 +: 4]; // Extract 4-bit chunks from RESET_VALUE
            end
        end else if (write) begin
            case (y)
                3'b000: memory[0][x] <= data_in;
                3'b001: memory[1][x] <= data_in;
                3'b010: memory[2][x] <= data_in;
                3'b011: memory[3][x] <= data_in;
                3'b100: memory[4][x] <= data_in;
                default: ; // Handle other cases if needed
            endcase
        end
    end

endmodule
