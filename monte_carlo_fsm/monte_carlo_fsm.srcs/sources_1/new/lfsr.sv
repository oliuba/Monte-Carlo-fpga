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
// Taps taken from: https://www.eetimes.com/tutorial-linear-feedback-shift-registers-lfsrs-part-1/
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
    if (OUT_WIDTH == 5 || OUT_WIDTH == 11 || OUT_WIDTH == 21 || OUT_WIDTH == 29)     
        tap <= random[1] ^ random[OUT_WIDTH - 1];                                         
    if (OUT_WIDTH == 8)                                                  
        tap <= random[1] ^ random[2] ^ random[3] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 9)                     
        tap <= random[3] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 10 || OUT_WIDTH == 20 || OUT_WIDTH == 17 || OUT_WIDTH == 25 || OUT_WIDTH == 28 || OUT_WIDTH == 31)
        tap <= random[2] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 12 || OUT_WIDTH == 30)
        tap <= random[0] ^ random[3] ^ random[5] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 13 || OUT_WIDTH == 24)
        tap <= random[0] ^ random[2] ^ random[3] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 14)                                            
        tap <= random[0] ^ random[2] ^ random[4] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 16)
        tap <= random[1] ^ random[2] ^ random[4] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 18)
        tap <= random[6] ^ random[OUT_WIDTH - 1];                     
    else if (OUT_WIDTH == 19 || OUT_WIDTH == 27)                                            
        tap <= random[0] ^ random[1] ^ random[4] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 23)
        tap <= random[4] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 26)                                            
        tap <= random[0] ^ random[1] ^ random[5] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 32)                                            
        tap <= random[1] ^ random[5] ^ random[6] ^ random[OUT_WIDTH - 1];
    else if (OUT_WIDTH == 2 || OUT_WIDTH == 3 || OUT_WIDTH == 4 || OUT_WIDTH == 6 || OUT_WIDTH == 7 || OUT_WIDTH == 15 || OUT_WIDTH == 22)
        tap <= random[0] ^ random[OUT_WIDTH - 1];

end

always_comb rnd <= random;

endmodule
