`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2022 12:10:16 PM
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
// Inspired by: https://simplefpga.blogspot.com/2013/02/random-number-generator-in-verilog-fpga.html
//              https://www.youtube.com/watch?v=ZIoTmcKPl4w
//////////////////////////////////////////////////////////////////////////////////

`define OUT_WIDTH (20)

module test;
    logic clk;
    logic reset;
    logic enable = '0, load_seed = '0;
    
    logic [`OUT_WIDTH-1 : 0] rnd, seed = '0;
    
lfsr #(
    .OUT_WIDTH(`OUT_WIDTH)
) uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .load_seed(load_seed),
    .seed(seed),
    .rnd(rnd)
 );
 
initial begin
    clk = 0;
    forever
        #50 clk = ~clk;
end
  
initial begin
  
  reset = 0;

  #100;
      reset = 1;
  #200;
      reset = 0;

    @(posedge clk) seed <= $random();
    @(posedge clk) load_seed <= '1;
    @(posedge clk) load_seed <= '0;
    
    repeat (4) @(posedge clk);
    
    @(posedge clk) enable <= '1;
    @(posedge clk) enable <= '0;

end
 
initial begin
 $display("clk rnd");
 $monitor("%b,%b", clk, rnd);
end      
endmodule
