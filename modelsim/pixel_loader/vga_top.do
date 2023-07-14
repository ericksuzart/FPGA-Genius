onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider INPUTS
add wave -noupdate -radix binary /genius_top_level_tb/uut/CLOCK_50
add wave -noupdate -radix binary /genius_top_level_tb/uut/CLOCK_25
add wave -noupdate -radix binary /genius_top_level_tb/uut/BLUE_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/GREEN_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/RED_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/YELLOW_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/LOSE_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/WIN_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/PWR_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/RESET
add wave -noupdate -divider VGA
add wave -noupdate -radix decimal /genius_top_level_tb/uut/X
add wave -noupdate -radix decimal /genius_top_level_tb/uut/Y
add wave -noupdate -radix decimal /genius_top_level_tb/uut/VGA_B
add wave -noupdate -radix decimal /genius_top_level_tb/uut/VGA_G
add wave -noupdate -radix decimal /genius_top_level_tb/uut/VGA_R
add wave -noupdate -divider MEMORY
add wave -noupdate -radix binary /genius_top_level_tb/uut/SPRITES_EN
add wave -noupdate -radix binary /genius_top_level_tb/uut/MEM_CLK
add wave -noupdate -radix binary /genius_top_level_tb/uut/MEM_SEL
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/MEM_ADDR
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/r_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/background_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/blue_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/green_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/red_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/yellow_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/lose_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/win_addr
add wave -noupdate -radix hexadecimal /genius_top_level_tb/uut/b2v_inst2/pwr_addr
add wave -noupdate -divider PX_LOADER
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst2/A_State
add wave -noupdate -radix decimal /genius_top_level_tb/uut/b2v_inst2/F_State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1674665 ps} 0}
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
WaveRestoreZoom {1673780 ps} {1674780 ps}
