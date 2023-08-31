module  sevenseg_ext_top(input logic [6:0] data,
 output logic [6:0] segs_n,
 output logic dp_n,
  output logic dis);

assign dis = 1;
sevenseg_ext_n sevseg(data, segs_n, dp_n);




endmodule