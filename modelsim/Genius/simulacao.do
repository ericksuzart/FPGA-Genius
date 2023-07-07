onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/P
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/A_State
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/F_State
add wave -noupdate -radix binary /Genius_top_level_tb/dut/b2v_inst2/INTERFACE_EN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1670180 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 126
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1670155 ps} {1670205 ps}
