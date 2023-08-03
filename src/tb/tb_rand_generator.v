`timescale 1ns / 1ps

module tb_rand_generator;
    
    reg clk;
    reg reset_n;
    wire [11:0] rand_num;

    // Instantiate the DUT
    rand_generator dut (
        .clk(clk), 
        .reset_n(reset_n), 
        .rand_num(rand_num)
    );

    // Clock generator
    always begin
        #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;

        // Wait for a few clock cycles
        #20;

        // Deassert reset
        reset_n = 1;

        // Run for a while
        #100;

        // Assert reset again
        reset_n = 0;

        // Wait for a few clock cycles
        #20;

        // Deassert reset
        reset_n = 1;

        // Run for a while
        #100;

        // Finish the simulation
        $finish;
    end

    // Monitor procedure
    initial begin
        $monitor("At time %t, reset_n = %b, rand_num = %b", $time, reset_n, rand_num);
    end

endmodule
