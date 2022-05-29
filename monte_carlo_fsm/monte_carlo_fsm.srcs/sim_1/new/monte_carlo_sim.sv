`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2022 03:30:52 PM
// Design Name: 
// Module Name: monte_carlo_sim
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

`define CLK_PERIOD          (10ns)
`define WIDTH               (16)
`define a                   (3)
`define b                   (4)

module monte_carlo_sim;
    logic rst = '0;
    logic [`WIDTH-1:0] num_of_iterations = '0;
    logic clk = '0;
    logic [`WIDTH-1:0] seed_1 = '0;
    logic [`WIDTH-1:0] seed_2 = '0;
    logic [`WIDTH+`b-1:0] seed_3 = '0;

    logic [`WIDTH-1:0] result = '1;
    
fsm_montecarlo #(
    .WIDTH(`WIDTH),
    .a(`a),
    .b(`b)
) monte_carlo_inst (
    .rst(rst),
    .num_of_iterations(num_of_iterations),
    .clk(clk),
    .seed_1(seed_1),
    .seed_2(seed_2),
    .seed_3(seed_3),

    .result(result)
 );

//Generate clock
always #(`CLK_PERIOD/2) clk <= ~clk;
  
initial begin
      
    @(posedge clk) num_of_iterations <= 10000;
    
    @(posedge clk) seed_1 <= 20;
    @(posedge clk) seed_2 <= 10;
    @(posedge clk) seed_3 <= 5;

    @(posedge clk) rst <= '1;
    @(posedge clk) rst <= '0;
    
//    repeat (4) @(posedge clk);

    #10000us;
    $finish();
end
 
initial begin
 $display("clk result");
 $monitor("%b,%b", clk, result);
end      
endmodule
