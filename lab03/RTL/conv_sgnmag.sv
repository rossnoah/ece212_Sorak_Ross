module conv_sgnmag (
    input logic [17:0] tx10, 
    output logic [16:0] C2tx10
);


assign C2tx10 = tx10[17] ? -tx10:tx10;

    
endmodule