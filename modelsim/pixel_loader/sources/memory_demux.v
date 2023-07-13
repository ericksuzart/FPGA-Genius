// The purpose of this module is to select the appropriate pixel, address, and
// clock signals based on the SELECTOR input. It functions as a demultiplexer
// for memory locations, allowing the selection of a specific memory location
// and retrieving the corresponding data from that location.
module memory_demux
(
  input [2:0] SELECTOR,
  input [15:0] IN_ADDR,
  input IN_CLK,

  // ----- Input Pixels -----
  input [15:0] BACKGROUND_PX,
  input [15:0] POWER_BTN_PX,
  input [15:0] RED_BTN_PX,
  input [15:0] GREEN_BTN_PX,
  input [15:0] BLUE_BTN_PX,
  input [15:0] YELLOW_BTN_PX,
  input [15:0] WIN_SCREEN_PX,
  input [15:0] LOSE_SCREEN_PX,

  output reg [15:0] OUT_PX,

  // ----- Adresses -----
  output reg [15:0] BACKGROUND_ADDR,  // MAX = 360 x 360 / 2 = 64800
  output reg [7:0]  POWER_BTN_ADDR,   // MAX = 22 x 21 / 2 = 231
  output reg [13:0] RED_BTN_ADDR,     // MAX = 169 x 168 / 2 = 14196
  output reg [13:0] GREEN_BTN_ADDR,   // MAX = 168 x 168 / 2 = 14112
  output reg [13:0] BLUE_BTN_ADDR,    // MAX = 168 x 167 / 2 = 14028
  output reg [13:0] YELLOW_BTN_ADDR,  // MAX = 168 x 167 / 2 = 14028
  output reg [14:0] WIN_SCREEN_ADDR,  // MAX = 360 x 116 / 2 = 20880
  output reg [14:0] LOSE_SCREEN_ADDR, // MAX = 360 x 134 / 2 = 24120

  // ----- Clocks -----
  output reg BACKGROUND_CLK,
  output reg POWER_BTN_CLK,
  output reg RED_BTN_CLK,
  output reg GREEN_BTN_CLK,
  output reg BLUE_BTN_CLK,
  output reg YELLOW_BTN_CLK,
  output reg WIN_SCREEN_CLK,
  output reg LOSE_SCREEN_CLK
);

  parameter   BACKGROUND = 3'b000,
              POWER_BTN_ON = 3'b001,
              RED_BTN_ON = 3'b010,
              GREEN_BTN_ON = 3'b011,
              BLUE_BTN_ON = 3'b100,
              YELLOW_BTN_ON = 3'b101,
              WIN_SCREEN = 3'b110,
              LOSE_SCREEN = 3'b111;

  always @(*)
  begin
    OUT_PX = 0;
    BACKGROUND_ADDR = 0;
    BACKGROUND_CLK = 0;
    POWER_BTN_ADDR = 0;
    POWER_BTN_CLK = 0;
    RED_BTN_ADDR = 0;
    RED_BTN_CLK = 0;
    GREEN_BTN_ADDR = 0;
    GREEN_BTN_CLK = 0;
    BLUE_BTN_ADDR = 0;
    BLUE_BTN_CLK = 0;
    YELLOW_BTN_ADDR = 0;
    YELLOW_BTN_CLK = 0;
    WIN_SCREEN_ADDR = 0;
    WIN_SCREEN_CLK = 0;
    LOSE_SCREEN_ADDR = 0;
    LOSE_SCREEN_CLK = 0;

    case (SELECTOR)
      BACKGROUND:
      begin
        BACKGROUND_ADDR = IN_ADDR;
        BACKGROUND_CLK = IN_CLK;
        OUT_PX = BACKGROUND_PX;
      end

      POWER_BTN_ON:
      begin
        POWER_BTN_ADDR = IN_ADDR[7:0];
        POWER_BTN_CLK = IN_CLK;
        OUT_PX = POWER_BTN_PX;
      end

      RED_BTN_ON:
      begin
        RED_BTN_ADDR = IN_ADDR[13:0];
        RED_BTN_CLK = IN_CLK;
        OUT_PX = RED_BTN_PX;
      end

      GREEN_BTN_ON:
      begin
        GREEN_BTN_ADDR = IN_ADDR[13:0];
        GREEN_BTN_CLK = IN_CLK;
        OUT_PX = GREEN_BTN_PX;
      end

      BLUE_BTN_ON:
      begin
        BLUE_BTN_ADDR = IN_ADDR[13:0];
        BLUE_BTN_CLK = IN_CLK;
        OUT_PX = BLUE_BTN_PX;
      end

      YELLOW_BTN_ON:
      begin
        YELLOW_BTN_ADDR = IN_ADDR[13:0];
        YELLOW_BTN_CLK = IN_CLK;
        OUT_PX = YELLOW_BTN_PX;
      end

      WIN_SCREEN:
      begin
        WIN_SCREEN_ADDR = IN_ADDR[14:0];
        WIN_SCREEN_CLK = IN_CLK;
        OUT_PX = WIN_SCREEN_PX;
      end

      LOSE_SCREEN:
      begin
        LOSE_SCREEN_ADDR = IN_ADDR[14:0];
        LOSE_SCREEN_CLK = IN_CLK;
        OUT_PX = LOSE_SCREEN_PX;
      end
    endcase
  end
endmodule
