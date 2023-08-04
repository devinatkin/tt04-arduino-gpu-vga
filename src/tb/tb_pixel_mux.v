`timescale 1ns / 1ps

module pixel_mux_tb;

    // Declare the signals
    reg [5:0] input0, input1, input2, input3;
    reg [1:0] select;
    wire [5:0] out;

    // Instantiate the pixel_mux module
    pixel_mux u1 (
        .input0(input0), 
        .input1(input1), 
        .input2(input2), 
        .input3(input3), 
        .select(select), 
        .out(out)
    );

    // Test sequence
    initial begin

        // Test 1
        input0 = 6'b000001;
        input1 = 6'b000010;
        input2 = 6'b000100;
        input3 = 6'b001000;
        select = 2'b00;
        #10; // Wait for 10 time units
        if(out !== input0) begin
            $display("Test 1 Failed: Expected %b, Received %b", input0, out);
        end

        // Test 2
        select = 2'b01;
        #10;
        if(out !== input1) begin
            $display("Test 2 Failed: Expected %b, Received %b", input1, out);
        end

        // Test 3
        select = 2'b10;
        #10;
        if(out !== input2) begin
            $display("Test 3 Failed: Expected %b, Received %b", input2, out);
        end

        // Test 4
        select = 2'b11;
        #10;
        if(out !== input3) begin
            $display("Test 4 Failed: Expected %b, Received %b", input3, out);
        end

        $display("Test Completed");
        $finish;
    end
endmodule
