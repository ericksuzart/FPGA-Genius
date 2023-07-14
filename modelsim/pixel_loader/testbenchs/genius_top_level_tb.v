module genius_top_level_tb;

  // Inputs
  reg CLOCK_50;
  reg CLOCK_25;
  reg BLUE_EN;
  reg GREEN_EN;
  reg RED_EN;
  reg YELLOW_EN;
  reg LOSE_EN;
  reg WIN_EN;
  reg PWR_EN;
  reg RESET;

  // Outputs
  wire VGA_HS;
  wire VGA_VS;
  wire [9:0] X;
  wire [9:0] Y;
  wire VGA_BLANK_N;
  wire VGA_CLK;
  wire [7:0] VGA_B;
  wire [7:0] VGA_G;
  wire [7:0] VGA_R;
  wire [7:0] SPRITES_EN;

  assign SPRITES_EN = {BLUE_EN,GREEN_EN,RED_EN,YELLOW_EN,LOSE_EN,WIN_EN,PWR_EN};

  // Instantiate the module under test
  genius_top_level uut (
    .CLOCK_50(CLOCK_50),
    .CLOCK_25(CLOCK_25),
    .BLUE_EN(BLUE_EN),
    .GREEN_EN(GREEN_EN),
    .RED_EN(RED_EN),
    .YELLOW_EN(YELLOW_EN),
    .LOSE_EN(LOSE_EN),
    .WIN_EN(WIN_EN),
    .PWR_EN(PWR_EN),
    .RESET(RESET),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .X(X),
    .Y(Y),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_CLK(VGA_CLK),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_R(VGA_R)
  );

  // Clock generation
  reg initial_delay = 1;
  reg [7:0] clk_count = 0;
  always #5 CLOCK_50 = ~CLOCK_50;
  always #10 CLOCK_25 = ~CLOCK_25;

  initial
  begin
    // Initialize inputs
    CLOCK_50 = 0;
    CLOCK_25 = 0;
    BLUE_EN = 0;
    GREEN_EN = 0;
    RED_EN = 0;
    YELLOW_EN = 0;
    LOSE_EN = 0;
    WIN_EN = 0;
    PWR_EN = 0;
    RESET = 0;

    // Wait for the module to stabilize
    #10;

    // Apply reset
    RESET = 1;
    #10;
    RESET = 0;

    @(posedge X);
    // Test Case 1: Enable and read from different sprites
    BLUE_EN = 1; // Enable the first sprite
    #1000;
    BLUE_EN = 0;
    GREEN_EN = 1; // Enable the second sprite
    #1000;
    GREEN_EN = 0;
    RED_EN = 1; // Enable the third sprite
    #1000;
    RED_EN = 0;
    
    #500;
    // Test Case 2: Enable multiple sprites simultaneously
    BLUE_EN = 1; // Enable the first sprite
    GREEN_EN = 1; // Enable the second sprite
    RED_EN = 1; // Enable the third sprite
    YELLOW_EN = 1; // Enable the fourth sprite
    #1000;
    BLUE_EN = 0;
    GREEN_EN = 0;
    RED_EN = 0;
    YELLOW_EN = 0;
    
    #500;
    // Test Case 3: Enable all sprites
    BLUE_EN = 1; // Enable the first sprite
    GREEN_EN = 1; // Enable the second sprite
    RED_EN = 1; // Enable the third sprite
    YELLOW_EN = 1; // Enable the fourth sprite
    LOSE_EN = 1; // Enable the fifth sprite
    WIN_EN = 1; // Enable the sixth sprite
    PWR_EN = 1; // Enable the seventh sprite
    #1000;
    BLUE_EN = 0;
    GREEN_EN = 0;
    RED_EN = 0;
    YELLOW_EN = 0;
    LOSE_EN = 0;
    WIN_EN = 0;
    PWR_EN = 0;

    #500;
    countPulses();
	
    $stop;
  end
  task countPulses;
    integer count[7:0];
    integer i;
    begin
      // Initialize variable
      i = 0;
      for (i = 0; i < 8; i = i + 1)
      begin
        count[i] = 0;
      end
      i = 0;

      // Wait for the start of a frame
      @(posedge VGA_CLK);
      @(posedge VGA_HS);
      @(posedge VGA_VS);

      // Count the pulses for each bit in SPRITES_EN
      repeat(419200)
      begin
        @(posedge VGA_CLK) #5;

        for (i = 0; i < 8; i = i + 1)
        begin
          if (SPRITES_EN[i] == 1)
          begin
            count[i] = count[i] + 1;
          end
        end
      end

      i = 0;
      // Display the pulse count for each bit
      $display("Pixel count for each bit in SPRITES_EN in one frametime:");
      for (i = 0; i < 8; i = i + 1)
      begin
        $display("Bit %d: %d pixels", i, count[i]);
      end
      #5;
    end
  endtask

endmodule
