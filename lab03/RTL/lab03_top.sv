module lab03_top(
 input logic clk, rst, cf, sw15,sw14,sw13,s12,s11,s10,sw9,sw8,sw7,sw6,sw5,sw4,sw3,
 output logic [7:0] an_n,
 output logic [6:0] segs_n,
 output logic dp_n,
 inout tmp_scl, // use inout only – no logic
 inout tmp_sda // use inout only – no logic
 );
 logic tmp_rdy, tmp_err; // unused temp controller outputs
 // 13-bit two's complement result with 4-bit fractional part
 logic [12:0] tc;





 // instantiate the VHDL temperature sensor controller
 TempSensorCtl U_TSCTL (
 .TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(tc),
 .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk),
 .SRST_I(rst)
 );

logic [6:0] secondOne, secondTen, minuteOne, minuteTen, hourOne, hourTen,ampmOne;
logic[6:0] d0, d1, d2, d3, d4, d5;


temp_sensor ts(.clk(clk), .cf, .tc, .rst, .d5, .d4, .d3, .d2, .d1, .d0);
// temp_sensor ts(.clk(clk), .cf, .tc({0,00010000,4'b0000}), .rst, .d5, .d4, .d3, .d2, .d1, .d0);
    
sevenseg_ctl ctl(.clk(clk), .d7(7'b1000000), .d6(7'b1000000), .d5, .d4, .d3, .d2, .d1, .d0, .segs_n(segs_n), .dp_n(dp_n), .an_n(an_n));


 // add additional signals & instantiations here
endmodule