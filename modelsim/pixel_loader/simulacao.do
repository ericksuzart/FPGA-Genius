onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /genius_top_level_tb/uut/b2v_inst/RESET
add wave -noupdate -radix binary /genius_top_level_tb/uut/b2v_inst2/CLK
add wave -noupdate -divider VGA
add wave -noupdate -radix binary /genius_top_level_tb/uut/b2v_inst/VGA_CLK
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst/X
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst/Y
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst/RGB
add wave -noupdate -radix binary /genius_top_level_tb/uut/b2v_inst/SPRITES_FLAGS
add wave -noupdate -radix binary /genius_top_level_tb/uut/b2v_inst/SPRITES_EN
add wave -noupdate -divider {Pixel loader}
add wave -noupdate /genius_top_level_tb/uut/b2v_inst2/MEM_CLK
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/MEM_ADDR
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/MEM_SEL
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst2/A_State
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst2/F_State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1669653 ps} 0}
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
WaveRestoreZoom {1669588 ps} {1669722 ps}
