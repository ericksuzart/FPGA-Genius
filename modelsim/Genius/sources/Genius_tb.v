`timescale 1ps/1ps
module Genius_top_level_tb;

  // Inputs
  reg CLOCK_50;
  reg wren;
  reg [47:0] data;
  reg [0:0] SW;

  // Outputs
  wire VGA_HS;
  wire VGA_VS;
  wire VGA_BLANK_N;
  wire DISP_EN;
  wire VGA_CLK;
  wire c1;
  wire [7:0] VGA_B;
  wire [7:0] VGA_G;
  wire [7:0] VGA_R;

  // Instantiate the module under test
  Genius_top_level dut (
    .CLOCK_50(CLOCK_50),
    .wren(wren),
    .data(data),
    .SW(SW),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_BLANK_N(VGA_BLANK_N),
    .DISP_EN(DISP_EN),
    .VGA_CLK(VGA_CLK),
    .c1(c1),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_R(VGA_R)
  );
  // Clock generation
  always #5 CLOCK_50 = ~CLOCK_50;

  // Initialize inputs
  initial begin
    // $monitor("tempo = %t clock = %b reset = %b wren = %b clock_ram = %b clock_rom = %b a_ram = %d a_rom = %d i = %d q_ram = %d q_rom = %d", $time, clock, reset, wren, clock_ram, clock_rom, a_ram, a_rom, i, q_ram, q_rom);
    $monitor("time = %t, clk= %b, HS= %b, VS= %b, DISP_EN= %b, R= %b, G= %b, B= %b", $time, VGA_CLK, VGA_HS, VGA_VS, DISP_EN, VGA_R, VGA_G, VGA_B);
    CLOCK_50 = 0;
    wren = 0;
    data = 0;
    SW = 0;
    #10; // Wait for a few clock cycles before applying inputs
    #50 SW[0] = 1; //reset 
    #100 SW[0] = 0; // reset
    #60000 $stop; // End the simulation
  end

endmodule
