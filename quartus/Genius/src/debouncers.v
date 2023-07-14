module debouncers (
  input clk_2k,
  input [6:0] buttons,
  output [6:0] out
);

  reg [3:0] counter; // 4 bits, 16 max, 2^4 = 16

  always @(posedge clk_2k)
  begin
    if (buttons == 8'b00000000)
    begin
      counter <= 0;
    end

    else if (~&counter) // ~& is NAND, so if all bits are 1, it returns 0
    begin
      counter <= counter + 1;
    end
  end

  assign out = (&counter)? buttons : 8'b00000000; // & is AND, so if all bits are 1, it returns 1

endmodule
