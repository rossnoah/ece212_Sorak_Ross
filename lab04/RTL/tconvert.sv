module tconvert (
    input logic signed [12:0] tc, input logic cf,
    output logic signed [17:0] tx10
);
    
logic signed [17:0] tempC, tempF,i;
// logic [12:0] temporary;

// assign temporary = tc[12] ? ~tc+1 : tc;

mpy_10_s #(.W(13)) MPY10 (.a(tc),.y(tempC));
mpy_18_s #(.W(13)) MPY18 (.a(tc),.y(i));
assign tempF = i +  18'd5120;

assign tx10 = cf ? tempF : tempC;

endmodule