`timescale 1ns/1ps

module char_memory #(parameter [11:0] RESET_VALUE = 12'b010101010101)(
    input wire clock,
    input wire rst_n,
    input wire write,
    input wire [1:0] x,
    input wire [2:0] y,
    input wire data_in,
    output reg data_out
);

    // 4x4 memory array, 1-bit wide
    reg [11:0] memory;

    // Intermediary signal to hold the data read from the memory
    reg [3:0] row_data;

    // Read logic
    always @(posedge clock) begin
        if (!rst_n) begin
            memory <= RESET_VALUE;
        end else begin
            // Read operation
            case (y)
                3'b000: row_data <= {1'b0, memory[2:0]}; // Prefixing zero
                3'b001: row_data <= {1'b0, memory[5:3]}; // Prefixing zero
                3'b010: row_data <= {1'b0, memory[8:6]}; // Prefixing zero
                3'b011: row_data <= {1'b0, memory[11:9]}; // Prefixing zero
                3'b100: row_data <= {1'b0, memory[11:9]}; // Prefixing zero
            endcase

            // Select column with 4-to-1 MUX
            case (x)
                2'b00: data_out <= row_data[0];
                2'b01: data_out <= row_data[1];
                2'b10: data_out <= row_data[2];
                2'b11: data_out <= row_data[3];
            endcase
        end
    end

    // Write operation (only bits 1 to 3 are writable)
    // always @(posedge clock) begin
    //     if (write && x > 0) begin
    //         case (y)
    //         3'b000: data_out <= (x == 0) ? 1'b0 : memory[3*(x-1)];
    //         3'b001: data_out <= (x == 0) ? 1'b0 : memory[3*(x-1)+1];
    //         3'b010: data_out <= (x == 0) ? 1'b0 : memory[3*(x-1)+2];
    //         3'b011: data_out <= (x == 0) ? 1'b0 : memory[3*(x-1)+3];
    //         3'b100: data_out <= (x == 0) ? 1'b0 : memory[3*(x-1)+4];
    //         endcase
    //     end
    // end
endmodule
