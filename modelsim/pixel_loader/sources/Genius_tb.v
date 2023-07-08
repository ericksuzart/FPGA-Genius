`timescale 1ps/1ps
module Genius_top_level_tb;

  // Inputs
  reg CLOCK_25;
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
  wire MEM_CLK;
  wire [23:0] RGB;

  // Test variables
  reg [10:0] Memory; // 2^11 = 2048 values
  integer hash;

  // Instantiate the module under test
  Genius_top_level dut (
    .CLOCK_25(CLOCK_25),
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
    .VGA_R(VGA_R),
    .MEM_CLK(MEM_CLK),
    .RGB(RGB)
  );
  // Clock generation
  always #5 CLOCK_50 = ~CLOCK_50;
  always #10 CLOCK_25 = ~CLOCK_25;

  // Initialize inputs
  initial begin
    CLOCK_25 = 0;
    CLOCK_50 = 0;
    wren = 0;
    data = 0;
    SW = 0;
    hash = 0;
    #10; // Wait for a few clock cycles before applying inputs
    #50 SW[0] = 1; //reset 
    #100 SW[0] = 0; // reset
    CheckHash();

    // 402652140 is the hash of the image in the memory
    if (hash != 402652140)
      $display("Test failed: expected hash = 402652140, actual hash = %d", hash);
    else
      $display("Test passed, module works as expected");

    #100 $stop;
  end

  task CheckHash;
    begin
      # 150 // Wait for the output to settle
      @(posedge DISP_EN)
      begin
        repeat (64)
        begin
          # 20;
          hash = hash + RGB;
          // print(f"{RGB} ({int(RGB, 16)}) \t-> {hash}")
          $display("%h (%d) -> %d", RGB, RGB, hash);
        end

        # 100;
      end
    end
  endtask

endmodule
