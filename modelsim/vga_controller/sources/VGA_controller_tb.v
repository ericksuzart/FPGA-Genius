module VGA_controller_tb;

  // Inputs
  reg VGA_CLK;
  reg RESET;
  reg [23:0] RGB;
  reg [6:0] SPRITES_FLAGS;

  // Outputs
  wire VGA_HS;
  wire VGA_VS;
  wire VGA_BLANK_N;
  wire [7:0] VGA_R;
  wire [7:0] VGA_G;
  wire [7:0] VGA_B;
  wire [7:0] SPRITES_EN;

  // Internal signals
  wire [10:0] X;
  wire [10:0] Y;
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
    .SPRITES_FLAGS(SPRITES_FLAGS),
    .SPRITES_EN(SPRITES_EN),
    .X(X),
    .Y(Y)
  );



  // Clock generation
  reg clk;
  always #5 clk = ~clk;

  // Initialize inputs
  initial begin
    VGA_CLK = 0;
    RESET = 1;
    RGB = 0;
    SPRITES_FLAGS = 0;

    #10 RESET = 0; // Deassert reset

    // Test scenario
    #100;
    RGB = 24'hFF0000; // Set RGB value
    SPRITES_FLAGS = 7'b1111111; // Set sprite flags

    #100;

    // Call the countPulses task
    countPulses();

    $stop;
  end

  // Generate clock
  always begin
    #5;
    VGA_CLK = ~VGA_CLK;
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
