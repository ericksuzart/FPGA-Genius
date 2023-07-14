`timescale 10ns/100ps

module remote_tb;
	reg reset_tb, clk_pll_tb, IRDA_RXD_tb;
	wire cor_tb, ready_tb, botao_tb;
	remote ctr_ir (.reset(reset_tb), .clk_pll(clk_pll_tb), .IRDA_RXD(IRDA_RXD_tb), .cor(cor_tb), .ready(ready_tb), .botao(botao_tb));
	
	
	
	always #5 clk_pll_tb = ~clk_pll_tb;
	
	initial begin
		clk_pll_tb = 0;
		reset_tb = 0;
		IRDA_RXD_tb = 1;
		
		
		#10 reset_tb = 1;
		#20 reset_tb = 0;
		#30 IRDA_RXD_tb = 0;
		#40 IRDA_RXD_tb = 1;
		 
		 
		 // Test case 2
		#50 
		IRDA_RXD_tb = 1;
		#60 
		IRDA_RXD_tb = 0;
		#70 
		IRDA_RXD_tb = 1;
		#80 
		IRDA_RXD_tb = 0;
		 
		 // Test case 3
		#90 
		IRDA_RXD_tb = 1;
		#100 
		IRDA_RXD_tb = 0;
		#110 
		IRDA_RXD_tb = 1;
		#120 
		IRDA_RXD_tb = 0;
		#130 
		IRDA_RXD_tb = 1;
		#140 
		IRDA_RXD_tb = 0;
		 
		 // Test case 4
		#150 
		IRDA_RXD_tb = 0;
		#160 
		IRDA_RXD_tb = 1;
		#170 
		IRDA_RXD_tb = 0;
		 
		 // Test case 5
		#180 
		IRDA_RXD_tb = 0;
		#190 
		IRDA_RXD_tb = 1;
		#200 
		IRDA_RXD_tb = 0;
		#210 
		IRDA_RXD_tb = 1;
		#220 
		IRDA_RXD_tb = 0;
		 
		 // Test case 6
		#230 
		IRDA_RXD_tb = 0;
		#240 
		IRDA_RXD_tb = 1;
		#250 
		IRDA_RXD_tb = 0;
		#260 
		IRDA_RXD_tb = 1;
		#270 
		IRDA_RXD_tb = 0;
		#280 
		IRDA_RXD_tb = 1;
		#290 
		IRDA_RXD_tb = 0;
		 
		 // Test case 7
		#300 
		IRDA_RXD_tb = 0;
		#310 
		IRDA_RXD_tb = 1;
		#320 
		IRDA_RXD_tb = 0;
		#330 
		IRDA_RXD_tb = 1;
		#340 
		IRDA_RXD_tb = 0;
		#350 
		IRDA_RXD_tb = 1;
		#360 
		IRDA_RXD_tb = 0;
		#370 
		IRDA_RXD_tb = 1;
		#380 
		IRDA_RXD_tb = 0;
		
		#390
		$stop;
	end
	
	
endmodule