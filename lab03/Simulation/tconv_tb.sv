`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 01:35:31 PM
// Design Name: 
// Module Name: tconv_tb
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


module tconv_tb;

    logic signed [12:0] tc;
    logic cf;
    logic signed [17:0] tx10;
    
    tconvert DUV ( .tc, .cf, .tx10 );

    initial begin
        cf =0;
        tc = 13'b0_0000_0000_0000;
        #10;
        tc = 13'b0_0000_0001_0000;
        #10;
        tc = 13'b0_1111_1111_1111;
        #10;
        tc = 13'b1_0000_0000_0000;
        #10;
        $stop;
    end

endmodule
