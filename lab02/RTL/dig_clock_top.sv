module dig_clock_top (
    input logic clk,
    input logic rst,
    input logic adv_hr,
    input logic adv_min,
    output logic [6:0] segs_n,
    output logic dp_n,
    output logic [7:0] an_n
);

    logic sclk; // sclk stands for "slow clock"
    clkdiv #(.DIVFREQ(1000)) U_DIV (.clk, .reset(0), .sclk);
    
    dig_clock(.clk(sclk), .rst, .adv_hr, .adv_min, .segs_n, .dp_n, .an_n);

    sevenseg_ctl ctl(.clk(clk), .d7(7'd7), .d6(7'd6), .d5(7'd5), .d4(7'd4), .d3(7'd3), .d2(7'd2), .d1(7'b1000000), .d0(7'd0), .segs_n(segs_n), .dp_n(dp_n), .an_n(an_n));


endmodule