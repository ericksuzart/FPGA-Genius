/* 
iverilog -o ir.out ir_control.v ir_control_tb.v && ./ir.out && gtkwave wave.vcd 
*/

`timescale 1ns/100ps

module remote_control_tb;
  reg clk_tb, rst_tb, irda_tb;
  wire rdy_tb;
  wire buttons_tb;
  wire color_tb;

  remote_control uut (.clk(clk_tb), .rst(rst_tb), .irda(irda_tb), .rdy(rdy_tb), .buttons(buttons_tb), .color(color_tb));
  
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
    irda_tb = 0;
    
    #80
    irda_tb = 1;
    
    #40
    irda_tb = 1;
    
    #30
    irda_tb = 1;
    
    #50
    irda_tb = 1;
    
    #20
    irda_tb = 1;
    
    #90
    irda_tb = 1;
    
    #30
    irda_tb = 1;
    
    #200
    $stop;
    
  end
  
  always #5 clk_tb = ~clk_tb;

endmodule