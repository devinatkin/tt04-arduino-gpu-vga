`timescale 1ns/1ps

module tb_mux_36_1;

    reg [35:0] d;
    reg [5:0] sel;
    wire y;

    // Instantiate the DUT (Device Under Test)
    mux_36_1 u1 (
        .d(d),
        .sel(sel),
        .y(y)
    );

    // Testbench logic
    initial begin
        // Test all input combinations
        for(sel = 0; sel < 36; sel = sel + 1'b1) begin
            d = 36'hFFFFFFFFF;  // Set all inputs to 1 for test purposes
            #10;
            $display("For sel = %d, y = %b", sel, y);
            
            if (y != d[sel]) begin
                $display("ERROR: For sel = %d, Expected y = %b, but got y = %b", sel, d[sel], y);
            end

            // Change input value for next test
            d[sel] = ~d[sel];
            #10;
            $display("For sel = %d after toggling input, y = %b", sel, y);
            
            if (y != d[sel]) begin
                $display("ERROR: For sel = %d after toggling input, Expected y = %b, but got y = %b", sel, d[sel], y);
            end
        end
        
        $finish;
    end

endmodule
