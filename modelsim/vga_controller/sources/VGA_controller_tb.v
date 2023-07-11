`timescale 1ps/1ps

module VGA_controller_tb;

  // Inputs
  reg VGA_CLK;
  reg RESET;
  reg [23:0] RGB;

  // Outputs
  wire VGA_HS;
  wire VGA_VS;
  wire VGA_BLANK_N;
  wire [7:0] VGA_R;
  wire [7:0] VGA_G;
  wire [7:0] VGA_B;
  wire DISP_EN;
  wire [9:0] X;
  wire [9:0] Y;

  // Instantiate the module under test
  VGA_controller dut (
    .VGA_CLK(VGA_CLK),
    .RESET(RESET),
    .RGB(RGB),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .DISP_EN(DISP_EN),
    .X(X),
    .Y(Y)
  );

  // Clock generation
  always #5 VGA_CLK = ~VGA_CLK;

  // Initialize inputs
  initial begin
    VGA_CLK = 0;
    RESET = 1;
    RGB = 0;

    #10; // Wait for a few clock cycles before releasing reset
    RESET = 0;
  end

endmodule
