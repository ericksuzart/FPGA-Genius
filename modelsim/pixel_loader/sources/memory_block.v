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
// CREATED		"Thu Jul 13 02:09:21 2023"

module memory_block(
	IN_CLK,
	IN_ADDR,
	SELECTOR,
	MEM_RGB
);


input wire	IN_CLK;
input wire	[15:0] IN_ADDR;
input wire	[2:0] SELECTOR;
output wire	[47:0] MEM_RGB;

wire	[15:0] SYNTHESIZED_WIRE_0;
wire	[15:0] SYNTHESIZED_WIRE_1;
wire	[15:0] SYNTHESIZED_WIRE_2;
wire	[15:0] SYNTHESIZED_WIRE_3;
wire	[15:0] SYNTHESIZED_WIRE_4;
wire	[15:0] SYNTHESIZED_WIRE_5;
wire	[15:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[15:0] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	[13:0] SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	[13:0] SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	[13:0] SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	[13:0] SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	[14:0] SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	[14:0] SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_24;





memory_decoder	b2v_inst(
	.MEM_OUT(SYNTHESIZED_WIRE_0),
	.MEM_RGB(MEM_RGB));


memory_demux	b2v_inst10(
	.IN_CLK(IN_CLK),
	.BACKGROUND_PX(SYNTHESIZED_WIRE_1),
	.BLUE_BTN_PX(SYNTHESIZED_WIRE_2),
	.GREEN_BTN_PX(SYNTHESIZED_WIRE_3),
	.IN_ADDR(IN_ADDR),
	.LOSE_SCREEN_PX(SYNTHESIZED_WIRE_4),
	.POWER_BTN_PX(SYNTHESIZED_WIRE_5),
	.RED_BTN_PX(SYNTHESIZED_WIRE_6),
	.SELECTOR(SELECTOR),
	.WIN_SCREEN_PX(SYNTHESIZED_WIRE_7),
	.YELLOW_BTN_PX(SYNTHESIZED_WIRE_8),
	.BACKGROUND_CLK(SYNTHESIZED_WIRE_9),
	.POWER_BTN_CLK(SYNTHESIZED_WIRE_23),
	.RED_BTN_CLK(SYNTHESIZED_WIRE_15),
	.GREEN_BTN_CLK(SYNTHESIZED_WIRE_13),
	.BLUE_BTN_CLK(SYNTHESIZED_WIRE_11),
	.YELLOW_BTN_CLK(SYNTHESIZED_WIRE_17),
	.WIN_SCREEN_CLK(SYNTHESIZED_WIRE_21),
	.LOSE_SCREEN_CLK(SYNTHESIZED_WIRE_19),
	.BACKGROUND_ADDR(SYNTHESIZED_WIRE_10),
	.BLUE_BTN_ADDR(SYNTHESIZED_WIRE_12),
	.GREEN_BTN_ADDR(SYNTHESIZED_WIRE_14),
	.LOSE_SCREEN_ADDR(SYNTHESIZED_WIRE_20),
	.OUT_PX(SYNTHESIZED_WIRE_0),
	.POWER_BTN_ADDR(SYNTHESIZED_WIRE_24),
	.RED_BTN_ADDR(SYNTHESIZED_WIRE_16),
	.WIN_SCREEN_ADDR(SYNTHESIZED_WIRE_22),
	.YELLOW_BTN_ADDR(SYNTHESIZED_WIRE_18));
	defparam	b2v_inst10.BACKGROUND = 3'b000;
	defparam	b2v_inst10.BLUE_BTN_ON = 3'b100;
	defparam	b2v_inst10.GREEN_BTN_ON = 3'b011;
	defparam	b2v_inst10.LOSE_SCREEN = 3'b111;
	defparam	b2v_inst10.POWER_BTN_ON = 3'b001;
	defparam	b2v_inst10.RED_BTN_ON = 3'b010;
	defparam	b2v_inst10.WIN_SCREEN = 3'b110;
	defparam	b2v_inst10.YELLOW_BTN_ON = 3'b101;


background_rom	b2v_inst2(
	.clock(SYNTHESIZED_WIRE_9),
	.address(SYNTHESIZED_WIRE_10),
	.q(SYNTHESIZED_WIRE_1));


blue_on_rom	b2v_inst3(
	.clock(SYNTHESIZED_WIRE_11),
	.address(SYNTHESIZED_WIRE_12),
	.q(SYNTHESIZED_WIRE_2));


green_on_rom	b2v_inst4(
	.clock(SYNTHESIZED_WIRE_13),
	.address(SYNTHESIZED_WIRE_14),
	.q(SYNTHESIZED_WIRE_3));


red_on_rom	b2v_inst5(
	.clock(SYNTHESIZED_WIRE_15),
	.address(SYNTHESIZED_WIRE_16),
	.q(SYNTHESIZED_WIRE_6));


yellow_on_rom	b2v_inst6(
	.clock(SYNTHESIZED_WIRE_17),
	.address(SYNTHESIZED_WIRE_18),
	.q(SYNTHESIZED_WIRE_8));


lose_rom	b2v_inst7(
	.clock(SYNTHESIZED_WIRE_19),
	.address(SYNTHESIZED_WIRE_20),
	.q(SYNTHESIZED_WIRE_4));


win_rom	b2v_inst8(
	.clock(SYNTHESIZED_WIRE_21),
	.address(SYNTHESIZED_WIRE_22),
	.q(SYNTHESIZED_WIRE_7));


power_on_rom	b2v_inst9(
	.clock(SYNTHESIZED_WIRE_23),
	.address(SYNTHESIZED_WIRE_24),
	.q(SYNTHESIZED_WIRE_5));


endmodule
