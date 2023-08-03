`timescale 1ns / 1ps

module testbench;
    reg [9:0] x;
    reg [9:0] y;
    wire [11:0] address;

    // Instantiate the module
    PixelBlockAddress u1 (.x(x), .y(y), .address(address));

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, testbench);
        
        // Test all possible combinations of x and y
        for(x = 0; x < 640; x = x + 1) begin
            for(y = 0; y < 480; y = y + 1) begin
                #1; // Wait for 1 time unit to let the address calculation happen
            end
        end
        
        $finish; // End the simulation
    end

    // Monitor for changes in address and print a message when it changes
    always @(address) begin
        #1; // Wait for 1 time unit to ensure the new address is stable
        $display("At time %t, x = %d, y = %d, address = %h", $time, x, y, address);
    end

endmodule
