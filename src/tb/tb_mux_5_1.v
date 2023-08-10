module tb_mux_5_1;
  
    // Declare signals
    reg [2:0] sel;
    reg [3:0] in0, in1, in2, in3, in4;
    wire [3:0] out;

    // Instantiate the 5_1 mux
    mux_5_1 uut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .out(out)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        in0 = 4'b0001;
        in1 = 4'b0010;
        in2 = 4'b0100;
        in3 = 4'b1000;
        in4 = 4'b1001;

        // Test each select line
        sel = 3'b000; #10; if (out !== in0) begin $display("Test failed for sel = 3'b000"); $finish; end
        sel = 3'b001; #10; if (out !== in1) begin $display("Test failed for sel = 3'b001"); $finish; end
        sel = 3'b010; #10; if (out !== in2) begin $display("Test failed for sel = 3'b010"); $finish; end
        sel = 3'b011; #10; if (out !== in3) begin $display("Test failed for sel = 3'b011"); $finish; end
        sel = 3'b100; #10; if (out !== in4) begin $display("Test failed for sel = 3'b100"); $finish; end

        // Test the default case
        sel = 3'b101; #10; if (out !== 4'b0000) begin $display("Test failed for sel = 3'b101"); $finish; end

        $finish; // End the simulation
    end

endmodule
