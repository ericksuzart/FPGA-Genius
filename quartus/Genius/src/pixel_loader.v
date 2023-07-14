module pixel_loader
(
  // ----- Inputs -----
  input RESET,
  input CLK,
  input [47:0] DATA_IN,
  input [7:0] SPRITES_EN, // flags for 8 sprites

  // ----- Outputs ----
  output reg MEM_CLK,
  output [15:0] MEM_ADDR,
  output reg [2:0] MEM_SEL, // 3 bits, 8 sprite
  output [23:0] RGB
);

  parameter   BACKGROUND_MAX_ADDR = 64800,    // 65536
              BLUE_MAX_ADDR = 14112,          // 16384
              GREEN_MAX_ADDR = 14112,         // 16384
              RED_MAX_ADDR = 14112,           // 16384
              YELLOW_MAX_ADDR = 14112,        // 16384
              LOSE_MAX_ADDR = 25200,          // 32768
              WIN_MAX_ADDR = 21600,           // 32768
              PWR_MAX_ADDR = 200;             // 256

  parameter   BACKGROUND_MEM_SEL = 3'b000,
              PWR_MEM_SEL = 3'b001,
              RED_MEM_SEL = 3'b010,
              GREEN_MEM_SEL = 3'b011,
              BLUE_MEM_SEL = 3'b100,
              YELLOW_MEM_SEL = 3'b101,
              WIN_MEM_SEL = 3'b110,
              LOSE_MEM_SEL = 3'b111;

  // Flags for 8 sprites
  wire BACKGROUND_EN, BLUE_EN, GREEN_EN, RED_EN, YELLOW_EN, LOSE_EN, WIN_EN, PWR_EN;

  reg [47:0] rgb_pixels;  // 48 bits, 2 pixels
  reg [23:0] out_pixel; // 24 bits, 1 pixel

  // State register
  reg [2:0] A_State, F_State;

  // Addresses holder
  reg [15:0] r_addr;
  reg [15:0] max_addr;
  reg [15:0] background_addr; // 16 bits, 65536 max
  reg [13:0] blue_addr, green_addr, red_addr, yellow_addr; // 14 bits, 16384 max
  reg [14:0] lose_addr, win_addr; // 15 bits, 32768 max
  reg [7:0] pwr_addr; // 8 bits, 256 max

  // Encoding of states
  parameter INICIO = 0,
      PREPARAR = 1,
      ATIVAR = 2,
      SUSPENDER = 3,
      LER = 4,
      INCREMENTAR = 5;

  // Clocked block
  always @(posedge CLK)
  begin
    if (RESET)
    begin
      A_State <= INICIO;
      background_addr <= 0;
      blue_addr <= 0;
      green_addr <= 0;
      red_addr <= 0;
      yellow_addr <= 0;
      lose_addr <= 0;
      win_addr <= 0;
      pwr_addr <= 0;
    end
    else
    begin
      A_State <= F_State;

      if (F_State == INCREMENTAR)
      begin
        if (BLUE_EN)
          blue_addr <= blue_addr + 1;
        if (GREEN_EN)
          green_addr <= green_addr + 1;
        if (RED_EN)
          red_addr <= red_addr + 1;
        if (YELLOW_EN)
          yellow_addr <= yellow_addr + 1;
        if (LOSE_EN)
          lose_addr <= lose_addr + 1;
        if (WIN_EN)
          win_addr <= win_addr + 1;
        if (PWR_EN)
          pwr_addr <= pwr_addr + 1;
        if (BACKGROUND_EN)
          background_addr <= background_addr + 1;
      end

      if (F_State == INICIO)
      begin
        if (BLUE_EN)
          blue_addr <= 0;
        if (GREEN_EN)
          green_addr <= 0;
        if (RED_EN)
          red_addr <= 0;
        if (YELLOW_EN)
          yellow_addr <= 0;
        if (LOSE_EN)
          lose_addr <= 0;
        if (WIN_EN)
          win_addr <= 0;
        if (PWR_EN)
          pwr_addr <= 0;
        if (BACKGROUND_EN)
          background_addr <= 0;
      end
    end
  end

  // Next state decoder
  always @(*)
  begin
    case (A_State)
      INICIO:
        if (RESET)
          F_State = INICIO;
        else
          F_State = PREPARAR;

      PREPARAR:
        if (r_addr == max_addr)
          F_State = INICIO;
        else
          F_State = ATIVAR;

      ATIVAR:
        if (BACKGROUND_EN)
          F_State = LER;
        else
          F_State = SUSPENDER;

      SUSPENDER:
        if (BACKGROUND_EN)
          F_State = LER;
        else
          F_State = SUSPENDER;

      LER:
        F_State = INCREMENTAR;

      INCREMENTAR:
        F_State = PREPARAR;

      default:
        F_State = INICIO;
    endcase
  end

  // Output decoder
  always @(*)
  begin
    // State outputs
    MEM_CLK = 0;
    rgb_pixels = 0;
    out_pixel = 0;

    case (A_State)
      INICIO: begin
        MEM_CLK = 0;
        rgb_pixels = 0;
        out_pixel = 0;
      end

      PREPARAR:
        out_pixel = rgb_pixels[23:0];

      ATIVAR:
        MEM_CLK = 1;

      SUSPENDER:
        rgb_pixels = DATA_IN;

      LER: begin
        rgb_pixels = DATA_IN;
        out_pixel = DATA_IN[47:24];
      end

      INCREMENTAR:
        rgb_pixels = DATA_IN;
    endcase
  end

  // Memory selection
  always @*
  begin
    if (LOSE_EN) // upper priority
    begin
      MEM_SEL = LOSE_MEM_SEL;
      max_addr = LOSE_MAX_ADDR;
      r_addr = lose_addr;
    end
    else if (WIN_EN)
    begin
      MEM_SEL = WIN_MEM_SEL;
      max_addr = WIN_MAX_ADDR;
      r_addr = win_addr;
    end
    else if (PWR_EN)
    begin
      MEM_SEL = PWR_MEM_SEL;
      max_addr = PWR_MAX_ADDR;
      r_addr = pwr_addr;
    end
    else if (BLUE_EN)
    begin
      MEM_SEL = BLUE_MEM_SEL;
      max_addr = BLUE_MAX_ADDR;
      r_addr = blue_addr;
    end
    else if (GREEN_EN)
    begin
      MEM_SEL = GREEN_MEM_SEL;
      max_addr = GREEN_MAX_ADDR;
      r_addr = green_addr;
    end
    else if (RED_EN)
    begin
      MEM_SEL = RED_MEM_SEL;
      max_addr = RED_MAX_ADDR;
      r_addr = red_addr;
    end
    else if (YELLOW_EN) // lower priority
    begin
      MEM_SEL = YELLOW_MEM_SEL;
      max_addr = YELLOW_MAX_ADDR;
      r_addr = yellow_addr;
    end
    else
    begin
      // case no sprite is enabled, background is selected
      MEM_SEL = BACKGROUND_MEM_SEL;
      max_addr = BACKGROUND_MAX_ADDR;
      r_addr = background_addr;
    end
  end

  assign RGB = out_pixel;
  assign MEM_ADDR = r_addr;

  assign BACKGROUND_EN = SPRITES_EN[7];
  assign BLUE_EN = SPRITES_EN[6];
  assign GREEN_EN = SPRITES_EN[5];
  assign RED_EN = SPRITES_EN[4];
  assign YELLOW_EN = SPRITES_EN[3];
  assign LOSE_EN = SPRITES_EN[2];
  assign WIN_EN = SPRITES_EN[1];
  assign PWR_EN = SPRITES_EN[0];
endmodule
