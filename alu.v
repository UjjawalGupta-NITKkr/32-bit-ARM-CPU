module ALU(input [31:0] SrcA,
           input [31:0] SrcB,
           input [1:0] ALUControl,
           output reg [31:0] ALUResult,
           output reg [3:0] ALUFlags);
  
  reg Negative,Zero,Carry,Overflow;
  
  always@(*) begin
    case(ALUControl) 
      2'b00: begin 
        {Carry,ALUResult} = SrcA + SrcB ;
         Overflow = ((SrcA[31] == SrcB[31]) && (ALUResult[31] != SrcA[31])); 
      end
      2'b01: begin 
        {Carry,ALUResult} = SrcA - SrcB ;
         Overflow = ((SrcA[31] == SrcB[31]) && (ALUResult[31] != SrcA[31])); 
      end
      2'b10: begin 
        ALUResult = SrcA & SrcB ;
        Carry = 0;
        Overflow = 0;
      end
      2'b11: begin 
        ALUResult = SrcA | SrcB ;
        Carry = 0;
        Overflow = 0;
      end
      default: begin
                ALUResult = 32'b0;
                Carry= 0;
                Overflow = 0;
            end
    endcase
  end
  
  assign Zero = (ALUResult==32'b0)?1'b1:1'b0;
  assign Negative = ALUResult[31]; 
  assign ALUFlags={Negative,Zero,Carry,Overflow};
endmodule
  
