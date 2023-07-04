module VGA_controller
(
    // VGA I/O.
    input wire  VGA_CLK,        // VGA clock.
    input wire  RESET,          // Reset.
    input wire  [23:0] RGB,      // PIXEL

    output wire VGA_HS,         // Horizontal sync out.
    output wire VGA_VS,         // Vertical sync out.
    output wire VGA_BLANK_N,    // Active video signal.

    output wire [7:0] VGA_R,    // Red video signal.
    output wire [7:0] VGA_G,    // Green video signal.
    output wire [7:0] VGA_B,    // Blue video signal.
    // Game I/O
    output wire DISP_EN         // Enable display.
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

// Game parameters (constants)
parameter G_HS = 360;    // Horizontal size.
parameter G_VS = 360;    // Vertical size.
parameter G_X =  120;    // Horizontal start position in the screen.
parameter G_Y =  60;     // Vertical start position in the screen.

// Registers for storing the horizontal & vertical counters.
reg [9:0] h_c;
reg [9:0] v_c;

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

assign DISP_EN = (h_c >= G_X + H_OFF && h_c < G_X + H_OFF + G_HS && v_c >= G_Y + V_OFF && v_c < G_Y + V_OFF + G_VS)? 1:0;

assign VGA_R = (DISP_EN)? 255 : 0;
assign VGA_G = (DISP_EN)?   0 : 0;
assign VGA_B = (DISP_EN)?   0 : 255;


endmodule
