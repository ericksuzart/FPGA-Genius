module debouncer (
  input clk_2k,
  input button,
  output out
);

  reg [3:0] counter; // 4 bits, 16 max, 2^4 = 16

  always @(posedge clk_2k)
  begin
    if (button)
    begin
      counter <= 0;
    end

    else if (~&counter) // ~& is NAND, so if all bits are 1, it returns 0
    begin
      counter <= counter + 1;
    end
  end

  assign out = &counter; // & is AND, so if all bits are 1, it returns 1

endmodule