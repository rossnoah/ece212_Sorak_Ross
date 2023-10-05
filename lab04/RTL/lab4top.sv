module lab4top (
 input logic clk, rst, 
 input logic adv_hr,
 input logic adv_min,
 input logic [15:0] sw,
 output logic [7:0] an_n,
 output logic [6:0] segs_n,
 output logic dp_n,
 inout tmp_scl, // use inout only – no logic
 inout tmp_sda // use inout only – no logic
);


logic [2:0] counter;
logic [1:0] mode;

assign mode = sw[15:14];

logic enb;
logic cf;


logic [6:0] time_segs_n;
logic [7:0] time_an_n;
logic time_dp_n;

logic [6:0] temp_segs_n;
logic [7:0] temp_an_n;
logic temp_dp_n;

lab03_top LAB3(.clk, .rst, .cf,.tmp_scl,.tmp_sda,.an_n(temp_an_n),.segs_n(temp_segs_n),.dp_n(temp_dp_n));
dig_clock_top LAB2(.clk, .rst,.adv_hr,.adv_min,.an_n(time_an_n),.segs_n(time_segs_n),.dp_n(time_dp_n));

period_enb #(.PERIOD_MS(2000)) U_ENB(.clk, .rst, .enb_out(enb));
//counter_rc_mod #(.MOD(6)) COUNT_STATE(.clk,.rst,.enb,.q(counter));



//always_comb begin
    
//    if(mode == 2'b00)begin cf = 0; end
//    else if (mode == 2'b01) begin cf = 1; end
//    else if (mode == 2'b10) begin cf = (counter == 1 || counter == 3 || counter == 5); end
//    else if (mode == 2'b11) begin cf = (counter == 2 || counter == 5); end
    
////        an_n = time_an_n;
////        segs_n = time_segs_n;
////        dp_n = time_dp_n;
    
    
    
//    if(mode == 2'b00) begin
        
//        an_n = time_an_n;
//        segs_n = time_segs_n;
//        dp_n = time_dp_n;

//    end
//    else if (mode == 2'b01) begin
        
//           if(counter==0||counter==2||counter==4) begin
//        an_n = time_an_n;
//        segs_n = time_segs_n;
//        dp_n = time_dp_n;
//           end
           
//           else begin
           
//             an_n = temp_an_n;
//        segs_n = temp_segs_n;
//        dp_n = temp_dp_n;
//           end

        
//    end
//    else begin
// an_n = time_an_n;
//        segs_n = time_segs_n;
//        dp_n = time_dp_n;
//end 
////    else if (mode == 2'b01) begin

////         an_n = temp_an_n;
////        segs_n = temp_segs_n;
////        dp_n = temp_dp_n;
////        end
//end

















    
endmodule