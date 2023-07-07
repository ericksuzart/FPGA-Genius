onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Signals
add wave -noupdate -label Reset -radix binary /Genius_top_level_tb/dut/SW
add wave -noupdate -radix binary /Genius_top_level_tb/dut/CLOCK_50
add wave -noupdate -divider VGA
add wave -noupdate -radix binary /Genius_top_level_tb/dut/VGA_CLK
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/VGA_R
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/VGA_G
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/VGA_B
add wave -noupdate -radix binary /Genius_top_level_tb/dut/DISP_EN
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/VGA_HS
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/VGA_VS
add wave -noupdate -divider {Pixel Loader}
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/A_State
add wave -noupdate -radix unsigned /Genius_top_level_tb/dut/b2v_inst2/F_State
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/RGB
add wave -noupdate -divider RAM
add wave -noupdate -label DATA -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/DATA_IN
add wave -noupdate -radix hexadecimal /Genius_top_level_tb/dut/b2v_inst2/MEM_ADDR
add wave -noupdate -radix binary /Genius_top_level_tb/dut/b2v_inst2/MEM_CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {68 ps}
