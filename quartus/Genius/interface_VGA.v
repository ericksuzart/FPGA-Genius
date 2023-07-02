module vga_interface(
  VGA_CLK,
  reset,
  R,
  G,
  B,
  VGA_R,
  VGA_G,
  VGA_B,
  VGA_BLANK_N,
  VGA_VS,
  VGA_HS
);

input VGA_CLK, reset;

output  [7:0] VGA_R;
output  [7:0] VGA_G;
output  [7:0] VGA_B;
output VGA_BLANK_N;
output VGA_VS;
output VGA_HS;


//parameter sync = 95;
//parameter b_porch = sync + 47;
//parameter d_interval = b_porch + 635;
//parameter f_porch = d_interval + 15;

reg[9:0] count_h;
reg[9:0] count_v;


always @(posedge VGA_CLK) begin
  if (reset) begin
    count_h <= 0;
    count_v <= 0;
  end
  else begin
    count_h <= count_h + 1;
  end
  if (count_h == 799) begin
    count_h <= 0;
    count_v <= count_v + 1;
  end
  if (count_v == 525) begin
    count_v <= 0;
  end
end

assign VGA_HS = (count_h < 95) ? 1'b0: 1'b1;
assign VGA_VS = (count_v < 2) ? 1'b0: 1'b1;
assign VGA_BLANK_N = (count_h < 143) || (count_h > 778) || (count_v < 35) || (count_v > 515) ? 1'b0: 1'b1;


assign VGA_R = 255;
assign VGA_G = 0;
assign VGA_B = 0;


endmodule