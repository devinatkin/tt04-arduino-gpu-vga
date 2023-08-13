`timescale 1ns/1ps

module tb_char_row;

    // Signals
    reg [5:0] char_in;
    reg [9:0] xcoor;
    reg [8:0] ycoor;
    reg write;
    wire [5:0] char_out;
    reg clk;
    reg rst_n;

    // Instantiate the original module
    char_row uut (
        .char_in(char_in),
        .xcoor(xcoor),
        .ycoor(ycoor),
        .write(write),
        .char_out(char_out),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk; // generate clock with 10ns period
    end

    // Test Stimulus
    initial begin
        // Initialization
        clk = 0;
        rst_n = 0;
        write = 0;
        char_in = 6'b000000;
        xcoor = 0;
        ycoor = 0;
        
        #10;
        rst_n = 1; // de-assert reset
        
        // Test write functionality
        xcoor = 0;
        char_in = 6'b101010;
        write = 1;
        #10;
        
        // Check data
        xcoor = 0;
        ycoor = 5; // within the y_start and y_end range
        write = 0;
        #10;
        $display("Output char: %b", char_out);
        
        // Check outside data
        ycoor = 15; // outside the y_start and y_end range
        #10;
        $display("Output char (outside y range): %b", char_out);
        
        // End simulation
        $finish;
    end

endmodule
