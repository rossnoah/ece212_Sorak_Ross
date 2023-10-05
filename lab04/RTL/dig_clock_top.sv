module dig_clock_top (
    input logic clk,
    input logic rst,
    input logic adv_hr,
    input logic adv_min,
    input logic toggle,
    output logic [6:0] segs_n,
    output logic dp_n,
    output logic [7:0] an_n
);

    logic [6:0] secondOne, secondTen, minuteOne, minuteTen, hourOne, hourTen,ampmOne  ;

    
    dig_clock(.clk(clk),.toggle, .rst, .adv_hr, .adv_min, .secondOne, .secondTen, .minuteOne, .minuteTen, .hourOne, .hourTen, .ampmOne);
    
    sevenseg_ctl ctl(.clk(clk), .d7(hourTen), .d6(hourOne), .d5(minuteTen), .d4(minuteOne), .d3(secondTen), .d2(secondOne), .d1(7'b1000000), .d0(ampmOne), .segs_n(segs_n), .dp_n(dp_n), .an_n(an_n));


endmodule