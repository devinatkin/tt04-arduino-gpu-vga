module tb_char_memory;

    reg clock;
    reg rst_n;
    reg write;
    reg [1:0] x;
    reg [2:0] y;
    reg data_in;
    wire data_out;

    reg [4:0][3:0] RESET_VALUE = {
        4'b1010,
        4'b0101,
        4'b1010,
        4'b1010,
        4'b0101
    };

    char_memory uut (
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

        // Unwrapped for loops to read from memory after reset
        y = 0; x = 0; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 0; x = 1; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 0; x = 2; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 0; x = 3; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        // Repeat for other values of y
        y = 1; x = 0; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 1; x = 1; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 1; x = 2; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 1; x = 3; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);

        y = 2; x = 0; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 2; x = 1; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 2; x = 2; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 2; x = 3; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);

        y = 3; x = 0; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 3; x = 1; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 3; x = 2; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 3; x = 3; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);

        y = 4; x = 0; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 4; x = 1; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 4; x = 2; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        y = 4; x = 3; #10; $display("Read from memory[%0d][%0d] = %0d", y, x, data_out);
        // Memory test: write some values and read them back
        write = 1; // Enable write mode
        x = 0; y = 0; data_in = 4'b1100; #10; // Write operation
        write = 0; #10; $display("Read after write from memory[%0d][%0d] = %0d", y, x, data_out); // Read operation
        
        // Repeat for other values of x and y as needed
        
        $finish; // Terminate the simulation
    end

endmodule
