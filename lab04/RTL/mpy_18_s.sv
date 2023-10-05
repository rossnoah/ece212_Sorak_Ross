//-----------------------------------------------------------------------------
// Module Name   : mpy_10
// Project       : RTL Hardware Design and Verification using SystemVerilog
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Feb 2020
//-----------------------------------------------------------------------------
// Description   : Multiply a by constant (10) by shifting & adding
//                 (for signed two's complement numbers)
//-----------------------------------------------------------------------------

module mpy_18_s #(parameter W=8) (
	input logic signed [W-1:0] a,
	output logic signed [W+5-1:0] y
	)
	;
   logic [W+5-1:0] ax16;
   logic [W+5-1:0] ax2;



   assign ax16 = a << 4;
   assign ax2 = a << 1;

   assign y = ax16 + ax2;

endmodule: mpy_18_s