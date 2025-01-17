`include "CPU.v"
`include "instrc_mem.v"
`include "data_mem.v"

module top_module(input  clk, reset );

  
	
	wire [31:0] PC, Instr, ReadData;
  wire  [31:0] WriteData, ALUResult;
	wire  MemWrite;
  
	
  CPU cpu(clk, reset, Instr,ReadData,PC, ALUResult,WriteData, MemWrite );
  
    
    
	instrc_mem imem(PC, Instr);
  data_mem dmem(clk, MemWrite, ALUResult, WriteData, ReadData);
  
endmodule
