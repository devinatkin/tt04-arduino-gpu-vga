`timescale 1ns/1ps

module tt_um_devinatkin_arduino_vga
(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Instantiate the 8-bit PWM module
    pwm_module #(8) pwm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .duty(ui_in),
        .max_value(uio_in),
        .pwm_out(uo_out[0])
    );

       assign uo_out[1] = 0;
       assign uo_out[2] = 0;
       assign uo_out[3] = 0;
       assign uo_out[4] = 0;
       assign uo_out[5] = 0;
       assign uo_out[6] = 0;
       assign uo_out[7] = 0;
       assign uio_oe[0] = 1;
       assign uio_oe[1] = 1;
       assign uio_oe[2] = 1;
       assign uio_oe[3] = 1;
       assign uio_oe[4] = 1;
       assign uio_oe[5] = 1;
       assign uio_oe[6] = 1;
       assign uio_oe[7] = 1;
    
endmodule
