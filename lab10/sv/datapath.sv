//--------------------------------------------------------------------
// datapath.sv - Multicycle MIPS datapath
// David_Harris@hmc.edu 23 October 2005
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Use enums from new package to make opcode & function codes
//     display symbolic names  during simulation
//  2. Explicitly break out and use instruction subfields (opcode, rs, rt, etc.
//
//--------------------------------------------------------------------

// The datapath unit is a structural verilog module.  That is,
// it is composed of instances of its sub-modules.  For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.

module datapath(
    input  logic        clk, reset,
    input logic         pcen, irwrite, regwrite,
    input logic         alusrca, iord, memtoreg, regdst,
    input logic [1:0]   alusrcb, pcsrc,
    input logic [2:0]   alucontrol,
    output mips_decls_p::opcode_t opcode,
    output mips_decls_p::funct_t funct,
    output logic        zero,
    output logic [31:0] adr, writedata,
    input logic [31:0]  readdata
    );


   import mips_decls_p::*;

   // instruction fields
   logic [31:0]                     instr;
   logic [4:0]                      rs, rt, rd;  // register fields
   logic [15:0]                     immed;       // i-type immediate field
   logic [25:0]                     jmpimmed;    // j-type pseudo-address

   logic [31:0] pc, pcnext, aluresult, aluout, data, regresult, rd1, rd2, a, signimm, srca, srcb, shiftedby2, pcjump;
   
   logic [4:0] writereg;
  // extract instruction fields from instruction
   assign opcode = opcode_t'(instr[31:26]);
   assign funct = funct_t'(instr[5:0]);
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign immed = instr[15:0];
   assign jmpimmed = instr[25:0];


   // Your datapath hardware goes below.  Instantiate each of the submodules
   // that you need.  Feel free to copy ALU, muxes and other modules from
   // Lab 9.  This directory also includes parameterizable multipliexers
   // mux3.sv (paramaterized 3:1) and mux4.sv (paramterized 4:1)
   // Make sure to instantiate with the correct bitwidth!

   // Remember to give your instantiated modules applicable instance names
   // such as U_PCREG (PC register), U_WDMUX (Write Data Mux), etc.
   // so it's easier to find them during simulation and debugging.

   



    flopenr #(32) U_PCREG(.clk(clk), .reset(reset), .en(pcen), .d(pcnext), .q(pc));
    mux2 #(32) MUX2_IORD(.d0(pc), .d1(aluout), .s(iord), .y(adr) );

    flopr #(32) U_MDR(.clk(clk), .reset(reset), .d(readdata), .q(data));
    flopenr #(32) U_IR(.clk(clk), .reset(reset), .en(irwrite), .d(readdata), .q(instr));

    mux2 #(32) MUX2_MEMTOREG(.d0(aluout), .d1(data), .s(memtoreg), .y(regresult) );

    mux2 #(5) MUX2_REGDST(.d0(rt), .d1(rd), .s(regdst), .y(writereg));

    regfile REGFILE(.clk(clk), .wd3(regresult), .ra1(rs), .ra2(rt), .wa3(writereg), .we3(regwrite), .rd1, .rd2 );

    flopr #(32) U_A(.clk(clk), .reset(reset), .d(rd1), .q(a));
    flopr #(32) U_B(.clk(clk), .reset(reset), .d(rd2), .q(writedata));

    mux2 #(32) MUX2_ALUSRCA(.d0(pc), .d1(a), .s(alusrca), .y(srca) );

    signext EXTEND(.a(immed), .y(signimm));

    sl2 SHIFT2ALU (.a(signimm), .y(shiftedby2) );

    mux4 #(32) MUX2_ALUSRCB(.d0(writedata), .d1(32'd4), .d2(signimm), .d3(shiftedby2), .s(alusrcb), .y(srca) );


    alu ALU (.a(srca), .b(srcb), .f(alucontrol), .zero, .y(aluresult));


    flopr #(32) U_ALUOUT(.clk(clk), .reset(reset), .d(aluresult), .q(aluout));

    sl2 SHIFT2PC (.a(jmpimmed), .y(pcjump) );

    mux3 #(32) PCSRC (.d0(aluresult), .d1(aluout), .d2({pc[31:28],pcjump}),  .s(alusrcb), .y(pcnext) );





endmodule
