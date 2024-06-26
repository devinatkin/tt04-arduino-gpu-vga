`timescale 1ns/1ps

module tb_char_memory_array;
    reg clock;
    reg rst_n;
    reg write;
    reg [1:0] x;
    reg [2:0] y;
    reg data_in;
    wire [35:0] data_out;
    integer i;
    char_memory_array uut (
        .clock(clock),
        .rst_n(rst_n),
        .write(write),
        .x(x),
        .y(y),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        #5 clock = ~clock;
    end

    initial begin
        // Initialize signals
        clock = 0;
        rst_n = 0;
        write = 0;
        x = 0;
        y = 0;
        data_in = 0;

        #10;

        // Release reset
        rst_n = 1;

        #10;

        // Read operations from memory after reset for all 36 instances
        
        for(i = 0; i < 36; i = i + 1) begin
            y = i/3; // Dividing by 3 to get y value
            x = i%3; // Modulus operation to get x value
            #10;
            $display("Read from memory[%0d][%0d] = %b", y, x, data_out[i]);
        end

        // Memory test: write some values and read them back
        write = 1; // Enable write mode
        x = 1; y = 1; data_in = 1'b1; #10; // Write operation
        write = 0; #10; $display("Read after write from memory[%0d][%0d] = %b", y, x, data_out[3*y + x]); // Read operation

        // Repeat for other values of x and y as needed
        
        $finish; // Terminate the simulation
    end

endmodule
