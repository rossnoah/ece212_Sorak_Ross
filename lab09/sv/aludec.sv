//--------------------------------------------------------------
// aludec.sv - MIPS multi-cycle ALU decoder
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
//--------------------------------------------------------------
module aludec(
    mips_decls_p::funct_t funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol
    );

   import mips_decls_p::*;

  // ADD CODE HERE
  // Complete the design for the ALU Decoder.
  // Your design goes here.  Remember that this is a combinational
  // module.

  // Remember that you may also reuse any code from previous labs.
  
    always_comb
    case(aluop)
        2'b00: alucontrol = 3'b010;  // add
        2'b01: alucontrol = 3'b110;  // sub
        2'b11: alucontrol = 3'b001; // ORI case

        2'b10: begin
            case(funct)          // RTYPE
                F_ADD:   alucontrol = 3'b010; // ADD
                F_SUB:   alucontrol = 3'b110; // SUB
                F_AND:   alucontrol = 3'b000; // AND
                F_OR:    alucontrol = 3'b001; // OR
                F_SLT:   alucontrol = 3'b111; // SLT
                default: alucontrol = 3'bxxx; // unimplemented/unknown
            endcase // case (funct)
        end
        default: alucontrol = 3'bxxx;
    endcase
endmodule // aludec
