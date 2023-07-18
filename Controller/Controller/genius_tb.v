module genius_tb;

  reg RESET;
  reg CLK;
  reg R;
  reg [2:0] B;
  reg [1:0] C;
  reg END_1;
  reg END_2;

  
  wire START_1;
  wire START_2;
  wire VGA_FLAG;
  wire VGA_LOSE;
  wire VGA_WIN;
  wire [1:0] VGA;
  wire [3:0] state;
  wire [3:0] nextState;
  wire [6:0] SPRITES_FLAGS;

  parameter[2:0] 
    POWER = 1,
    GREEN = 2,
    RED = 3,
    BLUE = 4,
    YELLOW = 6;
  
  genius DUV (.RESET(RESET), .R(R), .CLK(CLK), .B(B), .C(C), .END_1(END_1), .END_2(END_2), .START_1(START_1), .START_2(START_2), .VGA_FLAG(VGA_FLAG), .VGA_LOSE(VGA_LOSE), .VGA_WIN(VGA_WIN), .estado_atual(state), .estado_futuro(nextState), .VGA(VGA));
  genius_vga DUV2 ( .VGA_FLAG(VGA_FLAG), .VGA_LOSE(VGA_LOSE), .VGA_WIN(VGA_WIN), .VGA(VGA), .B(B), .RESET(RESET), .SPRITES_FLAGS(SPRITES_FLAGS));
  
  initial begin
    $dumpfile("GENIUS.vcd");
    $dumpvars(1, START_1, START_2, VGA_FLAG, VGA_LOSE, VGA_WIN, VGA);
    CLK = 0;
    END_1 = 0;
    END_2 = 0;
    toggle_clk;
   
    toggle_POWER;
    C=1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_GREEN;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_RED;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_GREEN;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_GREEN;
    toggle_clk;
    toggle_END_1;
    toggle_clk;
    toggle_clk;
    toggle_clk;
    toggle_END_1;
    toggle_POWER;

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

  task toggle_clk;
    begin
      #5 CLK = ~CLK;
      #5 CLK = ~CLK;
    end
  endtask

endmodule