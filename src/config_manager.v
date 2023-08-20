`timescale 1ns/1ps

module config_manager(
    input wire clk,        // Clock input
    input wire rst_n,      // Active-low reset input
    input wire enable,     // Active high enable signal
    input wire [7:0] data_in,
    output reg [31:0] config_out
);

// Temporary variable to hold the 4-bit data
reg [3:0] data_to_write;

// Temporary variable to hold the 3-bit address
reg [2:0] write_address;

// Always block triggered on the rising edge of clk or falling edge of rst_n
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // If reset is active (low), set config_out to default configuration
        config_out <= 32'b1011_1011_1111_1100_0000_0000_0000_0000;
    end else if (enable && data_in[7] == 0) begin
        // If MSB of data_in is 0 and reset is not active
        write_address <= data_in[6:4];
        data_to_write <= data_in[3:0];
        
        // Write the data to the selected point in the configuration
        case(write_address)
            3'b000: config_out[3:0] <= data_to_write;
            3'b001: config_out[7:4] <= data_to_write;
            3'b010: config_out[11:8] <= data_to_write;
            3'b011: config_out[15:12] <= data_to_write;
            3'b100: config_out[19:16] <= data_to_write;
            3'b101: config_out[23:20] <= data_to_write;
            3'b110: config_out[27:24] <= data_to_write;
            3'b111: config_out[31:28] <= data_to_write;
        endcase
    end
end

endmodule
