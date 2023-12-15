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

   logic [31:0] pc, aluresult, aluout, data, readdata, adr, wd, rd, regresult, instr, rd1, rd2;
   logic [4:0] writereg;



    flopr #(32) U_PCREG(.clk(clk), .reset(reset), .d(pcnext), .q(pc));

    mux2 #(32) MUX2_IORD(.d0(pc). .d1(aluout), .s(iord), .y(adr) );

    mem MEM(.clk, .ard, .wd,.rd );

    flopr #(32) U_MDR(.clk(clk), .reset(reset), .d(rd), .q(data));

    flopr #(32) U_IR(.clk(clk), .reset(reset), .d(rd), .q(instr));

    mux2 #(32) MUX2_MEMTOREG(.d0(data). .d1(aluout), .s(memtoreg), .y(regresult) );

    mux2 #(5) MUX2_REGDST(.d0(instr[20:16]),d1(instr[15:11]), .s(regdst), .y(writereg));

    regfile REGFILE(.clk, .wd3(regresult), .ra1(instr[26:21]), .ra2(instr[20:16]), .wa3(writereg), .we3(regwrite), .rd1, .rd2 );


    

    flopr #(32) U_ALUOUT(.clk(clk), .reset(reset), .d(pcnext), .q(pc));





endmodule
