module VGA_controller
(
  // VGA I/O.
  input  VGA_CLK,             // VGA clock.
  input  RESET,               // Reset.
  input  [23:0] RGB,          // PIXEL

  output VGA_HS,              // Horizontal sync out.
  output VGA_VS,              // Vertical sync out.
  output VGA_BLANK_N,         // Active video signal.

  output [7:0] VGA_R,         // Red video signal.
  output [7:0] VGA_G,         // Green video signal.
  output [7:0] VGA_B,         // Blue video signal.

  // Game I/O
  input [6:0] SPRITES_FLAGS,  // Flags for 7 sprites
  output [7:0] SPRITES_EN     // Flags for all 8 sprites
);

// VGA timings:
//
// ________|        VIDEO         |________| VIDEO (next line)
//     |-C-|----------D-----------|-E-|
// __   ______________________________   ___________
//   |_|                              |_|
//   |B|
//   |---------------A----------------|
// A - Line/frame time    (H_PIXELS or V_LINES)
// B - Sync pulse lenght  (H_SYNC or V_SYNC) VGA_HS and VGA_VS = 0
// C - Back porch         (H_BPORCH or V_BPORCH)
// D - Active video time  (VGA_BLANK_N = 0)
// E - Front porch        (H_FPORCH or V_FPORCH)


// [*User-Defined_mode,(640X480)]
// https://www.epanorama.net/faq/vga2rgb/calc.html
// PIXEL_CLK        =   25170 // 25.17MHz
// H_DISP           =   640   // Horizontal display
// H_FPORCH         =   16    // Front porch horizontal
// H_SYNC           =   96    // Pulse width horizontal
// H_BPORCH         =   48    // Back porch horizontal
// V_DISP           =   480   // Vertical display
// V_FPORCH         =   11    // Front porch vertical
// V_SYNC           =   2     // Pulse width vertical
// V_BPORCH         =   31    // Back porch vertical
// Video structure constants.
parameter H_DISP    = 640;                      // Width of visible pixels.
parameter H_FPORCH  = 16;                       // Horizontal front porch length.
parameter H_SYNC    = 96;                       // Hsync pulse length.
parameter H_BPORCH  = 48;                       // Horizontal back porch length.
parameter V_DISP    = 480;                      // Height of visible lines.
parameter V_FPORCH  = 11;                       // Vertical front porch length.
parameter V_SYNC    = 2;                        // Vsync pulse length.
parameter V_BPORCH  = 31;                       // Vertical back porch length.

parameter H_OFF = H_FPORCH + H_SYNC + H_BPORCH; // Off pixels in one line.
parameter V_OFF = V_FPORCH + V_SYNC + V_BPORCH; // Off lines in one frame.
parameter H_PIXELS = H_OFF + H_DISP;            // Total pixels in one line.
parameter V_LINES = V_OFF + V_DISP;             // Total lines in one frame.

// Background size and position.
parameter BACKGROUND_HS = 360;    // Horizontal size.
parameter BACKGROUND_VS = 360;    // Vertical size.
parameter BACKGROUND_X =  120;    // Horizontal start position in the screen.
parameter BACKGROUND_Y =  60;     // Vertical start position in the screen.

// Blue button
parameter BLUE_HS = 168;          // Horizontal size.
parameter BLUE_VS = 167;          // Vertical size.
parameter BLUE_X =  192;          // Horizontal start position in the screen.
parameter BLUE_Y =  193;          // Vertical start position in the screen.

// Green button
parameter GREEN_HS = 168;       // Horizontal size.
parameter GREEN_VS = 168;       // Vertical size.
parameter GREEN_X =  0;         // Horizontal start position in the screen.
parameter GREEN_Y =  0;         // Vertical start position in the screen.

// Red button
parameter RED_HS = 169;         // Horizontal size.
parameter RED_VS = 168;         // Vertical size.
parameter RED_X =  191;         // Horizontal start position in the screen.
parameter RED_Y =  0;           // Vertical start position in the screen.

// Yellow button
parameter YELLOW_HS = 168;      // Horizontal size.
parameter YELLOW_VS = 167;      // Vertical size.
parameter YELLOW_X =  0;        // Horizontal start position in the screen.
parameter YELLOW_Y =  192;      // Vertical start position in the screen.

// Lose button
parameter LOSE_HS = 360;        // Horizontal size.
parameter LOSE_VS = 134;        // Vertical size.
parameter LOSE_X =  0;          // Horizontal start position in the screen.
parameter LOSE_Y =  113;        // Vertical start position in the screen.

// Win button
parameter WIN_HS = 360;         // Horizontal size.
parameter WIN_VS = 116;         // Vertical size.
parameter WIN_X =  0;           // Horizontal start position in the screen.
parameter WIN_Y =  122;         // Vertical start position in the screen.

// Power button
parameter PWR_HS = 22;          // Horizontal size.
parameter PWR_VS = 21;          // Vertical size.
parameter PWR_X =  169;         // Horizontal start position in the screen.
parameter PWR_Y =  197;         // Vertical start position in the screen.

// Registers for storing the horizontal & vertical counters.
reg [9:0] h_c;
reg [9:0] v_c;
wire [9:0] X;         // X coordinate.
wire [9:0] Y;         // Y coordinate.

wire DISP_EN, BACKGROUND_EN, BLUE_EN, GREEN_EN, RED_EN, YELLOW_EN, LOSE_EN, WIN_EN, PWR_EN;

// Counting pixels.
always @(posedge VGA_CLK)
begin
  if (RESET)
  begin
    h_c <= 0;
    v_c <= 0;
  end else 
  begin
    if (h_c < H_PIXELS - 1)
      h_c <= h_c + 1;
    else
    begin
      h_c <= 0;

      if (v_c < V_LINES - 1)
        v_c <= v_c + 1;
      else
        v_c <= 0;
    end
  end
end

// Generate sync pulses (active low)
assign VGA_HS = (h_c >= H_FPORCH && h_c < H_FPORCH + H_SYNC)? 0:1;
assign VGA_VS = (v_c >= V_FPORCH && v_c < V_FPORCH + V_SYNC)? 0:1;
// Generate inactive video signal (active low), blanking the screen.
assign VGA_BLANK_N = (h_c >= H_OFF && v_c >= V_OFF)? 1:0;

assign DISP_EN = (h_c >= BACKGROUND_X + H_OFF && 
                  h_c < BACKGROUND_X + H_OFF + BACKGROUND_HS &&
                  v_c >= BACKGROUND_Y + V_OFF &&
                  v_c < BACKGROUND_Y + V_OFF + BACKGROUND_VS)? 1:0;

assign X = (DISP_EN)? h_c - BACKGROUND_X - H_OFF : -1;
assign Y = (DISP_EN)? v_c - BACKGROUND_Y - V_OFF : -1;

// Assign the flags for the display of the buttons
assign BACKGROUND_EN = DISP_EN;

assign BLUE_EN = (X >= BLUE_X &&
                  X <= BLUE_X + BLUE_HS &&
                  Y >= BLUE_Y &&
                  Y <= BLUE_Y + BLUE_VS)? SPRITES_FLAGS[0]:0;

assign GREEN_EN = (X >= GREEN_X &&
                   X <= GREEN_X + GREEN_HS &&
                   Y >= GREEN_Y &&
                   Y <= GREEN_Y + GREEN_VS)? SPRITES_FLAGS[1]:0;

assign RED_EN = (X >= RED_X &&
                 X <= RED_X + RED_HS &&
                 Y >= RED_Y &&
                 Y <= RED_Y + RED_VS)? SPRITES_FLAGS[2]:0;

assign YELLOW_EN = (X >= YELLOW_X &&
                    X <= YELLOW_X + YELLOW_HS &&
                    Y >= YELLOW_Y &&
                    Y <= YELLOW_Y + YELLOW_VS)? SPRITES_FLAGS[3]:0;

assign LOSE_EN = (X >= LOSE_X &&
                  X <= LOSE_X + LOSE_HS &&
                  Y >= LOSE_Y &&
                  Y <= LOSE_Y + LOSE_VS)? SPRITES_FLAGS[4]:0;

assign WIN_EN = (X >= WIN_X &&
                 X <= WIN_X + WIN_HS &&
                 Y >= WIN_Y &&
                 Y <= WIN_Y + WIN_VS)? SPRITES_FLAGS[5]:0;

assign PWR_EN = (X >= PWR_X &&
                 X <= PWR_X + PWR_HS &&
                 Y >= PWR_Y &&
                 Y <= PWR_Y + PWR_VS)? SPRITES_FLAGS[6]:0;

// Assign the bus for the enable signals
assign SPRITES_EN = {BACKGROUND_EN, BLUE_EN, GREEN_EN, RED_EN, YELLOW_EN, LOSE_EN, WIN_EN, PWR_EN};

assign VGA_R = (DISP_EN)?  RGB[23:16] : 0;
assign VGA_G = (DISP_EN)?  RGB[15:8]  : 0;
assign VGA_B = (DISP_EN)?  RGB[7:0]   : 0;

endmodule
