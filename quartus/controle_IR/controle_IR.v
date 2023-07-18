`timescale 1ns/1ps

module controle_IR (rst, clk, irda, color, rdy, buttons, b_power, b_blue, b_yellow, b_green, b_red);
	input rst, clk, irda;
	output reg [1:0] color; 
	output reg [2:0] buttons;
	output reg rdy, b_power, b_blue, b_yellow, b_green, b_red;

	integer counter_buttons;
	reg [7:0] counter_random;
	
	wire rst, clk, irda;
	
	parameter START  = 4'b0000,
				 S0 = 4'b0001,
				 S1 = 4'b0010,
				 S2  = 4'b0011,
				 S3 = 4'b0100,
				 S4 = 4'b0101,
				 S5  = 4'b0110,
				 S6 = 4'b0111,
				 S7 = 4'b1000,
				 S8 = 4'b1001,
				 S9 = 4'b1010,
				 S10 = 4'b1011,
				 S11= 4'b1100;
				 
				 
	reg [3:0] state;
	reg [3:0] next_state;
	
				
	always @ (posedge clk) 
		begin
			if (rst == 1'b1) begin
				state <= START;
			end 
			else begin
				case (state)
					START: begin
						counter_random <= 1'b0;
					end 
					
					S0: begin
						counter_random <= counter_random + 1'b1;
					end
					
					S1: begin
						counter_buttons <= 0;
					end
						
					S2: begin
						counter_buttons <= counter_buttons + 1;
					end
					
					S4: begin
						counter_buttons <= counter_buttons + 1;
					end
					
					S6: begin
						counter_buttons <= counter_buttons + 1;
					end
						
				endcase

				state <= next_state;
			end
		end
	
	
	always @ (state or irda or rst) 
		begin: OUTPUT
			if (rst == 1'b1) begin
				color = 2'b00;
				buttons = 3'b000; 
				rdy = 1'b0;
				b_blue = 1'b0;
				b_green = 1'b0;
				b_red = 1'b0;
				b_yellow = 1'b0;
				b_power = 1'b0;
			end 
			else begin
				case (state)
	
					
					START: begin			
						color = 2'b00;
						buttons = 3'b000; 
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
					
					S0: begin			
						color = counter_random; 
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
						
					S3: begin
						color = counter_random;
						buttons = {irda, buttons[2:1]}; 
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
						
					S5: begin
						color = counter_random;
						buttons = {buttons[2], irda, buttons[1]};
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
										
					S7: begin
						color = counter_random;
						buttons = {buttons[2:1], irda};
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
					
					S8: begin
						rdy = 1'b1;
						color = counter_random;
						
						
						if (buttons == 3'b100) begin
							b_blue = 1'b1;
							b_green = 1'b0;
							b_red = 1'b0;
							b_yellow = 1'b0;
							b_power = 1'b0;
						end else if (buttons == 3'b011) begin
							b_blue = 1'b0;
							b_green = 1'b0;
							b_red = 1'b1;
							b_yellow = 1'b0;
							b_power = 1'b0;
						end else if (buttons == 3'b110) begin
							b_blue = 1'b0;
							b_green = 1'b0;
							b_red = 1'b0;
							b_yellow = 1'b1;
							b_power = 1'b0;
							
						end else if (buttons == 3'b010) begin
							b_blue = 1'b0;
							b_green = 1'b1;
							b_red = 1'b0;
							b_yellow = 1'b0;
							b_power = 1'b0;
						end else if (buttons == 3'b001) begin
							b_blue = 1'b0;
							b_green = 1'b0;
							b_red = 1'b0;
							b_yellow = 1'b0;
							b_power = 1'b1;
						end else begin
							b_blue = 1'b0;
							b_green = 1'b0;
							b_red = 1'b0;
							b_yellow = 1'b0;
							b_power = 1'b0;
						end
					end 
					
					S9: begin
						color = counter_random;
						rdy = 1'b1; 
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
					
					S10: begin
						color = counter_random;
						rdy = 1'b1; 
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
					
					S11: begin
						color = counter_random; 
						rdy = 1'b1; 
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end 
					
					default: begin				
						color = counter_random;
						rdy = 1'b0;
						b_blue = 1'b0;
						b_green = 1'b0;
						b_red = 1'b0;
						b_yellow = 1'b0;
						b_power = 1'b0;
					end
					
				endcase				
			end			
		end
	
	
	always @ (state or irda or rst or counter_buttons) 
		begin: FSM_COMBO
		
			next_state = START;
		
			if (rst == 1'b1) begin
				next_state = START;
			end
			
			
			case (state)
			
				default: begin
					next_state = START;
				end
				
				START: begin
					next_state = S0;
				end 
				
				S0: begin
					if (irda == 1'b0) begin
						next_state = S1;
					end else begin
						next_state = S0;
					end
				end
				
				S1: begin
					next_state = S2;
				end
					
				S2: begin
					if (counter_buttons < 193) begin
						next_state = S2;
					end else begin
						next_state = S3;
					end
				end
				
				S3: begin
					next_state = S4;
				end
				
				S4: begin
					if (counter_buttons < 234) begin
						next_state = S4;
					end else begin
						next_state = S5;
					end
				end
					
				S5: begin
					next_state = S6; 
				end
				
				S6: begin
					if (counter_buttons < 254) begin
						next_state = S6;
					end else begin
						next_state = S7;
					end
				end	
					
				S7: begin
					if (buttons == 3'b001 || buttons == 3'b010 || buttons == 3'b011 || buttons == 3'b110 || buttons == 3'b100) begin
						next_state = S8;
					end else begin
							next_state = START;
					end
				end
				
				S8: begin
					next_state = S9;
				end
				
				S9: begin
					next_state = S10;
				end
				
				S10: begin
					next_state = S11;
				end
				
				S11: begin
					next_state = START;
				end
				
			endcase
				
		end
		
	
endmodule
