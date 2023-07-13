module pixel_loader_tb;

  // Inputs
  reg RESET;
  reg CLK;
  reg [47:0] DATA_IN;
  reg [7:0] SPRITES_EN;

  // Outputs
  wire MEM_CLK;
  wire [15:0] MEM_ADDR;
  wire [2:0] MEM_SEL;
  wire [23:0] RGB;

  // Instantiate the module under test
  pixel_loader uut (
    .RESET(RESET),
    .CLK(CLK),
    .DATA_IN(DATA_IN),
    .SPRITES_EN(SPRITES_EN),
    .MEM_CLK(MEM_CLK),
    .MEM_ADDR(MEM_ADDR),
    .MEM_SEL(MEM_SEL),
    .RGB(RGB)
  );

  // Clock generation
  reg initial_delay = 1;
  reg [7:0] clk_count = 0;
  always #5 CLK = ~CLK;

  initial
  begin
    // Initialize inputs
    RESET = 0;
    CLK = 0;
    DATA_IN = 0;
    SPRITES_EN = 0;

    // Wait for the module to stabilize
    #10;

    // Apply reset
    RESET = 1;
    #10;
    RESET = 0;

    // Test Case 1: Enable and read from different sprites
    SPRITES_EN = 8'b00000001; // Enable the first sprite
    #20;
    SPRITES_EN = 8'b00000010; // Enable the second sprite
    #20;
    SPRITES_EN = 8'b00000100; // Enable the third sprite
    #20;

    // Test Case 2: Enable multiple sprites simultaneously
    SPRITES_EN = 8'b00001111; // Enable the first four sprites
    #20;

    // Test Case 3: Enable all sprites
    SPRITES_EN = 8'b11111111; // Enable all sprites
    #20;

    // Test Case 4: Enable and disable sprites dynamically
    SPRITES_EN = 8'b00000001; // Enable the first sprite
    #20;
    SPRITES_EN = 8'b00000011; // Enable the first two sprites
    #20;
    SPRITES_EN = 8'b00000110; // Enable the second and third sprites
    #20;
    SPRITES_EN = 8'b00000000; // Disable all sprites
    #20;

    // Finish the simulation
    $stop;
  end

endmodule
