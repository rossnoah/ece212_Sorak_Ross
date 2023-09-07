`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 01:36:19 PM
// Design Name: 
// Module Name: dig_clock
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


module dig_clock(
    input logic clk,
    input logic rst,
    input logic adv_hr,
    input logic adv_min,
    output logic [6:0] segs_n,
    output logic dp_n,
    output logic [7:0] an_n
    );

    sevenseg_ctl cvbnmld(.clk(clk), .d7(7'd7), .d6(7'd6), .d5(7'd5), .d4(7'd4), .d3(7'd3), .d2(7'd2), .d1(7'd1), .d0(7'd0), .segs_n(segs_n), .dp_n(dp_n), .an_n(an_n));
endmodule
