`include "Decoder.v"
`include "condlogic.v"
module controller(input clk, reset,
                  input [3:0] ALUFlags,
                  input [31:12] Instrc,
                 output reg PCSrc,RegWrite,ALUSrc,MemtoReg,MemWrite,
                  output reg [1:0] RegSrc,ImmSrc,ALUControl);
  
  wire RegW,MemW,PCS;
  wire [1:0] FlagW;
  
decoder dec (Instrc[27:26] , Instrc[15:12],Instrc[25:20], PCS,RegW,MemW, MemtoReg,ALUSrc,ImmSrc,RegSrc,ALUControl,FlagW);
    
  condlogic cl( clk, reset, Instrc[31:28],ALUFlags, FlagW,PCS, RegW, MemW,
  			 PCSrc, RegWrite,MemWrite);
  
endmodule
