
module temp_sensor(
    input logic clk,
    input logic cf,
    input logic rst,
    input logic [12:0] tc,
    output logic [6:0] d5, d4, d3, d2, d1,d0);


    // logic [12:0] rounded;
    // logic [17:0] ctemp;
    // logic [17:0] ftemp;
    // logic [17:0] tout;
     logic [3:0] thousands, hundreds, tens, ones;
    logic [17:0] tx10;
    logic [16:0] C2tx10;
    logic [12:0] tempOut;
    logic sign;

    assign sign = tempOut[12];
        // assign sign = 1;

    tconvert (.tc,.cf,.tx10);
    conv_sgnmag(.tx10,.C2tx10 );
    round(.C2tx10, .tempOut);




    always_comb begin

      d2[6:4] = 3'b010;
      d1[3:0] = ones;
      d2[3:0] = tens;
      d3[3:0] = hundreds;
      d4[3:0] = thousands;

      d5[4] = sign;
      d5[6] = !sign || thousands==0;
      d4[4] = sign && thousands==0;
      d4[6] = (thousands==0 && !sign);
      d3[4] = sign && thousands==0  && hundreds==0;
      d3[6] = (hundreds==0&&thousands==0 && !sign);
      d0[3:0] = cf ? 4'd15 : 4'd12;

    end

  
  dbl_dabble_ext (.b(tempOut), .thousands, .hundreds, .tens, .ones);

endmodule
