module pixel_state_machine(
    input clk,
    input rst_n,
    input [9:0] repeat_count, // 10-bit input for the number of times to repeat
    input [5:0] value,        // 6-bit value to repeat
    input enable,             // Enable signal
    output reg [5:0] output_value, // 6-bit output value
    output reg done           // Done signal
);

    typedef enum {INIT, COUNTING, DONE} state_t;
    reg [9:0] counter; // Counter to keep track of repetitions
    reg state_t state; // Current state

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= INIT;
            counter <= 0;
            done <= 0;
        end else begin
            case(state)
                INIT: begin
                    done <= 0;
                    if (enable) begin
                        counter <= repeat_count;
                        state <= (counter > 0) ? COUNTING : DONE;
                    end
                end

                COUNTING: begin
                    if (counter > 0) begin
                        output_value <= value;
                        counter <= counter - 1;
                    end else begin
                        state <= DONE;
                    end
                end

                DONE: begin
                    done <= 1;
                    state <= INIT;
                end
            endcase
        end
    end

endmodule
