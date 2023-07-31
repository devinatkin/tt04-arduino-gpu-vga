`timescale 1ns/1ps

module vga_timing_gen_tb;
    
    // Parameters
    localparam CLK_PERIOD = 40; // 100 MHz clock for this test
    
    // Signals
    reg clk;
    reg rst_n;
    wire hs;
    wire vs;
    wire [9:0] x;
    wire [8:0] y;
    wire active;

    // Instantiate the DUT
    vga_timing_gen DUT (
        .clk(clk),
        .rst_n(rst_n),
        .hs(hs),
        .vs(vs),
        .x(x),
        .y(y),
        .active(active)
    );
    
    // Clock generation
    always begin
        #CLK_PERIOD clk = ~clk;
    end
    
    // Test process
    initial begin
        // Initialize signals
        clk = 1'b0;
        rst_n = 1'b0;
        
        // Reset
        #(CLK_PERIOD * 2);
        rst_n = 1'b1;
        
        // Run for a while to check behavior
        #(CLK_PERIOD*20000) ;
        
        // Assert reset again
        #CLK_PERIOD rst_n = 1'b0;
        
        // Deassert reset
        #CLK_PERIOD rst_n = 1'b1;
        
        // Run for a while to check behavior
        #(CLK_PERIOD*20000) ;
        
        // End of the test
        $finish;
    end
    
    // Monitor process for tracking the signals
    initial begin
        $monitor("At time %t, x=%d, y=%d, hs=%b, vs=%b, active=%b", $time, x, y, hs, vs, active);
    end
    
endmodule
