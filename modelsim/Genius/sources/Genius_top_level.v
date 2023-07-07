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
// CREATED		"Thu Jul  6 21:43:31 2023"

module Genius_top_level(
	CLOCK_25,
	CLOCK_50,
	wren,
	data,
	SW,
	VGA_HS,
	VGA_VS,
	VGA_BLANK_N,
	DISP_EN,
	VGA_CLK,
	c1,
	VGA_B,
	VGA_G,
	VGA_R
);


input wire	CLOCK_25;
input wire	CLOCK_50;
input wire	wren;
input wire	[47:0] data;
input wire	[0:0] SW;
output wire	VGA_HS;
output wire	VGA_VS;
output wire	VGA_BLANK_N;
output wire	DISP_EN;
output wire	VGA_CLK;
output wire	c1;
output wire	[7:0] VGA_B;
output wire	[7:0] VGA_G;
output wire	[7:0] VGA_R;

wire	[23:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	[47:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[4:0] SYNTHESIZED_WIRE_5;

assign	DISP_EN = SYNTHESIZED_WIRE_2;
assign	VGA_CLK = CLOCK_25;




VGA_controller	b2v_inst(
	.VGA_CLK(CLOCK_25),
	.RESET(SW),
	.RGB(SYNTHESIZED_WIRE_1),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK_N(VGA_BLANK_N),
	.DISP_EN(SYNTHESIZED_WIRE_2),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R));
	defparam	b2v_inst.G_HS = 360;
	defparam	b2v_inst.G_VS = 360;
	defparam	b2v_inst.G_X = 140;
	defparam	b2v_inst.G_Y = 60;
	defparam	b2v_inst.H_BPORCH = 48;
	defparam	b2v_inst.H_DISP = 640;
	defparam	b2v_inst.H_FPORCH = 16;
	defparam	b2v_inst.H_SYNC = 96;
	defparam	b2v_inst.V_BPORCH = 31;
	defparam	b2v_inst.V_DISP = 480;
	defparam	b2v_inst.V_FPORCH = 11;
	defparam	b2v_inst.V_SYNC = 2;


pixel_loader	b2v_inst2(
	.CLK(CLOCK_50),
	.RESET(SW),
	.INTERFACE_EN(SYNTHESIZED_WIRE_2),
	.DATA_IN(SYNTHESIZED_WIRE_3),
	.MEM_CLK(SYNTHESIZED_WIRE_4),
	.MEM_ADDR(SYNTHESIZED_WIRE_5),
	.RGB(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst2.ATIVAR = 2;
	defparam	b2v_inst2.INCREMENTAR = 5;
	defparam	b2v_inst2.INICIO = 0;
	defparam	b2v_inst2.LER = 4;
	defparam	b2v_inst2.MAX_ADDR = 64800;
	defparam	b2v_inst2.PREPARAR = 1;
	defparam	b2v_inst2.SUSPENDER = 3;


interface_ram	b2v_inst3(
	.wren(wren),
	.clock(SYNTHESIZED_WIRE_4),
	.address(SYNTHESIZED_WIRE_5),
	.data(data),
	.q(SYNTHESIZED_WIRE_3));


endmodule
