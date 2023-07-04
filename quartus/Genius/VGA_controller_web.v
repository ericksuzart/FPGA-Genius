module syncVGAGen
(
    input  wire       px_clk,        // Pixel clock.
    output wire [9:0] x_px,          // X position for actual pixel.
    output wire [9:0] y_px,          // Y position for actual pixel.
    output wire       hsync,         // Horizontal sync out.
    output wire       vsync,         // Vertical sync out.
    output wire       activevideo    // Active video.
);

// TODO: Utilizar una tabla de parámetros para obtener los valores para
//       distintas resoluciones y poder modificar desde pines externos.
//
// https://www.digikey.com/eewiki/pages/viewpage.action?pageId=15925278#VGAController(VHDL)-Appendix:VGATimingSpecifications
//
// parameter [8:0] vga_table = {"800x600@72",72,50,800,56,120,64,600,37,6,23,'p','p'},
//
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
parameter H_DISP = 640;               // Width of visible pixels.
parameter H_FPORCH = 16;                         // Horizontal front porch length.
parameter H_SYNC = 96;                     // Hsync pulse length.
parameter H_BPORCH = 64;                         // Horizontal back porch length.
parameter V_DISP = 480;               // Height of visible lines.
parameter V_FPORCH = 11;                         // Vertical front porch length.
parameter V_SYNC = 2;                       // Vsync pulse length.
parameter V_BPORCH = 31;                         // Vertical back porch length.
parameter H_OFF = H_FPORCH + H_SYNC + H_BPORCH;      // Hided pixels in one line.
parameter V_OFF = V_FPORCH + V_SYNC + V_BPORCH;      // Hided lines in one frame.
parameter H_PIXELS = H_OFF + H_DISP;  // Total horizontal pixels.
parameter V_LINES = V_OFF + V_DISP;   // Total lines.

// Registers for storing the horizontal & vertical counters.
reg [9:0] h_counter;
reg [9:0] v_counter;

reg [9:0] x_px;          // X position for actual pixel.
reg [9:0] y_px;          // Y position for actual pixel.

// Counting pixels.
always @(posedge px_clk)
begin
    // Keep counting until the end of the line.
    if (h_counter < H_PIXELS - 1)
        h_counter <= h_counter + 1;
    else
    // When we hit the end of the line, reset the horizontal
    // counter and increment the vertical counter.
    // If vertical counter is at the end of the frame, then
    // reset that one too.
    begin
        h_counter <= 0;
        if (v_counter < V_LINES - 1)
        v_counter <= v_counter + 1;
        else
        v_counter <= 0;
    end
end

// Generate sync pulses (active low) and active video.
assign hsync = (h_counter >= H_FPORCH && h_counter < H_FPORCH + H_SYNC) ? 0:1;
assign vsync = (v_counter >= V_FPORCH && v_counter < V_FPORCH + V_SYNC) ? 0:1;
assign activevideo = (h_counter >= H_OFF && v_counter >= V_OFF) ? 1:0;

// Generate new pixel position.
always @(posedge px_clk)
begin
    // First check if we are within vertical active video range.
    if (activevideo)
    begin
        x_px <= h_counter - H_OFF;
        y_px <= v_counter - V_OFF;
    end
    else
    // We are outside active video range so initial position it's ok.
    begin
        x_px <= 0;
        y_px <= 0;
    end
end

endmodule