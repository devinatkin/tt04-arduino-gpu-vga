`timescale 1ns/1ps

module VGA_Coord_Calc_tb;

    // Parameters
    localparam CLK_PERIOD = 40; // 100 MHz clock for this test
    
    // Signals
    reg clk;
    reg rst_n;
    wire [9:0] x;
    wire [9:0] y;
    wire hs;
    wire vs;
    wire active;
    wire [9:0] xcoor;
    wire [9:0] ycoor;

    // Instantiate the VGA timing generator
    vga_timing_gen DUT_timing (
        .clk(clk),
        .rst_n(rst_n),
        .hs(hs),
        .vs(vs),
        .x(x),
        .y(y),
        .active(active)
    );

    // Instantiate the DUT
    VGA_Coord_Calc DUT (
        .x(x),
        .y(y),
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor)
    );
    
    // Clock generation
    always begin
        #CLK_PERIOD clk = ~clk;
    end
    
    // Test process
    initial begin

        $dumpfile("vga_wave.vcd");           // create a VCD waveform dump called "vga_wave.vcd"
        $dumpvars(0, VGA_Coord_Calc_tb);      // dump variable changes in the testbench
                                              // and all modules under it

        // Initialize signals
        clk = 1'b0;
        rst_n = 1'b0;
        
        // Reset
        #(CLK_PERIOD * 2);
        rst_n = 1'b1;

        // Run for a while to check behavior
        #(CLK_PERIOD*840000) ;
        
        // End of the test
        $finish;
    end
    
    // Monitor process for tracking the signals
    initial begin
        $monitor("At time %t, x=%d, y=%d, xcoor=%d, ycoor=%d, hs=%b, vs=%b, active=%b", 
                 $time, x, y, xcoor, ycoor, hs, vs, active);
    end
    
endmodule
