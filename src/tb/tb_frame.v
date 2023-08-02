`timescale 1ns/1ps


module MemoryArray640x480_tb;

    // Declare signals
    reg clk;
    reg rst_n;
    reg [9:0] addr;
    reg write_en;
    reg [5:0] data_in;
    wire [5:0] data_out;

    // Instantiate MemoryArray640x480
    MemoryArray640x480 memory_array (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .write_en(write_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        addr = 0;
        write_en = 0;
        data_in = 0;

        // Specify VCD dump file
        $dumpfile("memory.vcd");

        // Start dumping the variable changes
        $dumpvars(0, MemoryArray640x480_tb);

        #10 rst_n = 1; // De-assert reset
        #10;

        // Write to each memory location and read from it
        for (addr = 0; addr < 1023; addr = addr + 1) begin
            // Write to memory
            write_en = 1; 
            data_in = addr[5:0]; // Write the lower 6 bits of the address as data
            #10;
            
            // Read from memory
            write_en = 0;
            #10;

            // Check read data
            if (data_out != addr[5:0]) 
                $display("Test Failed at address %d. Expected: %b, Got: %b", addr, addr[5:0], data_out);
            else 
                $display("Test Passed at address %d. Expected: %b, Got: %b", addr, addr[5:0], data_out);
        end

        #10 $finish; // Stop the simulation
    end

endmodule
