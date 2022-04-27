`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 01:11:04 PM
// Design Name: 
// Module Name: comparator
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


module comparator#(
    parameter int INPUT_WIDTH = 3
) (
    input  logic[INPUT_WIDTH - 1:0] a,
    input  logic[INPUT_WIDTH - 1:0] b,
    output logic aGreaterThanb
    );

always_comb aGreaterThanb <= a > b;

endmodule
