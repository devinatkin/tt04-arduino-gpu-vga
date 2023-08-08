`timescale 1ns / 1ps

module SPI_Peripheral
(
  input wire clk,                       // System clock
  input wire rst_n,                     // Active-low reset
  input wire ss,                        // Slave Select (active-low)
  input wire mosi,                      // Master-Out-Slave-In
  output wire miso,                      // Master-In-Slave-Out
  input wire sclk,                      // SPI clock
  input wire [31:0] config_data,        // Data to be used by the device
  output reg [7:0] recieved_data        // Data recieved from the device
);


  reg [7:0] data_reg; // 8-bit data register to hold incoming data
  reg [7:0] data_out; // 8-bit data register to hold outgoing data
  reg [2:0] bit_counter; // Bit counter to keep track of the SPI bit position

    // Set the MISO line to the next bit in the data register
  assign miso = data_out[7];

  always @(posedge sclk) begin


    if (~rst_n) begin
      // Synchronous reset
      data_reg <= 8'h00;
      data_out <= 8'h00;
      bit_counter <= 3'b000;
      recieved_data <= 8'h00;
    end else begin
      // If the slave is not selected, then reset the bit counter
      if (ss) begin
        bit_counter <= 3'b000;
      end else begin
        // Otherwise, increment the bit counter
        bit_counter <= bit_counter + 1;
        // Shift the data bit into the data register
        data_reg <= {data_reg[6:0], mosi};
        data_out <= {data_out[6:0], 1'b0};
          

        // If the bit counter is 8, then the data transfer is complete
        if (bit_counter == 3'b111) begin
          // Set the recieved data register to the data register
          recieved_data <= {data_reg[6:0], mosi};
          data_reg <= 8'h00;
          // Set the Data Out register to the selected value
          if ({data_reg[6:0], mosi} == 8'b10001111) begin // If the data is 0x8F (10001111 in binary, the test data) then send 0xAA (10101010 in binary, the test response)
            //$display("Data is 0x8F, sending 0xAA");
            data_out <= 8'b10101010;
          end else begin // Otherwise, set data_out based on the data register
            // If data_reg[7] is 1, then set the data out based on data_reg[6:5]
            // If data_reg[7] is 0, then set the data out to 0
            if (mosi == 1) begin
              case(data_reg[5:4])
                2'b00: data_out <= config_data[7:0];
                2'b01: data_out <= config_data[15:8];
                2'b10: data_out <= config_data[23:16];
                2'b11: data_out <= config_data[31:24];
                default data_out <= 8'b00000000;
              endcase
            end else begin
              data_out <= 8'b00000000;
            end
          end
            // Otherwise, shift the data out register
          

          
      end
    end

    end
  end

endmodule
