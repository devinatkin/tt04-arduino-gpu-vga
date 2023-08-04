`timescale 1ns / 1ps

module SPI_Peripheral (
  input wire clk,   // System clock
  input wire rst_n, // Active-low reset
  input wire ss,    // Slave Select (active-low)
  input wire mosi,  // Master-Out-Slave-In
  output reg miso,  // Master-In-Slave-Out
  input wire sclk   // SPI clock
);

// State definitions
parameter IDLE = 2'b00,  // Idle state, waiting for Slave Select to go active
          RECEIVING = 2'b01, // Receiving data from master
          SENDING = 2'b10;   // Sending data to master

reg [1:0] state;  // Current state
reg [7:0] data_reg; // 8-bit data register to hold incoming data
reg [2:0] bit_counter; // Bit counter to keep track of the SPI bit position

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    // Synchronous reset
    state <= IDLE;
    data_reg <= 8'h00;
    bit_counter <= 3'b000;
  end else begin
    // State machine
    case (state)
      IDLE: begin
        if (~ss) begin
          // If Slave Select goes active, transition to RECEIVING state
          state <= RECEIVING;
        end
      end
      RECEIVING: begin
        if (ss) begin
          // If Slave Select goes inactive, transition back to IDLE
          state <= IDLE;
        end else if (bit_counter == 3'b111) begin
          // If we've received 8 bits, transition to SENDING state
          state <= SENDING;
        end else begin
          // Shift data register to the left and append the new bit
          data_reg <= {data_reg[6:0], mosi};
          bit_counter <= bit_counter + 1;
        end
      end
      SENDING: begin
        if (ss) begin
          // If Slave Select goes inactive, transition back to IDLE
          state <= IDLE;
        end else begin
          // Output the most significant bit of data_reg on MISO
          miso <= data_reg[7];
          // Shift data register to the left, appending a zero
          data_reg <= {data_reg[6:0], 1'b0};
          bit_counter <= bit_counter - 1;
          if (bit_counter == 3'b000) begin
            // If we've sent 8 bits, transition back to IDLE
            state <= IDLE;
          end
        end
      end
    endcase
  end
end

endmodule
