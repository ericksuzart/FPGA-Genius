// The memory_decoder module serves as an interface between the memory output
// and the pixel_decoder module, decoding the pixel codes from the memory and
// providing the corresponding RGB values as output.
module memory_decoder
(
  input wire  [15:0] MEM_OUT,
  output wire [47:0] MEM_RGB
);
  wire [7:0] CODE0, CODE1;
  wire [23:0] RGB0, RGB1;

  assign CODE0 = MEM_OUT[15:8]; // first pixel
  assign CODE1 = MEM_OUT[7:0];  // second pixel

  pixel_decoder pixel0_decoder (
    .CODE(CODE0),
    .RGB(RGB0)
  );

  pixel_decoder pixel1_decoder (
    .CODE(CODE1),
    .RGB(RGB1)
  );

  // Assign output
  assign MEM_RGB = {RGB0, RGB1};
endmodule
