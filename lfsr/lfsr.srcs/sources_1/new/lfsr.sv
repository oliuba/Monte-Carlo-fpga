`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 01:57:58 PM
// Design Name: 
// Module Name: lfsr
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
// Inspired by: https://simplefpga.blogspot.com/2013/02/random-number-generator-in-verilog-fpga.html
//              https://www.youtube.com/watch?v=ZIoTmcKPl4w
//////////////////////////////////////////////////////////////////////////////////


module lfsr #(
    parameter int OUT_WIDTH = 20
) (
    input  logic clk,
    input  logic reset,
    input  logic enable,
    
    input  logic load_seed,
    input  logic [OUT_WIDTH - 1 : 0] seed,
    
    output logic[OUT_WIDTH - 1 : 0] rnd
);

logic[OUT_WIDTH - 1 : 0] random = '0;

always_ff @(posedge clk)
begin
    if (reset)
        random <= 'd1;
    else if (enable)
        random <= {random[OUT_WIDTH - 1 : 0], random[2] ^ random[OUT_WIDTH - 1]};
end

always_comb rnd <= random;

endmodule
