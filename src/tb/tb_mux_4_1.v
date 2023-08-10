module tb_mux_4_1;

    // Declare signals
    reg [1:0] sel;
    reg in0, in1, in2, in3;
    wire out;

    // Instantiate the 4_1 mux
    mux_4_1 uut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        in0 = 1'b0;
        in1 = 1'b1;
        in2 = 1'b0;
        in3 = 1'b1;

        // Test each select line
        sel = 2'b00; #10; if (out !== in0) begin $display("Test failed for sel = 2'b00"); $finish; end
        sel = 2'b01; #10; if (out !== in1) begin $display("Test failed for sel = 2'b01"); $finish; end
        sel = 2'b10; #10; if (out !== in2) begin $display("Test failed for sel = 2'b10"); $finish; end
        sel = 2'b11; #10; if (out !== in3) begin $display("Test failed for sel = 2'b11"); $finish; end

        $finish; // End the simulation
    end

endmodule
