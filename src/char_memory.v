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
    parameter [19:0] RESET_VALUE = 20'b10100101101010100101;


    // 4x5 memory array, 1-bit wide
    reg [19:0] memory;

    // Intermediary signal to hold the data read from the memory
    wire [3:0] row_data;
    
    // Instantiate the 5_1 mux to select the row
    mux_5_1 row_select (
        .sel(y),
        .in0(memory[3:0]),
        .in1(memory[7:4]),
        .in2(memory[11:8]),
        .in3(memory[15:12]),
        .in4(memory[19:16]),
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
            for (i = 0; i < 20; i = i + 1) begin
                memory[i] <= RESET_VALUE[i]; // Extract 1-bit from the reset value
            end
        end else if (write) begin
            case (y)
                3'b000: memory[0+x] <= data_in;
                3'b001: memory[4+x] <= data_in;
                3'b010: memory[8+x] <= data_in;
                3'b011: memory[12+x] <= data_in;
                3'b100: memory[16+x] <= data_in;
                default: ; // Handle other cases if needed
            endcase
        end
    end

endmodule
