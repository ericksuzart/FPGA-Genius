`timescale 1ns / 1ps

module memory_block_tb;

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

  localparam BACKGROUND_MAX_ADDR = 20;
  localparam BLUE_MAX_ADDR = 20;
  localparam GREEN_MAX_ADDR = 20;
  localparam RED_MAX_ADDR = 20;
  localparam YELLOW_MAX_ADDR = 20;
  localparam LOSE_MAX_ADDR = 20;
  localparam WIN_MAX_ADDR = 20;
  localparam PWR_MAX_ADDR = 20;
  localparam  BACKGROUND = 3'b000,
              POWER_BTN_ON = 3'b001,
              RED_BTN_ON = 3'b010,
              GREEN_BTN_ON = 3'b011,
              BLUE_BTN_ON = 3'b100,
              YELLOW_BTN_ON = 3'b101,
              WIN_SCREEN = 3'b110,
              LOSE_SCREEN = 3'b111;
  initial begin
    // Initialize inputs
    IN_CLK = 0;
    IN_ADDR = 16'h0000;
    SELECTOR = 3'b000;

    // Wait for memory block initialization
    #15;

    // Test the first 20 addresses of each memory
    repeat (8) begin
      case (SELECTOR)
        BACKGROUND: begin
          for (IN_ADDR = 0; IN_ADDR < BACKGROUND_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        POWER_BTN_ON: begin
          for (IN_ADDR = 0; IN_ADDR < PWR_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        RED_BTN_ON: begin
          for (IN_ADDR = 0; IN_ADDR < BLUE_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        GREEN_BTN_ON: begin
          for (IN_ADDR = 0; IN_ADDR < GREEN_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        BLUE_BTN_ON: begin
          for (IN_ADDR = 0; IN_ADDR < RED_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        YELLOW_BTN_ON: begin
          for (IN_ADDR = 0; IN_ADDR < YELLOW_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        WIN_SCREEN: begin
          for (IN_ADDR = 0; IN_ADDR < WIN_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end

        LOSE_SCREEN: begin
          for (IN_ADDR = 0; IN_ADDR < LOSE_MAX_ADDR; IN_ADDR = IN_ADDR + 1) begin
            #10;
            $display("Test Case: SELECTOR = %b, IN_ADDR = %h", SELECTOR, IN_ADDR);
            $display("MEM_RGB = %h", MEM_RGB);
          end
        end
      endcase
      SELECTOR = SELECTOR + 1;
    end

    // Finish simulation
    $stop;
  end

endmodule
