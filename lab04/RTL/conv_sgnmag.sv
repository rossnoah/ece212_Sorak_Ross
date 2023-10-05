module conv_sgnmag (
    input logic signed [17:0] tx10, 
    output logic [16:0] C2tx10,
    output logic sign
);


//convert sign magnitude to 2's complement
// assign C2tx10 = tx10[17] ? -tx10[16:0] : tx10[16:0];
assign sign = tx10[17];

assign C2tx10 = sign ? -tx10[16:0] : tx10[16:0];

//assign C2tx10 = sign ? tx10[16:0] : -tx10[16:0];

// assign C2tx10 ={0,tx10[15:0]};


// assign C2tx10 =-tx10[16:0];


endmodule