module  sevenseg_ext_top(input logic [6:0] data,
 output logic [6:0] segs_n,
 output logic dp_n,
  output logic [7:0] an_n);

assign an_n = 8'b11111110;
sevenseg_ext_n sevseg(data, segs_n, dp_n);




endmodule