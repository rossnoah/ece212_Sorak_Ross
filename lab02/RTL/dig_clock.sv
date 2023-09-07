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
    
    logic enb, clr;
    period_enb #(.PERIOD_MS(1)) U_ENB(.clk, .rst, .clr, .enb_out(enb));

    
//    counter_rc_mod count_sec(.clk,.rst,.enb,);
    //counter_rc_mod count_min();
  //  counter_rc_mod count_hr();
    
    
    
    
//    module dbl_dabble(
//    input logic [7:0] b,
//    output logic [3:0] hundreds, tens, ones
//    );

    
    
     //   input logic clk, rst, enb,
   // output logic [5:0] q,
 //   output logic cy
    
endmodule
