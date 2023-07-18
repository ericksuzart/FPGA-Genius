module genius_tb;

  reg RESET;
  reg CLK;
  reg R;
  reg [2:0] B;
  reg [1:0] C;
  reg END_1;
  reg END_2;

  wire [2:0] B_OUT;
  wire START_1;
  wire START_2;
  wire VGA_FLAG;
  wire VGA_LOSE;
  wire VGA_WIN;
  wire [1:0] VGA;
  wire [3:0] state;
  wire [3:0] nextState;
  wire [6:0] SPRITES_FLAGS;


  integer p, i;

  parameter[2:0] 
    POWER = 1,
    GREEN = 2,
    RED = 3,
    BLUE = 4,
    YELLOW = 6;
  
  genius DUV (.RESET(RESET), .R(R), .CLK(CLK), .B(B), .C(C), .END_1(END_1), .END_2(END_2), .START_1(START_1), .START_2(START_2), .VGA_FLAG(VGA_FLAG), .VGA_LOSE(VGA_LOSE), .VGA_WIN(VGA_WIN), .estado_atual(state), .estado_futuro(nextState), .VGA(VGA), .B_OUT(B_OUT));
  genius_vga DUV2 (.VGA_FLAG(VGA_FLAG), .VGA_LOSE(VGA_LOSE), .VGA_WIN(VGA_WIN), .VGA(VGA), .B(B_OUT), .RESET(RESET), .SPRITES_FLAGS(SPRITES_FLAGS));
  
  initial begin
    CLK = 0;
    RESET = 0;
    END_1 = 0;
    END_2 = 0;
    toggle_clk;
   
    toggle_POWER;
    C = 2'b10;
    toggle_clk;
    for (p=0; p<4; p = p+1) begin
      toggle_clk;
    end
    END_1 = 1;
    toggle_clk;
    END_1 = 0;
    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end
    END_2 = 1;
    toggle_clk;
    END_2 = 0;
    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end

    RESET = 1;
    toggle_clk;
    RESET = 0;

    C= 2'b01;

    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end

    toggle_POWER;
    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end
    END_1 = 1;
    toggle_clk;
    END_1 = 0;

    toggle_POWER;
    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end

    toggle_GREEN;
    for (p=0; p<3; p = p+1) begin
      toggle_clk;
    end

    for (i=0; i<20; i = i+1) begin
        for (p=0; p<3; p = p+1) begin
          toggle_clk;
        end

        toggle_POWER;
        for (p=0; p<3; p = p+1) begin
          toggle_clk;
        end
        END_1 = 1;
        toggle_clk;
        END_1 = 0;

        toggle_POWER;
        for (p=0; p<3; p = p+1) begin
          toggle_clk;
        end

        toggle_GREEN;
        for (p=0; p<3; p = p+1) begin
          toggle_clk;
        end
    end



  end

  task toggle_END_1;
    begin
      END_1= ~END_1;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      END_1= ~END_1;
    end
  endtask

  task toggle_END_2;
    begin
      END_2= ~END_2;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      END_2= ~END_2;
    end
  endtask

  task toggle_POWER;
    begin
      R = 1;
      B = POWER;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      B = 0;
      R = 0;
    end
  endtask

  task toggle_GREEN;
    begin
      R = 1;
      B = GREEN;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      B = 0;
      R = 0;
    end
  endtask

  task toggle_BLUE;
    begin
      R = 1;
      B = BLUE;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      B = 0;
      R = 0;
    end
  endtask

  task toggle_RED;
    begin
      R = 1;
      B = RED;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      B = 0;
      R = 0;
    end
  endtask

  task toggle_YELLOW;
    begin
      R = 1;
      B = YELLOW;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
      B = 0;
      R = 0;
    end
  endtask

  task toggle_clk;
    begin
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
    end
  endtask

endmodule