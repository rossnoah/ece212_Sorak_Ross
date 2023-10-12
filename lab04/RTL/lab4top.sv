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

lab03_top LAB3(.clk, .rst, .useFakeTemp(0), .cf,.tmp_scl,.tmp_sda,.an_n(temp_an_n),.segs_n(temp_segs_n),.dp_n(temp_dp_n));
dig_clock_top LAB2(.clk, .rst,.adv_hr,.adv_min,.an_n(time_an_n),.segs_n(time_segs_n),.dp_n(time_dp_n), .toggle(sw[0]));

period_enb #(.PERIOD_MS(2000)) U_ENB(.clk, .rst, .enb_out(enb));

typedef enum logic [1:0] {
   TIME = 2'b00, C = 2'b01, F = 2'b10
} states_t;

states_t state, next;

always_ff @(posedge enb)
        if (rst) state <= TIME;
        else state <= next;
    
    always_comb begin
        cf = 0;
        segs_n = time_segs_n;
        an_n = time_an_n;
        dp_n = time_dp_n;
        next = TIME;

        case (state)
            TIME: begin
            cf = 0;
            segs_n = time_segs_n;
            an_n = time_an_n;
            dp_n = time_dp_n;
            if(mode == 2'b00) next = TIME;
            else if (mode == 2'b01) next = F;
            else if (mode == 2'b10) next = C;
            else next = F;
            end

            F: begin  
            cf = 1;
            segs_n = temp_segs_n;
            an_n = temp_an_n;
            dp_n = temp_dp_n;
            if(mode ==2'b00) next = TIME;
            else if (mode == 2'b01) next = TIME;
            else if (mode == 2'b10) next = C;
            else next = C;
            end
            
            C: begin
            cf = 0;
            segs_n = temp_segs_n;
            an_n = temp_an_n;
            dp_n = temp_dp_n;
            if(mode ==2'b00) next = TIME;
            else if (mode == 2'b01) next = F;
            else if (mode == 2'b10) next = TIME;
            else next = TIME;
            end
            default : begin
            cf = 0;
            segs_n = time_segs_n;
            an_n = time_an_n;
            dp_n = time_dp_n;
            if(mode == 2'b00) next = TIME;
            else if (mode == 2'b01) next = F;
            else if (mode == 2'b10) next = C;
            else next = F;
            end
        endcase
    end
    
endmodule