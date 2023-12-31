// The code essentially acts as a lookup table, where given a specific CODE
// value, it provides the corresponding RGB value.
module pixel_decoder
(
  input wire [7:0]  CODE,
  output reg [23:0] RGB
);
  always @(*)
  begin
    case (CODE)
      8'h00: RGB = 24'hffebee;
      8'h01: RGB = 24'hffcdd2;
      8'h02: RGB = 24'hef9a9a;
      8'h03: RGB = 24'he57373;
      8'h04: RGB = 24'hef5350;
      8'h05: RGB = 24'hf44336;
      8'h06: RGB = 24'he53935;
      8'h07: RGB = 24'hd32f2f;
      8'h08: RGB = 24'hc62828;
      8'h09: RGB = 24'hb71c1c;
      8'h0a: RGB = 24'hff8a80;
      8'h0b: RGB = 24'hff5252;
      8'h0c: RGB = 24'hff1744;
      8'h0d: RGB = 24'hd50000;
      8'h0e: RGB = 24'hfce4ec;
      8'h0f: RGB = 24'hf8bbd0;
      8'h10: RGB = 24'hf48fb1;
      8'h11: RGB = 24'hf06292;
      8'h12: RGB = 24'hec407a;
      8'h13: RGB = 24'he91e63;
      8'h14: RGB = 24'hd81b60;
      8'h15: RGB = 24'hc2185b;
      8'h16: RGB = 24'had1457;
      8'h17: RGB = 24'h880e4f;
      8'h18: RGB = 24'hff80ab;
      8'h19: RGB = 24'hff4081;
      8'h1a: RGB = 24'hf50057;
      8'h1b: RGB = 24'hc51162;
      8'h1c: RGB = 24'hf3e5f5;
      8'h1d: RGB = 24'he1bee7;
      8'h1e: RGB = 24'hce93d8;
      8'h1f: RGB = 24'hba68c8;
      8'h20: RGB = 24'hab47bc;
      8'h21: RGB = 24'h9c27b0;
      8'h22: RGB = 24'h8e24aa;
      8'h23: RGB = 24'h7b1fa2;
      8'h24: RGB = 24'h6a1b9a;
      8'h25: RGB = 24'h4a148c;
      8'h26: RGB = 24'hea80fc;
      8'h27: RGB = 24'he040fb;
      8'h28: RGB = 24'hd500f9;
      8'h29: RGB = 24'haa00ff;
      8'h2a: RGB = 24'hede7f6;
      8'h2b: RGB = 24'hd1c4e9;
      8'h2c: RGB = 24'hb39ddb;
      8'h2d: RGB = 24'h9575cd;
      8'h2e: RGB = 24'h7e57c2;
      8'h2f: RGB = 24'h673ab7;
      8'h30: RGB = 24'h5e35b1;
      8'h31: RGB = 24'h512da8;
      8'h32: RGB = 24'h4527a0;
      8'h33: RGB = 24'h311b92;
      8'h34: RGB = 24'hb388ff;
      8'h35: RGB = 24'h7c4dff;
      8'h36: RGB = 24'h651fff;
      8'h37: RGB = 24'h6200ea;
      8'h38: RGB = 24'he8eaf6;
      8'h39: RGB = 24'hc5cae9;
      8'h3a: RGB = 24'h9fa8da;
      8'h3b: RGB = 24'h7986cb;
      8'h3c: RGB = 24'h5c6bc0;
      8'h3d: RGB = 24'h3f51b5;
      8'h3e: RGB = 24'h3949ab;
      8'h3f: RGB = 24'h303f9f;
      8'h40: RGB = 24'h283593;
      8'h41: RGB = 24'h1a237e;
      8'h42: RGB = 24'h8c9eff;
      8'h43: RGB = 24'h536dfe;
      8'h44: RGB = 24'h3d5afe;
      8'h45: RGB = 24'h304ffe;
      8'h46: RGB = 24'he3f2fd;
      8'h47: RGB = 24'hbbdefb;
      8'h48: RGB = 24'h90caf9;
      8'h49: RGB = 24'h64b5f6;
      8'h4a: RGB = 24'h42a5f5;
      8'h4b: RGB = 24'h2196f3;
      8'h4c: RGB = 24'h1e88e5;
      8'h4d: RGB = 24'h1976d2;
      8'h4e: RGB = 24'h1565c0;
      8'h4f: RGB = 24'h0d47a1;
      8'h50: RGB = 24'h82b1ff;
      8'h51: RGB = 24'h448aff;
      8'h52: RGB = 24'h2979ff;
      8'h53: RGB = 24'h2962ff;
      8'h54: RGB = 24'he1f5fe;
      8'h55: RGB = 24'hb3e5fc;
      8'h56: RGB = 24'h81d4fa;
      8'h57: RGB = 24'h4fc3f7;
      8'h58: RGB = 24'h29b6f6;
      8'h59: RGB = 24'h03a9f4;
      8'h5a: RGB = 24'h039be5;
      8'h5b: RGB = 24'h0288d1;
      8'h5c: RGB = 24'h0277bd;
      8'h5d: RGB = 24'h01579b;
      8'h5e: RGB = 24'h80d8ff;
      8'h5f: RGB = 24'h40c4ff;
      8'h60: RGB = 24'h00b0ff;
      8'h61: RGB = 24'h0091ea;
      8'h62: RGB = 24'he0f7fa;
      8'h63: RGB = 24'hb2ebf2;
      8'h64: RGB = 24'h80deea;
      8'h65: RGB = 24'h4dd0e1;
      8'h66: RGB = 24'h26c6da;
      8'h67: RGB = 24'h00bcd4;
      8'h68: RGB = 24'h00acc1;
      8'h69: RGB = 24'h0097a7;
      8'h6a: RGB = 24'h00838f;
      8'h6b: RGB = 24'h006064;
      8'h6c: RGB = 24'h84ffff;
      8'h6d: RGB = 24'h18ffff;
      8'h6e: RGB = 24'h00e5ff;
      8'h6f: RGB = 24'h00b8d4;
      8'h70: RGB = 24'he0f2f1;
      8'h71: RGB = 24'hb2dfdb;
      8'h72: RGB = 24'h80cbc4;
      8'h73: RGB = 24'h4db6ac;
      8'h74: RGB = 24'h26a69a;
      8'h75: RGB = 24'h009688;
      8'h76: RGB = 24'h00897b;
      8'h77: RGB = 24'h00796b;
      8'h78: RGB = 24'h00695c;
      8'h79: RGB = 24'h004d40;
      8'h7a: RGB = 24'ha7ffeb;
      8'h7b: RGB = 24'h64ffda;
      8'h7c: RGB = 24'h1de9b6;
      8'h7d: RGB = 24'h00bfa5;
      8'h7e: RGB = 24'he8f5e9;
      8'h7f: RGB = 24'hc8e6c9;
      8'h80: RGB = 24'ha5d6a7;
      8'h81: RGB = 24'h81c784;
      8'h82: RGB = 24'h66bb6a;
      8'h83: RGB = 24'h4caf50;
      8'h84: RGB = 24'h43a047;
      8'h85: RGB = 24'h388e3c;
      8'h86: RGB = 24'h2e7d32;
      8'h87: RGB = 24'h1b5e20;
      8'h88: RGB = 24'hb9f6ca;
      8'h89: RGB = 24'h69f0ae;
      8'h8a: RGB = 24'h00e676;
      8'h8b: RGB = 24'h00c853;
      8'h8c: RGB = 24'hf1f8e9;
      8'h8d: RGB = 24'hdcedc8;
      8'h8e: RGB = 24'hc5e1a5;
      8'h8f: RGB = 24'haed581;
      8'h90: RGB = 24'h9ccc65;
      8'h91: RGB = 24'h8bc34a;
      8'h92: RGB = 24'h7cb342;
      8'h93: RGB = 24'h689f38;
      8'h94: RGB = 24'h558b2f;
      8'h95: RGB = 24'h33691e;
      8'h96: RGB = 24'hccff90;
      8'h97: RGB = 24'hb2ff59;
      8'h98: RGB = 24'h76ff03;
      8'h99: RGB = 24'h64dd17;
      8'h9a: RGB = 24'hf9fbe7;
      8'h9b: RGB = 24'hf0f4c3;
      8'h9c: RGB = 24'he6ee9c;
      8'h9d: RGB = 24'hdce775;
      8'h9e: RGB = 24'hd4e157;
      8'h9f: RGB = 24'hcddc39;
      8'ha0: RGB = 24'hc0ca33;
      8'ha1: RGB = 24'hafb42b;
      8'ha2: RGB = 24'h9e9d24;
      8'ha3: RGB = 24'h827717;
      8'ha4: RGB = 24'hf4ff81;
      8'ha5: RGB = 24'heeff41;
      8'ha6: RGB = 24'hc6ff00;
      8'ha7: RGB = 24'haeea00;
      8'ha8: RGB = 24'hfffde7;
      8'ha9: RGB = 24'hfff9c4;
      8'haa: RGB = 24'hfff59d;
      8'hab: RGB = 24'hfff176;
      8'hac: RGB = 24'hffee58;
      8'had: RGB = 24'hffeb3b;
      8'hae: RGB = 24'hfdd835;
      8'haf: RGB = 24'hfbc02d;
      8'hb0: RGB = 24'hf9a825;
      8'hb1: RGB = 24'hf57f17;
      8'hb2: RGB = 24'hffff8d;
      8'hb3: RGB = 24'hffff00;
      8'hb4: RGB = 24'hffea00;
      8'hb5: RGB = 24'hffd600;
      8'hb6: RGB = 24'hfff8e1;
      8'hb7: RGB = 24'hffecb3;
      8'hb8: RGB = 24'hffe082;
      8'hb9: RGB = 24'hffd54f;
      8'hba: RGB = 24'hffca28;
      8'hbb: RGB = 24'hffc107;
      8'hbc: RGB = 24'hffb300;
      8'hbd: RGB = 24'hffa000;
      8'hbe: RGB = 24'hff8f00;
      8'hbf: RGB = 24'hff6f00;
      8'hc0: RGB = 24'hffe57f;
      8'hc1: RGB = 24'hffd740;
      8'hc2: RGB = 24'hffc400;
      8'hc3: RGB = 24'hffab00;
      8'hc4: RGB = 24'hfff3e0;
      8'hc5: RGB = 24'hffe0b2;
      8'hc6: RGB = 24'hffcc80;
      8'hc7: RGB = 24'hffb74d;
      8'hc8: RGB = 24'hffa726;
      8'hc9: RGB = 24'hff9800;
      8'hca: RGB = 24'hfb8c00;
      8'hcb: RGB = 24'hf57c00;
      8'hcc: RGB = 24'hef6c00;
      8'hcd: RGB = 24'he65100;
      8'hce: RGB = 24'hffd180;
      8'hcf: RGB = 24'hffab40;
      8'hd0: RGB = 24'hff9100;
      8'hd1: RGB = 24'hff6d00;
      8'hd2: RGB = 24'hfbe9e7;
      8'hd3: RGB = 24'hffccbc;
      8'hd4: RGB = 24'hffab91;
      8'hd5: RGB = 24'hff8a65;
      8'hd6: RGB = 24'hff7043;
      8'hd7: RGB = 24'hff5722;
      8'hd8: RGB = 24'hf4511e;
      8'hd9: RGB = 24'he64a19;
      8'hda: RGB = 24'hd84315;
      8'hdb: RGB = 24'hbf360c;
      8'hdc: RGB = 24'hff9e80;
      8'hdd: RGB = 24'hff6e40;
      8'hde: RGB = 24'hff3d00;
      8'hdf: RGB = 24'hdd2c00;
      8'he0: RGB = 24'hefebe9;
      8'he1: RGB = 24'hd7ccc8;
      8'he2: RGB = 24'hbcaaa4;
      8'he3: RGB = 24'ha1887f;
      8'he4: RGB = 24'h8d6e63;
      8'he5: RGB = 24'h795548;
      8'he6: RGB = 24'h6d4c41;
      8'he7: RGB = 24'h5d4037;
      8'he8: RGB = 24'h4e342e;
      8'he9: RGB = 24'h3e2723;
      8'hea: RGB = 24'hfafafa;
      8'heb: RGB = 24'hf5f5f5;
      8'hec: RGB = 24'heeeeee;
      8'hed: RGB = 24'he0e0e0;
      8'hee: RGB = 24'hbdbdbd;
      8'hef: RGB = 24'h9e9e9e;
      8'hf0: RGB = 24'h757575;
      8'hf1: RGB = 24'h616161;
      8'hf2: RGB = 24'h424242;
      8'hf3: RGB = 24'h212121;
      8'hf4: RGB = 24'heceff1;
      8'hf5: RGB = 24'hcfd8dc;
      8'hf6: RGB = 24'hb0bec5;
      8'hf7: RGB = 24'h90a4ae;
      8'hf8: RGB = 24'h78909c;
      8'hf9: RGB = 24'h607d8b;
      8'hfa: RGB = 24'h546e7a;
      8'hfb: RGB = 24'h455a64;
      8'hfc: RGB = 24'h37474f;
      8'hfd: RGB = 24'h263238;
      8'hfe: RGB = 24'h000000;
      8'hff: RGB = 24'hffffff;
    endcase
  end
endmodule
