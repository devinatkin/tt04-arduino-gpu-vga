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
    wire [9:0] x;
    wire [9:0] y;

    wire [9:0] xcoor;
    wire [9:0] ycoor;

    wire [31:0] configuration;
    wire [7:0] received_data;
    wire [11:0] rand_num;
    
    wire character_out;
    
    wire pong_pixel;

    wire hs;
    wire vs;

    vga_controller vga_ctrl_instance(
        .clk(clk),                 // System clock
        .rst_n(rst_n),             // Active-low reset signal
        .enable(ena),              // Active-high enable signal
        .hs(hs),                   // Horizontal sync signal
        .vs(vs),                   // Vertical sync signal
        .uo_out(uo_out),           // 6-bit output including sync signals
        .x(x),                     // Current x position (column)
        .y(y),                     // Current y position (row)
        .rand_num(rand_num),       // 6-bit random number input
        .configuration(configuration), // 32-bit configuration input
        .character_out(character_out), // Character output signal
        .pong_pixel(pong_pixel),   // Pong pixel signal
        .xcoor(xcoor),             // Calculated x coordinate
        .ycoor(ycoor)              // Calculated y coordinate
    );

    // Instantiate the character_output_mode module
    character_output_mode my_character_output_mode (
        .clk           (clk),           // Clock signal
        .rst_n         (rst_n),         // Reset signal (active low)
        .xcoor         (xcoor),         // X-coordinate (2 bits)
        .ycoor         (ycoor),         // Y-coordinate (9 bits)
        .configuration (configuration), // Configuration (24 bits)
        .character_out (character_out)  // Character output
    );

    // Instantiate the pong module
    pong pong1 (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .btn_up_raw(ui_in[4]),
        .btn_down_raw(ui_in[5]),
        .x(xcoor),
        .y(ycoor[8:0]),
        .pixel(pong_pixel)
    );

    // Instance of the SPI_Peripheral module
    SPI_Peripheral peripher_module (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .ss(ui_in[2]),
        .mosi(ui_in[0]),
        .miso(uio_out[0]),
        .sclk(ui_in[1]),
        .config_data(configuration),        // Data to be used by the device
        .recieved_data(received_data)        // Data recieved from the device
    );

    // Instantiate the config_manager
    config_manager config_m (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .data_in(received_data),
        .config_out(configuration)
    );


    // Instantiate the random number generator
    rand_generator rand_generator_mod (
        .clk(clk), 
        .reset_n(rst_n),
        .enable(ena), 
        .rand_num(rand_num)
    );



    // uio_in[0] corresponds to miso, which is the output of the SPI module
    assign uio_oe[0] = 1;
    
    assign uio_oe[1] = 0;
    assign uio_oe[2] = 0;
    assign uio_oe[3] = 0;
    assign uio_oe[4] = 0;
    assign uio_oe[5] = 0;
    assign uio_oe[6] = 0;
    assign uio_oe[7] = 0;
    
    assign uio_out[1] = 0;
    assign uio_out[2] = 0;
    assign uio_out[3] = 0;
    assign uio_out[4] = 0;
    assign uio_out[5] = 0;
    assign uio_out[6] = 0;
    assign uio_out[7] = 0;
    
    
endmodule
