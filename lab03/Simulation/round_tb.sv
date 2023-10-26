`timescale 1ns / 1ps

module round_tb;

    logic signed [16:0] C2tx10;
    logic signed [12:0] tempOut;
    
    round DUV ( .C2tx10, .tempOut );

    initial begin
        C2tx10 = 17'b0_0000_0000_0010_1000;
        #10;
        C2tx10 = 17'b0_0000_0000_0001_0000;
        #10;
        C2tx10 = 17'b0_0000_1111_1111_1111;
        #10;
        C2tx10 = 17'b0_0000_0000_0101_1000;
        #10;
        $stop;
    end

endmodule
