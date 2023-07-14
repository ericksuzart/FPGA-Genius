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
  
<<<<<<< HEAD:quartus/remote_control/remote_control_tb.v
  integer i;

  initial 
	begin 
		clk_tb = 0;
		rst_tb = 0;
		irda_tb = 1;
		
		
		#10;
		rst_tb = 1;
		
		#50;
		rst_tb = 0;
		
		#30;
		irda_tb = 0;
		
		// 000
		#660 
		// 001
		irda_tb = 1;
		#60;
		// 010
		irda_tb = 0;
		#180;
		irda_tb = 1;
		#120;
		irda_tb = 0;
		#60;
		// 011
		irda_tb = 0;
		#180;
		irda_tb = 1;
		#120;
		irda_tb = 1;
		#60;
		// 100
		irda_tb = 1;
		#180;
		irda_tb = 0;
		#180;
		// 101
		irda_tb = 1;
		#180;
		irda_tb = 0;
		#120;
		irda_tb = 1;
		#60;
		// 110
		irda_tb = 1;
		#180;
		irda_tb = 1;
		#120;
		irda_tb = 0;
		#60;
		// 111
		irda_tb = 1;
		#360
		$stop;
		
	end
		 
	
  
  always #5 clk_tb = ~clk_tb;
  
 
=======
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

>>>>>>> 1160a765f07c1316874ee1d88759d5a3a739f343:quartus/controle_IR/remote_control_tb.v
endmodule