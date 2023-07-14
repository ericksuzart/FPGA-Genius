// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Thu Jul 13 02:06:35 2023"

module genius_top_level(
	CLOCK_50,
	CLOCK_25,
	BLUE_EN,
	GREEN_EN,
	RED_EN,
	YELLOW_EN,
	LOSE_EN,
	WIN_EN,
	PWR_EN,
	RESET,
	VGA_HS,
	VGA_VS,
	X,
	Y,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_B,
	VGA_G,
	VGA_R
);


input wire	CLOCK_50;
input wire	CLOCK_25;
input wire	BLUE_EN;
input wire	GREEN_EN;
input wire	RED_EN;
input wire	YELLOW_EN;
input wire	LOSE_EN;
input wire	WIN_EN;
input wire	PWR_EN;
input wire	RESET;
output wire	VGA_HS;
output wire	VGA_VS;
output wire	[9:0] X;
output wire	[9:0] Y;
output wire	VGA_BLANK_N;
output wire	VGA_CLK;
output wire	[7:0] VGA_B;
output wire	[7:0] VGA_G;
output wire	[7:0] VGA_R;

wire	[23:0] VGA_RGB;
wire	[47:0] MEM_RGB;
wire	[7:0] SPRITES_EN;
wire	MEM_CLK;
wire	[15:0] MEM_ADDR;
wire	[2:0] MEM_SEL;

assign	VGA_CLK = CLOCK_25;
wire	[6:0] GDFX_TEMP_SIGNAL_0;


assign	GDFX_TEMP_SIGNAL_0 = {BLUE_EN,GREEN_EN,RED_EN,YELLOW_EN,LOSE_EN,WIN_EN,PWR_EN};

VGA_controller	b2v_inst(
	.VGA_CLK(VGA_CLK),
	.RESET(RESET),
	.RGB(VGA_RGB),
	.SPRITES_FLAGS(GDFX_TEMP_SIGNAL_0),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.X(X),
	.Y(Y),
	.VGA_BLANK_N(VGA_BLANK_N),
	.SPRITES_EN(SPRITES_EN),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R));
	defparam	b2v_inst.BACKGROUND_HS = 360;
	defparam	b2v_inst.BACKGROUND_VS = 360;
	defparam	b2v_inst.BACKGROUND_X = 120;
	defparam	b2v_inst.BACKGROUND_Y = 60;
	defparam	b2v_inst.BLUE_HS = 168;
	defparam	b2v_inst.BLUE_VS = 167;
	defparam	b2v_inst.BLUE_X = 192;
	defparam	b2v_inst.BLUE_Y = 193;
	defparam	b2v_inst.GREEN_HS = 168;
	defparam	b2v_inst.GREEN_VS = 168;
	defparam	b2v_inst.GREEN_X = 0;
	defparam	b2v_inst.GREEN_Y = 0;
	defparam	b2v_inst.H_BPORCH = 48;
	defparam	b2v_inst.H_DISP = 640;
	defparam	b2v_inst.H_FPORCH = 16;
	defparam	b2v_inst.H_SYNC = 96;
	defparam	b2v_inst.LOSE_HS = 360;
	defparam	b2v_inst.LOSE_VS = 134;
	defparam	b2v_inst.LOSE_X = 0;
	defparam	b2v_inst.LOSE_Y = 113;
	defparam	b2v_inst.PWR_HS = 22;
	defparam	b2v_inst.PWR_VS = 21;
	defparam	b2v_inst.PWR_X = 169;
	defparam	b2v_inst.PWR_Y = 197;
	defparam	b2v_inst.RED_HS = 169;
	defparam	b2v_inst.RED_VS = 168;
	defparam	b2v_inst.RED_X = 191;
	defparam	b2v_inst.RED_Y = 0;
	defparam	b2v_inst.V_BPORCH = 31;
	defparam	b2v_inst.V_DISP = 480;
	defparam	b2v_inst.V_FPORCH = 11;
	defparam	b2v_inst.V_SYNC = 2;
	defparam	b2v_inst.WIN_HS = 360;
	defparam	b2v_inst.WIN_VS = 116;
	defparam	b2v_inst.WIN_X = 0;
	defparam	b2v_inst.WIN_Y = 122;
	defparam	b2v_inst.YELLOW_HS = 168;
	defparam	b2v_inst.YELLOW_VS = 167;
	defparam	b2v_inst.YELLOW_X = 0;
	defparam	b2v_inst.YELLOW_Y = 192;


pixel_loader	b2v_inst2(
	.RESET(RESET),
	.CLK(CLOCK_50),
	.DATA_IN(MEM_RGB),
	.SPRITES_EN(SPRITES_EN),
	.MEM_CLK(MEM_CLK),
	.MEM_ADDR(MEM_ADDR),
	.MEM_SEL(MEM_SEL),
	.RGB(VGA_RGB));
	defparam	b2v_inst2.ATIVAR = 2;
	defparam	b2v_inst2.BACKGROUND_MAX_ADDR = 16'h050C;
	defparam	b2v_inst2.BACKGROUND_MEM_SEL = 3'b000;
	defparam	b2v_inst2.BLUE_MAX_ADDR = 16'h0116;
	defparam	b2v_inst2.BLUE_MEM_SEL = 3'b100;
	defparam	b2v_inst2.GREEN_MAX_ADDR = 16'h0118;
	defparam	b2v_inst2.GREEN_MEM_SEL = 3'b011;
	defparam	b2v_inst2.INCREMENTAR = 5;
	defparam	b2v_inst2.INICIO = 0;
	defparam	b2v_inst2.LER = 4;
	defparam	b2v_inst2.LOSE_MAX_ADDR = 16'h01E0;
	defparam	b2v_inst2.LOSE_MEM_SEL = 3'b111;
	defparam	b2v_inst2.PREPARAR = 1;
	defparam	b2v_inst2.PWR_MAX_ADDR = 16'h0004;
	defparam	b2v_inst2.PWR_MEM_SEL = 3'b001;
	defparam	b2v_inst2.RED_MAX_ADDR = 16'h011A;
	defparam	b2v_inst2.RED_MEM_SEL = 3'b010;
	defparam	b2v_inst2.SUSPENDER = 3;
	defparam	b2v_inst2.WIN_MAX_ADDR = 16'h01A0;
	defparam	b2v_inst2.WIN_MEM_SEL = 3'b110;
	defparam	b2v_inst2.YELLOW_MAX_ADDR = 16'h0116;
	defparam	b2v_inst2.YELLOW_MEM_SEL = 3'b101;

memory_block	b2v_inst3(
	.IN_CLK(MEM_CLK),
	.IN_ADDR(MEM_ADDR),
	.SELECTOR(MEM_SEL),
	.MEM_RGB(MEM_RGB));


endmodule
