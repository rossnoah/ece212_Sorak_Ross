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
    input logic toggle,
    input logic rst,
    input logic adv_hr,
    input logic adv_min,
    output logic [6:0] secondOne, secondTen, minuteOne, minuteTen, hourOne, hourTen,ampmOne
    );
    
  logic [5:0] seconds, minutes, hours, hoursMapped, ampm;
  logic enb, clr, minuteEnb, hourEnb, amEnb;

  assign hoursMapped = !toggle ? ( (hours == 0) ? 12 : hours) :( ampm==1 ? hours + 12 : hours);


  logic adv_hr_db, adv_min_db, adv_hr_pulsed, adv_min_pulsed;

  debounce hr (.clk, .rst, .pb(adv_hr), .pb_debounced(adv_hr_db));
  debounce min (.clk, .rst, .pb(adv_min), .pb_debounced(adv_min_db));

  single_pulser hr_pulse (.clk, .din(adv_hr_db), .d_pulse(adv_hr_pulsed));
  single_pulser min_pulse (.clk, .din(adv_min_db), .d_pulse(adv_min_pulsed));



  period_enb #(.PERIOD_MS(1000)) U_ENB(.clk, .rst, .clr, .enb_out(enb));

  counter_rc_mod #(.MOD(60)) COUNT_SEC(.clk,.rst,.enb,.q(seconds),.cy(minuteEnb));
  counter_rc_mod #(.MOD(60)) COUNT_MIN(.clk,.rst,.enb(minuteEnb||adv_min_pulsed),.q(minutes),.cy(hourEnb));
  counter_rc_mod #(.MOD(12)) COUNT_HR(.clk,.rst,.enb(hourEnb||adv_hr_pulsed),.q(hours),.cy(amEnb));
  counter_rc_mod #(.MOD(2)) COUNT_AM(.clk,.rst,.enb(amEnb),.q(ampm));


  dbl_dabble secondOut(.b(seconds),.ones(secondOne[3:0]),.tens(secondTen[3:0]));
  dbl_dabble minuteOut(.b(minutes),.ones(minuteOne[3:0]),.tens(minuteTen[3:0]));
  dbl_dabble hourOut(.b(hoursMapped),.ones(hourOne[3:0]),.tens(hourTen[3:0]));

  assign ampmOne[3:0] = ampm+10;
  assign ampmOne[6:4] = !toggle ? 3'b000 : 3'b100;
  assign secondOne[6:4] = 3'b000;
  assign secondTen[6:4] = 3'b000;
  assign minuteOne[6:4] = 3'b010;
  assign minuteTen[6:4] = 3'b000;
  assign hourOne[6:4] = 3'b010;
  assign hourTen[5:4] = 2'b00;
  assign hourTen[6] = hourTen[3:0] ||toggle ? 1'b0 : 1'b1 ;
    
endmodule
