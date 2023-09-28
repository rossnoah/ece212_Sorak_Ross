module tconvert (
    input logic [12:0] tc, input logic cf,
    output logic [17:0] tx10
);
    
logic [17:0] tempC, tempF,i;

mpy_10_s #(.W(14))(.a(tc),.y(tempC));
mpy_18_s #(.W(14))(.a(tc),.y(i));
assign tempF = i +  {14'd320,4'b0000};

assign tx10 = cf ? tempF : tempC;

endmodule