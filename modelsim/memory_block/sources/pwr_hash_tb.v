`timescale 1ns / 1ps

module pwr_hash_tb;

  reg IN_CLK;
  reg [15:0] IN_ADDR;
  reg [2:0] SELECTOR;
  wire [47:0] MEM_RGB;

  memory_block dut (
    .IN_CLK(IN_CLK),
    .IN_ADDR(IN_ADDR),
    .SELECTOR(SELECTOR),
    .MEM_RGB(MEM_RGB)
  );

  always begin
    #5;
    IN_CLK = ~IN_CLK;
  end

  localparam PWR_MAX_ADDR = 252;
  localparam TRUE_HASH = 64'd36393120404497109;

  localparam  BACKGROUND = 3'b000,
              POWER_BTN_ON = 3'b001,
              RED_BTN_ON = 3'b010,
              GREEN_BTN_ON = 3'b011,
              BLUE_BTN_ON = 3'b100,
              YELLOW_BTN_ON = 3'b101,
              WIN_SCREEN = 3'b110,
              LOSE_SCREEN = 3'b111;

  reg [63:0] hash;

  initial begin
    // Initialize inputs
    IN_CLK = 0;
    IN_ADDR = 16'h0000;
    SELECTOR = POWER_BTN_ON;
    hash = 0;

    // Wait for memory block initialization
    #15;

    CheckHash();

    // TRUE_HASH is the hash of the image in the memory, calculed using the
    // python script
    if (hash != TRUE_HASH)
      $display("Test failed: expected hash = %d, actual hash = %d", TRUE_HASH, hash);
    else
      $display("Test passed, module works as expected");
  
    // Finish simulation
    $stop;
  end

  task CheckHash;
    begin
      # 150 // Wait for the output to settle

      // Iterate over all addresses of the power button memory
      for (IN_ADDR = 0; IN_ADDR < PWR_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
        @(posedge IN_CLK) // Wait for the next clock cycle
        begin
          #10;
          hash = hash + MEM_RGB;
          $display("%h (%d) -> %d", MEM_RGB, MEM_RGB, hash);
        end
      end

      # 100;
    end
  endtask

endmodule
