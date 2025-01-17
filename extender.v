module extender( ImmSrc , Instrc ,  ExtImm);
  input [1:0] ImmSrc;
  input [23:0] Instrc;
  output reg [31:0] ExtImm;
  
  always@(*) begin
    case(ImmSrc)
      2'b00: begin ExtImm = {{24{1'b0}},Instrc[7:0]}; end
      2'b01: begin ExtImm = {{20{1'b0}},Instrc[11:0]}; end
      2'b10: begin ExtImm = {{6{Instrc[23]}},Instrc[23:0],1'b0,1'b0};end
      default: ExtImm = 32'b1;
    endcase
  end
  
endmodule
