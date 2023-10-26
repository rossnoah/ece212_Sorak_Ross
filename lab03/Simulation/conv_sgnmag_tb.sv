`timescale 1ns / 1ps
module conv_sgnmag_tb;


    logic signed [16:0] C2tx10;
    logic signed [17:0] tx10;
    logic sign;
    
    conv_sgnmag DUV ( .C2tx10, .tx10, .sign );

    initial begin
        tx10 = 18'b0_0000_0000_0010_1000;
        #10;
        tx10 = 18'b1_0000_0000_0001_0000;
        #10;
        tx10 = 18'b1_0000_1111_1111_1111;
        #10;
        tx10 = 18'b1_0000_0000_0101_1000;
        #10;
        $stop;
    end

endmodule
