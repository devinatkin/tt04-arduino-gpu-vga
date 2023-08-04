`timescale 1ns / 1ps

module SPI_Peripheral_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    parameter DELAY = 5; // Delay in ns

    // Clock generation
    reg clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Signals
    reg rst_n;
    reg ss;
    reg mosi;
    wire miso;
    reg sclk;
    reg [7:0] data_in = 8'h12; // Test data
    reg [7:0] data_out;

    // Instance of the SPI_Peripheral module
    SPI_Peripheral uut (
        .clk(clk),
        .rst_n(rst_n),
        .ss(ss),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk)
    );

    initial begin
        // Reset the DUT
        rst_n <= 1'b0;
        #DELAY;
        rst_n <= 1'b1;

        // Initial states
        ss <= 1'b1; // Slave not selected
        sclk <= 1'b0; // SPI clock low
        mosi <= 1'b0; // MOSI line low

        // Start the SPI transaction
        #DELAY;
        ss <= 1'b0; // Select the slave
        for (integer i = 7; i >= 0; i = i - 1) begin
            // Shift the data bit into the MOSI line
            mosi <= data_in[i];
            // Toggle the SPI clock to transfer the bit
            #DELAY sclk <= 1'b1;
            #DELAY sclk <= 1'b0;
        end
        // Deselect the slave to end the transaction
        #DELAY;
        ss <= 1'b1;

        // Read the data back
        #DELAY;
        ss <= 1'b0; // Select the slave
        for (integer i = 7; i >= 0; i = i - 1) begin
            // Toggle the SPI clock to receive the bit
            #DELAY sclk <= 1'b1;
            #DELAY sclk <= 1'b0;
            data_out[i] <= miso; // Shift the bit from the MISO line
        end
        // Deselect the slave to end the transaction
        #DELAY;
        ss <= 1'b1;

        // Check the received data
        #DELAY;
        if (data_in == data_out)
            $display("Test passed. Received data is correct.");
        else
            $display("Test failed. Received data: %h, Expected data: %h", data_out, data_in);

        // End the simulation
        $finish;
    end
endmodule
