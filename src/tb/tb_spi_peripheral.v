`timescale 1ns / 1ps

module tb_spi_peripheral();

    reg clk;
    reg rst_n;
    reg ss;
    reg mosi;
    wire miso;
    reg sclk;
    reg [31:0] config_data = 0; // Keeping the original 32-bit width
    wire [7:0] received_data; // Temporarily adding this wire for observation
    reg [7:0] data_out = 0; // Temporarily adding this wire for observation
    // Instantiate the SPI_Peripheral module
    SPI_Peripheral UUT (
        .clk(clk), 
        .rst_n(rst_n), 
        .ss(ss), 
        .mosi(mosi), 
        .miso(miso), 
        .sclk(sclk),
        .config_data(config_data), // Connect original config_data port
        .recieved_data(received_data) // Connect original received_data port
    );

    // Clock Generation
    always
    begin
        #5 clk = ~clk;  // Generate a clock with period 10ns
    end

    // Test sequences
    initial 
    begin
        $dumpfile("tb_spi.vcd");
        $dumpvars(0, tb_spi_peripheral);
        // Initialize all inputs
        clk = 0;
        rst_n = 0;
        sclk = 0;
        #10 sclk = 1;
        #10 ss = 1;
        mosi = 0;
        sclk = 0;
        #10 sclk = 1;

        #10 rst_n = 1;  // Release reset after 10ns
        #10 ss = 0;     // Activate Slave Select after 20ns
        #10;            // Wait for 10ns

        // Writing 0x8F to SPI
        config_data = 8'h8F; // Assigning the value here

        for (int i = 7; i >= 0; i = i - 1) begin // Transmitting bit by bit
            
            
            #10 sclk = 1;
            #10 sclk = 0;
            #10 mosi = config_data[i]; // Transmitting bit by bit
            $display("Transmitting data: %h", config_data[i]);
        end

        #10 sclk = 1;
        // #10 sclk = 0; 

        for (int i = 7; i >= 0; i = i - 1) begin // Receiving bit by bit
            
            #10 mosi = 0; // Transmitting bit by bit
            #10 sclk = 0;
            #10 sclk = 1;
            
            data_out[i] <= miso; // Temporarily storing the received data
            $display("Receiving data: %h", miso);
        end
        #10 sclk = 1;
        #10 sclk = 0;
        #10 ss = 1;  // Deactivate Slave Select
        
        // Display received data
        $display("Received data: %h", data_out);

        #100 $finish; // Finish simulation
    end
endmodule
