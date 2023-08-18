module tb_debounce();

    reg clk;               // Clock signal
    reg rst_n;             // Active-low asynchronous reset
    reg button_in;         // Raw button input
    wire button_out;       // Debounced button output

    // Instantiate the debounce module
    debounce u1 (
        .clk(clk),
        .rst_n(rst_n),
        .button_in(button_in),
        .button_out(button_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Assuming a 10 ns clock period, change if needed
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        button_in = 0;
        
        // Reset
        #10 rst_n = 1;
        
        // Simulate a button press with bouncing
        #15 button_in = 1;
        #3 button_in = 0;
        #3 button_in = 1;
        #3 button_in = 0;
        #3 button_in = 1;
        #100; // Wait to allow debounce logic to process
        
        // Simulate a button release with bouncing
        #15 button_in = 0;
        #3 button_in = 1;
        #3 button_in = 0;
        #3 button_in = 1;
        #3 button_in = 0;
        #100; // Wait to allow debounce logic to process

        // Finish the simulation
        $finish;
    end

endmodule
