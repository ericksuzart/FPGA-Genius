
add wave -noupdate -divider RAM
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst3/address
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst3/data
add wave -noupdate /Genius_top_level_tb/dut/b2v_inst3/clock
add wave -noupdate -divider VGA
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst/h_c
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst/v_c
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst/VGA_R
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst/VGA_G
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst/VGA_B
add wave -noupdate -divider {Pixel Loader}
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/r_Addr
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/RGB
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/tmp
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/P
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/A_State
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/F_State
add wave -noupdate -radix binary /Genius_top_level_tb/dut/b2v_inst2/INTERFACE_EN
update
