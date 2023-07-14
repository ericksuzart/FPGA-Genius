module remote_control (clk, rst, irda, rdy, buttons, color);
  input clk, rst, irda;
  integer count;
  integer count_c;
  
  output reg rdy = 1'b0;
  
  // Registradores de estado
  reg [3:0] state;
  
  output reg [1:0] color;
  
  // Codificação dos estados
  parameter s0 = 4'b0000,
            s1 = 4'b0001,
            s2 = 4'b0010,
            s3 = 4'b0011,
				s4 = 4'b0100,
				s5 = 4'b0101,
				s6 = 4'b0110,
				s7 = 4'b0111,
				s8 = 4'b1000,
				s9 = 4'b1001,
				s10 = 4'b1010,
				s11 = 4'b1011,
				s12 = 4'b1100;

  output reg [2:0] buttons = 3'bxxx;

  initial 
  begin
    state <= s0;
  end
  
  // Primeiro procedimento - Definicão próximo estado
  always @(negedge clk, posedge rst) 
  begin
    if(rst == 1'b1) state <= s0;
    else begin
      case(state)
        s0:
        begin
          if (irda == 1'b1) 
				state <= s0;
          else state <= s1;
        end

        s1:
        begin
          state <= s2;
        end

        s2:
        begin
          if (count < 10) 
            state <= s2;
          else 
            state <= s3;
        end
		  s3:
		  begin
			state <= s4;
		  end
		  s4:
		  begin
		  if (count < 20) 
            state <= s4;
          else 
            state <= s5;
		  end
		  s5:
		  begin
			state <= s6;
		  end
		  s6:
		  begin
		  if (count < 35) 
            state <= s6;
          else 
            state <= s7;
		  end
		  s7:
		  begin
				state<= s8;
		  end
		  s8:
		  begin
			if (buttons == 3'b001 || buttons == 3'b010 || buttons == 3'b011 || buttons == 3'b110 || buttons == 3'b100)
				state <= s9;
			  else
				state <= s0;
		  end
		  s9:
		  begin
				state <= s10;
		  end
		  s10:
		  begin
				state <= s11;
		  end
		  s11:
		  begin
				state <= s12;
		  end
		  s12:
		  begin
				state <= s0;
		  end
		  
      endcase
    end
  end
  
  always @(negedge clk) begin
    case(state)
      s0: begin
			count = 32'bx;
			count_c = 0;
			buttons = 3'bxxx;
		end
      s1: begin
			count = 0;
			count_c = count_c +1;
			color = count_c;
		end
      s2: count = count + 1;
      s3: buttons = {irda, buttons[2:1]};
		s4: count = count+1;
		s5: buttons = {buttons[2], irda, buttons[1]};
		s6: count = count+1;
		s7: buttons = {buttons[2:1], irda};
		s8: count = 0;
		s9: rdy =1'b1;
		s10: rdy =1'b1;
		s11: rdy =1'b1;
		s12: rdy =1'b1;
    endcase
  end
endmodule