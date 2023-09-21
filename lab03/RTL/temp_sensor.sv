
module temp_sensor(
    input logic clk,
    input logic FC,
    input logic rst,
    input logic [12:0] temp,
    output logic [6:0] d5, d4, d3, d2, d1,d0);


    logic [12:0] rounded;
    logic [17:0] ctemp;
    logic [17:0] ftemp;
    logic [17:0] tout;
    logic [3:0] thousands, hundreds, tens, ones;
    logic sign;

    logic [16:0] utemp;
    assign utemp = temp[11:0];
    assign sign = tout[17];


    assign rounded = {tout[17:4], (tout[2] ? tout[3]+1 : tout[3])};
    // assign rounded = 13'd1234;    
    // assign sign = temp<0;

    assign tout = FC ? ftemp : ctemp;

    // mpy_10_s(.a(temp[11:0]),.y(ctemp));
 
    mpy_10_s #(.W(18))(.a(temp[]),.y(ctemp));

    always_comb begin

      d2[6:4] = 3'b010;
      d1[3:0] = ones;
      d2[3:0] = tens;
      d3[3:0] = hundreds;
      d4[3:0] = thousands;
      d5[5] = sign;
    d0[3:0] = FC ? 4'd15 : 4'd12;

    end
  dbl_dabble_ext (.b(13'd1234), .thousands, .hundreds, .tens, .ones);

endmodule
