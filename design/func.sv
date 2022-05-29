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
    parameter int WIDTH = 10
)(
    input logic clk,
    input logic enable_func,
    input logic[WIDTH-1:0] a,
    input logic[WIDTH-1:0] b,
    input logic[WIDTH-1:0] x,
    input logic[WIDTH-1:0] y,
    output logic[WIDTH*2:0] t
    );
    
always_ff @(posedge clk) begin
    if (enable_func)
        t <= a*x + b*y;
end

endmodule
