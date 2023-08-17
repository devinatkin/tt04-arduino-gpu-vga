`timescale 1ns/1ps

module vga_timing_gen_tb;
    
    // Parameters
    localparam CLK_PERIOD = 39.721946375372; // 25.175 MHz clock for this test
    
    // Signals
    reg clk;            // System clock
    reg rst_n;          // Active-low reset signal
    wire hs;            // Horizontal sync signal
    wire vs;            // Vertical sync signal
    wire [9:0] x;       // Current x position (column)
    wire [9:0] y;       // Current y position (row)
    wire active;        // Active video signal

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
        #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Pulse width monitoring
    integer hpulse_start_time;
    integer vpulse_start_time;
    integer hsync_pulse_width;
    integer vsync_pulse_width;

    integer last_hsync_time = 0;
    integer last_vsync_time = 0;
    integer hsync_period = 0;
    integer vsync_period=0;

    // Test process
    initial begin

        $dumpfile("vga_wave.vcd");      // create a VCD waveform dump called "wave.vcd"
        $dumpvars(0, vga_timing_gen_tb); // dump variable changes in the testbench
                                    // and all modules under it

        // Initialize signals
        clk = 1'b0;
        rst_n = 1'b0;
        
        // Reset
        #(CLK_PERIOD * 2);
        rst_n = 1'b1;
        
        // Run for a while to check behavior
        #(CLK_PERIOD*20000) ;
        // Run for a while to check behavior
        #(CLK_PERIOD*940000) ;
        #(CLK_PERIOD*940000) ;
        #(CLK_PERIOD*940000) ;
        // End of the test
        $finish;
    end
    


    always @(posedge hs or negedge hs) begin
        if (hs) begin
            hsync_period = $time - last_hsync_time;
            last_hsync_time = $time; // Store the current time for the next calculation
            //$display("At time %t, hsync period is %f", ($time/1000000.0), hsync_period/1000.0);
        end else begin
            hsync_pulse_width = $time - hpulse_start_time;

        end
    end

    always @(posedge vs or negedge vs) begin
        if (vs) begin
            vsync_period = $time - last_vsync_time;
            last_vsync_time = $time; // Store the current time for the next calculation
            $display("At time %t, vsync period is %f", ($time/1000000.0), vsync_period/1000000.0);
        end else begin
            vsync_pulse_width = $time - vpulse_start_time;
        end
    end

endmodule
