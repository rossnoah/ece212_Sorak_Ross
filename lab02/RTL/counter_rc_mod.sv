
module mod #(parameter W=4,parameter MOD=1) (
    input logic clk, rst, enb,
    output logic [W-1:0] out
    );
    
    logic [W-1:0] q

    assign out = q%MOD;

    always_ff @(posedge clk)
        if (rst)      q <= '0;
        else if (enb) q <= q + 1;

endmodule: counter