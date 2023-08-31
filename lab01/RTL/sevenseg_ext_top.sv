module  sevenseg_ext_n(input logic [6:0] data,
 output logic [6:0] segs_n,
 output logic dp_n,
  output logic selected);

assign selected = 1;
sevenseg_ext_n(data, segs_n, dp_n);




endmodule