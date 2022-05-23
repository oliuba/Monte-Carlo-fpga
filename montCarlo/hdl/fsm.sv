`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2022 03:02:45 PM
// Design Name: 
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_montecarlo #(
    parameter int WIDTH = 10,
    parameter int a = 2,
    parameter int b = 3
) (
    input logic [WIDTH-1:0] num_of_iterations,
    input logic [WIDTH-1:0] x_begin,
    input logic [WIDTH-1:0] x_end,
    input logic [WIDTH-1:0] y_begin,
    input logic [WIDTH-1:0] y_end,

    output logic [WIDTH-1:0] result

);

logic [WIDTH-1:0] points_counter;
logic [WIDTH-1:0] iterations_counter;
logic [WIDTH-1:0] program_result;

logic iter_comp_res;

logic [WIDTH-1:0] x_rand;
logic [WIDTH-1:0] y_rand;
logic [2*WIDTH:0] t_rand;

logic [WIDTH-1:0] x_rand_program;
logic [WIDTH-1:0] y_rand_program;
logic [2*WIDTH:0] t_rand_program;

logic [2*WIDTH:0] t_calculated;
logic [2*WIDTH:0] t_calculated_program;

logic funcs_comp_res;

lfsr #(
    .OUT_WIDTH(WIDTH)
) rng_x (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .load_seed(load_seed),
    .seed(seed),
    .rnd(x_rand)
 );
 
lfsr #(
    .OUT_WIDTH(WIDTH)
) rng_y (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .load_seed(load_seed),
    .seed(seed),
    .rnd(y_rand)
 );
 
lfsr #(
    .OUT_WIDTH(WIDTH)
) rng_t (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .load_seed(load_seed),
    .seed(seed),
    .rnd(t_rand)
 );
 
comparator #(
    .INPUT_WIDTH(WIDTH)
) comparator_iterations (
    .a(num_of_iterations),
    .b(iterations_counter),
    .aGreaterThanb(iter_comp_res)
);

comparator #(
    .INPUT_WIDTH(2*WIDTH+1)
) comparator_funcs (
    .a(t_calculated_program),
    .b(t_rand_program),
    .aGreaterThanb(funcs_comp_res)
);

func #(
    .WIDTH(WIDTH),
    .a(a),
    .b(b)
) func_inst (
    .x(x_rand_program),
    .y(y_rand_program),
    .t(t_calculated)
);



// define fsm states
typedef enum {
    IDLE, CHECK_COUNTER, RANDOM, CALCULATE_FUNCTION, COMPARE, INCREASE_POINTS_COUNTER, INCREASE_COUNTER, CALCULATE_RESULT, FINISH
} fsm_t;
    
    fsm_t state = IDLE;

    // FSM process
    always_ff @( posedge clk ) begin
        if (rst) begin
            points_counter <= '0;
            iterations_counter <= '0;
            program_result <= '0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    state <= CHECK_COUNTER;
                end

                CHECK_COUNTER: begin
                    // можливо замінити на компаратор
                    if (iter_comp_res) begin
                        state <= RANDOM;
                    end
                    else begin
                        state <= CALCULATE_RESULT;
                    end
                end

                RANDOM: begin
                    // дженерейт рандом нумбер
                    x_rand_program <= x_rand;
                    y_rand_program <= y_rand;
                    t_rand_program <= t_rand;
                    state <= CALCULATE_FUNCTION;
                end

                CALCULATE_FUNCTION: begin
                    // тут треба порахувати функцію
                    t_calculated_program <= t_calculated;
                    state <= COMPARE;
                end

                COMPARE: begin
                    // порівняти функцію і згенероване число
                    if (funcs_comp_res) begin
                        state <= INCREASE_POINTS_COUNTER;
                    end 
                    else begin
                        state <= INCREASE_COUNTER;
                    end 
                end

                INCREASE_POINTS_COUNTER: begin
                    points_counter <= points_counter + 1;
                    state <= INCREASE_COUNTER;
                end

                INCREASE_COUNTER: begin
                    iterations_counter <= iterations_counter + 1;
                    state <= CHECK_COUNTER;
                end

                CALCULATE_RESULT: begin
                    program_result <= points_counter;
//                  program_result = points_counter * (x_end - x_begin) * (y_end - y_begin) / num_of_iterations;

                    state <= FINISH; 
                end
                
                FINISH: begin
                    state <= FINISH;
                end
            endcase
        end
    end

always_comb result <= program_result;

endmodule
