`include "top_module.v"

module testbench();
	reg clk;
	reg reset;
	
top_module dut(clk, reset);
  

initial begin
	reset <= 1; 
  	#10 reset <= 0;
  	clk <= 1;
   
end
  
always #5 clk=~clk;
  
  
  initial begin 
  #150
    if (dut.cpu.dp.regs.rf[5] === 32'd11) begin
      $display("Test Passed: R5 contains 11");
        end else begin
          $display("%d, %d,%d,%d",dut.cpu.dp.regs.rf[0],dut.cpu.dp.regs.rf[1],dut.cpu.dp.regs.rf[2],dut.cpu.dp.regs.rf[3]);
          $display("Test Failed: R5  %d",dut.cpu.dp.regs.rf[5]);
          $display("dataMem[0] %d ",dut.dmem.RAM[0]);
          $display("instMem[1]= %h ",dut.imem.RAM[1]);
          $display("INstruc= %h ",dut.cpu.dp.ra1mux.d0);
          $display("RA1= %h ",dut.cpu.dp.ra1mux.y);
          $display("PC =%b ",dut.cpu.dp.ff.q);
          
          $display("RD[1]=%b ",dut.cpu.dp.regs.rd1);
          $display("SrcB=%b ",dut.cpu.dp.aluu.SrcA);
          $display("SrcA =%b ",dut.cpu.dp.aluu.SrcB);
          $display("ALUResult= %b ",dut.cpu.dp.aluu.ALUResult);
          $display("ALU CONTROL=%b ",dut.cpu.ct.dec.ALUControl);

         
          
        end
#1000 $finish;
end
 
  
endmodule
