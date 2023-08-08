module tb_state_machine();

    reg clk;
    reg rst_n;
    reg [9:0] repeat_count;
    reg [5:0] value;
    reg enable;
    wire [5:0] output_value;
    wire done;

    // Instantiate the state machine
    pixel_state_machine u1 (
        .clk(clk),
        .rst_n(rst_n),
        .repeat_count(repeat_count),
        .value(value),
        .enable(enable),
        .output_value(output_value),
        .done(done)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initial conditions
        clk = 0;
        rst_n = 0;
        repeat_count = 0;
        value = 0;
        enable = 0;

        // Reset the system
        #10 rst_n = 1;

        // Test case 1: Test with enable = 0
        #10 repeat_count = 8;
        value = 6'b101010;
        #10 enable = 0;
        #50;

        // Test case 2: Test with repeat_count = 0
        #10 enable = 1;
        repeat_count = 0;
        #50;

        // Test case 3: Test with repeat_count = 8
        #10 repeat_count = 8;
        #80; // Wait for done signal

        // Test case 4: Test with maximum repeat_count = 640
        #10 repeat_count = 640;
        #2000; // Wait long enough to complete the repetitions

        // Finish simulation
        $finish;
    end

    // Monitoring process
    initial begin
        $monitor($time, " repeat_count=%d value=%b enable=%b output_value=%b done=%b", repeat_count, value, enable, output_value, done);
    end

endmodule
