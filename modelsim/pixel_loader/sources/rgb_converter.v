// This module converts 4-bit RGB to 8-bit RGB
module rgb_converter (
  input [23:0] rgb_in,
  output reg [47:0] rgb_out
);

always @*
begin
  rgb_out = {rgb_in, rgb_in} | {rgb_in, rgb_in} << 4;
end

endmodule
