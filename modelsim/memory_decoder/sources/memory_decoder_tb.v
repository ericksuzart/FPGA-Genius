`timescale 1ps/1ps

module memory_decoder_tb;

  // Inputs
  reg [15:0] MEM_OUT;

  // Outputs
  wire [47:0] MEM_RGB;

  // Instantiate the module under test
  memory_decoder dut (
    .MEM_OUT(MEM_OUT),
    .MEM_RGB(MEM_RGB)
  );

  // Initialize inputs
  initial begin
    MEM_OUT = 16'h0000; // Set initial memory output

    // Wait for some time to observe the output signals
    #100;

    // Change memory output to test different pixel codes
    MEM_OUT = 16'hA55A; // eeff41:039be5
    // Wait for some time to observe the updated output signals
    #10;

    MEM_OUT = 16'hf9fa; // 607d8b:546e7a
  end

endmodule
