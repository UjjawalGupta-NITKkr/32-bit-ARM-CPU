`include "controller.v"
`include "DataPath.v"

module CPU(input clk, reset,
           input[31:0] Instr,
           input [31:0] ReadData,
           output [31:0] PC,ALUResult,WriteData,
          output MemWrite);
  
  wire [3:0] ALUFlags;
  wire PCSrc,RegWrite,ALUSrc,MemtoReg ;
  wire [1:0] RegSrc,ImmSrc,ALUControl;
  
  
  controller ct(clk, reset, ALUFlags,Instr[31:12],PCSrc,RegWrite,ALUSrc,MemtoReg,MemWrite,RegSrc,ImmSrc,ALUControl);
  
  DataPath dp ( clk , reset,PCSrc, RegSrc,RegWrite,ImmSrc,ALUSrc,ALUControl, MemtoReg,PC,Instr,ReadData,ALUFlags,ALUResult, WriteData);
  
endmodule
