module round (
    input logic [16:0] C2tx10,
    output logic [12:0] tempOut
);
    
assign tempOut =  C2tx10[3] ? C2tx10[16:4] +1 : C2tx10[16:4];

endmodule