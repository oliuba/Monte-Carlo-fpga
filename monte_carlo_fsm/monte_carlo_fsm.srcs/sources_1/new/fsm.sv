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
        parameter int WIDTH = 4,
        parameter int a = 1,
        parameter int b = 1 // should be greater or equal to a by design
    ) (
        input logic rst,
        input logic [WIDTH-1:0] num_of_iterations,
//        input logic [WIDTH-1:0] x_begin,
//        input logic [WIDTH-1:0] x_end,
//        input logic [WIDTH-1:0] y_begin,
//        input logic [WIDTH-1:0] y_end,
        
        input logic clk,
        input logic [WIDTH-1:0] seed_1,
        input logic [WIDTH-1:0] seed_2,
        input logic [WIDTH+b-1:0] seed_3,

        output logic [WIDTH-1:0] result

    );

    logic [WIDTH-1:0] points_counter;
    logic [WIDTH-1:0] iterations_counter;
    logic [WIDTH-1:0] program_result;

    logic [WIDTH-1:0] x_rand = '0;
    logic [WIDTH-1:0] y_rand = '0;
    logic [WIDTH+b-1:0] t_rand = '0;

    logic [WIDTH+b-1:0] t_calculated = '0;
    
    logic enable_func = '0;
    logic enable_rand = '0;
    logic load_seed = '0;

    lfsr #(
             .OUT_WIDTH(WIDTH)
         ) rng_x (
             .clk(clk),
             .enable(enable_rand),
             .load_seed(load_seed),
             .seed(seed_1),
             .rnd(x_rand)
         );
        

    lfsr #(
             .OUT_WIDTH(WIDTH)
         ) rng_y (
             .clk(clk),
             .enable(enable_rand),
             .load_seed(load_seed),
             .seed(seed_2),
             .rnd(y_rand)
         );

    lfsr #(
             .OUT_WIDTH(WIDTH+b)
         ) rng_t (
             .clk(clk),
             .enable(enable_rand),
             .load_seed(load_seed),
             .seed(seed_3),
             .rnd(t_rand)
         );
         
    func #(
             .WIDTH(WIDTH)
         ) func_inst (
             .clk(clk),
             .enable_func(enable_func),
             .a(a),
             .b(b),
             .x(x_rand),
             .y(y_rand),
             .t(t_calculated)
         );

    comparator #(
                 .INPUT_WIDTH(WIDTH+b-1)
               ) comparator_funcs (
                   .clk(clk),
                   .a(t_calculated),
                   .b(t_rand),
                   .aGreaterThanb(funcs_comp_res)
               );




    // define fsm states
    typedef enum {
                IDLE, ENABLE, UNLOAD, CHECK_COUNTER, 
                RANDOM, CALCULATE_FUNCTION, COMPARE, INCREASE_POINTS_COUNTER, 
                INCREASE_COUNTER, CALCULATE_RESULT, FINISH
            } fsm_t;

    fsm_t state = IDLE;

    // FSM process
    always_ff @(posedge clk) begin
        if (rst) begin
            points_counter <= '0;
            iterations_counter <= '0;
            program_result <= '0;
            state <= IDLE;
        end
        else begin
            case (state)
                IDLE: begin
                    state <= ENABLE;
                end

                ENABLE: begin
                    enable_rand <= '1;
                    load_seed <= '1;
                    state <= UNLOAD;
                end

                UNLOAD: begin
                    load_seed <= '0;
                    enable_rand <= '0;
                    state <= CHECK_COUNTER;
                end

                CHECK_COUNTER: begin
                    if (iterations_counter < num_of_iterations) begin
                        state <= RANDOM;
                    end
                    else begin
                        state <= CALCULATE_RESULT;
                    end
                end

                RANDOM: begin
                    // дженерейт рандом нумбер
                    enable_rand <= '1;
                    state <= CALCULATE_FUNCTION;
                end

                CALCULATE_FUNCTION: begin
                    // тут треба порахувати функцію
                    enable_rand <= '0;
                    enable_func <= '1;
                    state <= COMPARE;
                end

                COMPARE: begin
                    // порівняти функцію і згенероване число
                    enable_func <= '0;
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