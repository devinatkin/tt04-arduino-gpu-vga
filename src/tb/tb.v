`default_nettype none
`timescale 1ns/1ps

module tb ();

    // Parameters
    parameter DELAY = 100; // Delay in ns

    // Declarations
    integer outfile;
    integer counter = 0;  // Counter for driving ui_in[7:6]
    reg clk = 0;          // Clock signal initialization
    reg rst_n;            // Reset signal
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg [7:0] data_in = 8'h12;  // Test data
    reg [7:0] data_out;
    reg ss;               // Slave Select for SPI
    reg mosi;             // Master Out Slave In for SPI
    reg sclk;             // SPI clock
    wire miso = uio_out[0];     // Master In Slave Out for SPI
    wire [6:0] segments = uo_out[6:0];
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Task for writing simulation results to an output file
    task write_to_file (input integer sim_time, input reg hs, input reg vs, input reg [1:0] red, input reg [1:0] green, input reg [1:0] blue);
        begin
            $fwrite(outfile, "%0d ns: %b %b %b %b %b\n", sim_time, hs, vs, red, green, blue);
        end
    endtask

    // Simulation Initialization
    initial begin
        outfile = $fopen("output.txt", "w");
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // Clock generation: 25 MHz
    always #20 clk = ~clk;

    // Reset signal generation
    initial begin
        // Reset the DUT
        rst_n <= 1'b0;
        #DELAY;
        rst_n <= 1'b1;
    end

    // Driving ui_in based on counter value
    always @(posedge clk) begin
        counter = counter + 1;  // Increment counter every clock cycle
        ui_in[7:6] = (counter / 100) % 4;
    end

    // Call the write_to_file task on every clock edge
    always @(posedge clk) begin
        write_to_file($realtime, uo_out[0], uo_out[1], uo_out[3:2], uo_out[5:4], uo_out[7:6]);
    end

    // Device Under Test (DUT) instantiation
    tt_um_devinatkin_arduino_vga DUT (
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Simulation termination after 1 second
    initial #1e8 $finish;

    // File closure at the end of the simulation
    final begin
        $fclose(outfile);
    end

    // SPI signal assignments
    always @(*) begin
        ui_in[2] = ss;
        ui_in[0] = mosi;
        ui_in[1] = sclk;
    end

    // SPI transaction and result checking
    initial begin

        // Reset the DUT
        //rst_n <= 1'b0;
        #DELAY;
        //rst_n <= 1'b1;

        // Initial states
        ss <= 1'b1; 
        sclk <= 1'b0; 
        mosi <= 1'b0; 

        // SPI Write transaction
        #(DELAY);
        ss <= 1'b0; 

        for (integer i = 7; i >= 0; i = i - 1) begin
            // Shift the data bit into the MOSI Line
            mosi <= data_in[i];
            // Toggle the clock line to transfer the bit
            #DELAY sclk <= 1'b1;
            #DELAY sclk <= 1'b0;
        end

        // Deselect the slave to end the transaction
        #DELAY; 
        ss <= 1'b1;

        // SPI Read transaction
        #DELAY;
        ss <= 1'b0; // Select the slave
        for (integer i = 7; i >= 0; i = i - 1) begin
            #DELAY sclk <= 1'b1;
            #DELAY sclk <= 1'b0;
            data_out[i] <= miso; // Read the data bit from the MISO line
        end
        // Deselect the slave to end the transaction
        #DELAY;
        ss <= 1'b1;

        // Check results
        #DELAY;
        if (data_in == data_out)
            $display("Test passed. Received data is correct.");
        else
            $display("Test failed. Received data: %h, Expected data: %h", data_out, data_in);
            $finish;
    
    end

endmodule
