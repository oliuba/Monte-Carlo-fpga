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
    parameter int OUT_WIDTH = 4
) (
    input  logic clk,
    input  logic enable,
    
    input  logic load_seed,
    input  logic [OUT_WIDTH - 1 : 0] seed,
    
    output logic[OUT_WIDTH - 1 : 0] rnd
);

logic[OUT_WIDTH - 1 : 0] random = '0;
logic tap = '0;

always_ff @(posedge clk)
begin
    if (enable) begin
        if (load_seed) 
            random <= seed;
        else
            random <= {random[OUT_WIDTH - 2 : 0], tap};   
    end
end

always_comb begin
    if (OUT_WIDTH == 8)
        tap <= random[1] ^ random[2] ^ random[3] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 10 || OUT_WIDTH == 20)
        tap <= random[2] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 11)
        tap <= random[1] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 4)
        tap <= random[0] ^ random[OUT_WIDTH - 1];

end

always_comb rnd <= random;

endmodule
