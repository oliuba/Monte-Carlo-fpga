`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 01:17:07 PM
// Design Name: 
// Module Name: test
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

`define INPUT_WIDTH (3)

module test;
    logic[`INPUT_WIDTH - 1:0] a;
    logic[`INPUT_WIDTH - 1:0] b;
    
    logic aGreaterThanb;

comparator #(
    .INPUT_WIDTH(`INPUT_WIDTH)
) uut (
    .a(a),
    .b(b),
    .aGreaterThanb(aGreaterThanb)
);

initial begin
    a <= 010;
    b <= 100;
end

initial begin
 $display("aGreaterThanb");
 $monitor("%b", aGreaterThanb);
end  

endmodule
