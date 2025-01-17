`include "mux.v"
`include "flip_flop.v"
`include "adder.v"
`include "regfile.v"
`include "extender.v"
`include "alu.v"

module DataPath(input clk , reset,
                input PCSrc,
                input [1:0] RegSrc,
                input RegWrite,
                input [1:0] ImmSrc,
                input ALUSrc,
                input [1:0] ALUControl,
                input MemtoReg,
                output reg [31:0] PC,
                input [31:0] ReadData,
                output reg [3:0] ALUFlags,
                output reg [31:0] ALUResult,WriteData);
  
  wire [31:0] PCNext , PCPlus4, PCPlus8;
  wire [31:0] SrcA, SrcB, ExtImm;
  wire [31:0] Result ;
  wire [3:0] RA1,RA2;
  
  mux #(.WIDTH(32)) pcmux(.d0(PCPlus4),.d1(Result),.s(PCSrc),.y(PCNext));
  flip_flop ff (clk, reset, PCNext, PC);
  adder add1(.a(PC),.b(32'd4),.y(PCPlus4));
  adder add2(.a(32'd4),.b(PCPlus4),.y(PCPlus8));
  mux #(.WIDTH(4)) ra1mux(.d0(Instr[19:16]),.d1(4'b1111),.s(RegSrc[2'd0]),.y(RA1));
  mux #(.WIDTH(4)) ra2mux(.d0(Instr[3:0]),.d1(Instr[15:12]),.s(RegSrc[1]),.y(RA2));
  regfile regs(.clk(clk),.ra1(RA1),.ra2(RA2),.wa3(Instr[15:12]),.wd3(Result),.R15(PCPlus8),.we3(RegWrite),.rd1(SrcA),.rd2(WriteData));
  extender ext(.ImmSrc(ImmSrc),.Instrc(Instr[23:0]),.ExtImm(ExtImm));
  mux #(.WIDTH(32)) alumux(.d0(WriteData),.d1(ExtImm),.s(ALUSrc),.y(SrcB));
  
  ALU aluu (.SrcA(SrcA),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); 
  mux #(.WIDTH(32)) resultmux (.d0(ReadData),.d1(ALUResult),.s(MemtoReg),.y(Result));

endmodule
