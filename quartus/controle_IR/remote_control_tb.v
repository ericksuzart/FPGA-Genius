/* 
iverilog -o ir.out ir_control.v ir_control_tb.v && ./ir.out && gtkwave wave.vcd 
*/

`timescale 1ns/100ps

module remote_control_tb;
  reg clk_tb, rst_tb, irda_tb;
  wire rdy_tb;

  remote_control uut (.clk(clk_tb), .rst(rst_tb), .irda(irda_tb), .rdy(rdy_tb));
  
  initial 
  begin 
    clk_tb = 0;
    rst_tb = 0;
    irda_tb = 1;
    
    #10
    rst_tb = 1;
    
    #50
    rst_tb = 0;
    
    #30
    irda_tb = 1;
    
    #80
    irda_tb = 0;
    
    #40
    irda_tb = 0;
    
    #30
    irda_tb = 0;
    
    #50
    irda_tb = 0;
    
    #20
    irda_tb = 0;
    
    #90
    irda_tb = 0;
    
    #30
    irda_tb = 0;
    
    #200
    $stop;
    
  end
  
  always #5 clk_tb = ~clk_tb;

endmodule