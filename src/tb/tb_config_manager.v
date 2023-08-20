`timescale 1ns/1ps

module tb_config_manager;

    // Parameters
    reg clk;
    reg rst_n;
    reg [7:0] data_in;
    wire [31:0] config_out;

    // Instantiate the config_manager
    config_manager uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .config_out(config_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 time unit period, producing a 50 MHz clock
    end

    // Stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        data_in = 8'h00;
        
        // Apply reset
        #10 rst_n = 1;

        // Write to all 8 positions in the configuration
        data_in = 8'h00; #10;
        data_in = 8'h11; #10;
        data_in = 8'h22; #10;
        data_in = 8'h33; #10;
        data_in = 8'h44; #10;
        data_in = 8'h55; #10;
        data_in = 8'h66; #10;
        data_in = 8'h77; #10;

        // Print the final configuration
        #10 $display("Final configuration: %h", config_out);

        // Finish simulation
        $finish;
    end

endmodule
