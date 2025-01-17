module regfile(input clk,
               input [3:0] ra1,ra2,wa3,
               input [31:0] wd3,R15,
               input we3,
               output reg [31:0] rd1,rd2);
  reg [31:0] rf[14:0];
  always@(posedge clk) begin
    if(we3)
      rf[wa3]<=wd3;
    end
  assign rd1=(ra1==4'b1111) ? R15 : rf[ra1];
  assign rd2=(ra2 ==4'b1111)? R15 : rf[ra2];
endmodule
