`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 04:56:33 PM
// Design Name: 
// Module Name: function
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


module func #(
    parameter int WIDTH = 10,
    parameter int a = 2, // only non-negative
    parameter int b = 3 // only non-negative
)(
    input logic[WIDTH] x,
    input logic[WIDTH] y,
    output logic[WIDTH + a + b] t
    );
    
always_comb t <= a*x + b*y;

endmodule
