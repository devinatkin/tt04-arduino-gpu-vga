`timescale 1ns/1ps

module vga_timing_gen (
    input wire clk,    // System clock
    input wire rst_n,  // Active-low reset signal
    output wire hs,    // Horizontal sync signal
    output wire vs,    // Vertical sync signal
    output wire [9:0] x,    // Current x position (column)
    output wire [9:0] y,    // Current y position (row)
    output wire active  // Active video signal
);

    // VGA standard timing parameters for 640x480 @ 60Hz
    localparam [9:0] H_SYNC_CYCLES = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_ACTIVE = 640;
    localparam H_FRONT_PORCH = 16;
    localparam [9:0] H_TOTAL = H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH;

    localparam [9:0] V_SYNC_CYCLES = 2;
    localparam V_BACK_PORCH = 33;
    localparam V_ACTIVE = 480;
    localparam V_FRONT_PORCH = 10;
    localparam [9:0] V_TOTAL = V_SYNC_CYCLES + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH;

    // Counters for current position
    wire [9:0] h_count = 0;
    wire [9:0] v_count = 0;

    wire hs_pwm, vs_pwm;

    pwm_module #(.bit_width(10))
    hs_pwm_gen(
        .clk(clk),
        .rst_n(rst_n),
        .duty(H_SYNC_CYCLES),
        .max_value(H_TOTAL),
        .pwm_out(hs_pwm),
        .counter(h_count)
    );

    pwm_module #(.bit_width(10))
    vs_pwm_gen(
        .clk(hs_pwm),   // VSync PWM generator is clocked by HSync
        .rst_n(rst_n),
        .duty(V_SYNC_CYCLES),
        .max_value(V_TOTAL),
        .pwm_out(vs_pwm),
        .counter(v_count)
    );



    // Assign sync signals
    assign hs = hs_pwm;
    assign vs = ~vs_pwm;

    // Determine if we're in the active video region
    assign active = (h_count >= (H_SYNC_CYCLES + H_BACK_PORCH)) &&
                    (h_count < (H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE)) &&
                    (v_count >= (V_SYNC_CYCLES + V_BACK_PORCH)) &&
                    (v_count < (V_SYNC_CYCLES + V_BACK_PORCH + V_ACTIVE));

    // Output current position
    assign x = h_count;
    assign y = v_count;

endmodule
