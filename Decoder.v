module decoder(input [1:0] Op ,
               input [3:0] Rd,
               input[5:0] Funct,
              output reg PCS,RegW,MemW,
              output reg MemtoReg,ALUSrc,
               output reg [1:0] ImmSrc,RegSrc,ALUControl,FlagW);
  reg [9:0] control;
  wire Branch, ALUOp;
  assign {Branch,MemtoReg,MemW,ALUSrc,ImmSrc,RegW,RegSrc,ALUOp} = control;
  
  
  always@(*) begin
    case(Op)
      2'b00: begin
        if(Funct[5])
          control = 10'b0011001001;
        else
          control = 10'b0000001001;
      end
      2'b01: begin
        if(Funct[0])
          control = 10'b0101011000;
          else
            control = 10'b0011010100;
      end
      
      2'b10: control = 10'b1001100010;
      default: control = 10'b0000000000;
    endcase
    
  end
  
  always@(*) begin
    case (Funct[4:1])
      4'b0100: begin 
      ALUControl= 2'b00;
        FlagW = {Funct[0],Funct[0]};
      end
      4'b0010: begin 
      ALUControl= 2'b01;
        FlagW = {Funct[0],Funct[0]};
      end
      4'b0000: begin 
      ALUControl= 2'b10;
        FlagW = {Funct[0],1'b0};
      end
      4'b1100: begin 
      ALUControl= 2'b11;
        FlagW = {Funct[0],1'b0};
      end
      default: begin
        ALUControl = 2'b00;
        FlagW = 2'b00;
      end
    endcase
      
  end
  
  always@(*) begin
    PCS = ((Rd[3:0]==4'b1111)&RegW)|Branch;
  end
      
endmodule
