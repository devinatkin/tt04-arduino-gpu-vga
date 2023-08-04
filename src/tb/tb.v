`default_nettype none
`timescale 1ns/1ps

module tb ();

    // define the output file
    integer outfile;

    initial begin
        // open the output file
        outfile = $fopen("output.txt", "w");
        
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // define the task for writing to the file
    task write_to_file;
        input integer sim_time;
        input hs;
        input vs;
        input [1:0] red;
        input [1:0] green;
        input [1:0] blue;
        begin
            $fwrite(outfile, "%0d ns: %b %b %b %b %b\n", sim_time, hs, vs, red, green, blue);
        end
    endtask

    reg  clk;
    initial clk = 0; // initialize clock signal to 0
    always #20 clk = ~clk; // generate 25 MHz clock signal

    reg  rst_n;
    initial begin
        rst_n = 0;  // assert reset
        #100;  // wait for 100 ns
        rst_n = 1;  // deassert reset
    end

    reg  ena;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    wire [6:0] segments = uo_out[6:0];
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    integer counter = 0;  // Add a counter
    always @(posedge clk) begin
        counter = counter + 1;  // Increment counter every clock cycle
        ui_in[7:6] = (counter / 100) % 4;  // Drive ui_in[7:6] based on counter, reset every 100 clock cycles and cycle from 0 to 3
    end

    // call the write_to_file task whenever uo_out changes
    always @(posedge clk) begin
        write_to_file($realtime, uo_out[0], uo_out[1], uo_out[3:2], uo_out[5:4], uo_out[7:6]);
    end

    tt_um_devinatkin_arduino_vga tt_um_devinatkin_arduino_vga (
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in      (ui_in),
        .uo_out     (uo_out),
        .uio_in     (uio_in),
        .uio_out    (uio_out),
        .uio_oe     (uio_oe),
        .ena        (ena),
        .clk        (clk),
        .rst_n      (rst_n)
    );

    // run the simulation for 1 second (1e9 ns)
    initial #1e8 $finish;

    // close the output file when simulation ends
    final begin
        $fclose(outfile);
    end

endmodule
