onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider INPUT
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_CLK
add wave -noupdate -radix binary /VGA_controller_tb/dut/RESET
add wave -noupdate /VGA_controller_tb/dut/SPRITES_FLAGS
add wave -noupdate -radix hexadecimal /VGA_controller_tb/dut/RGB
add wave -noupdate -divider INTERNAL
add wave -noupdate -radix unsigned /VGA_controller_tb/dut/h_c
add wave -noupdate -radix unsigned /VGA_controller_tb/dut/v_c
add wave -noupdate -radix decimal /VGA_controller_tb/dut/X
add wave -noupdate -radix decimal /VGA_controller_tb/dut/Y
add wave -noupdate -radix binary /VGA_controller_tb/dut/DISP_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/BACKGROUND_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/BLUE_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/GREEN_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/RED_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/YELLOW_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/LOSE_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/WIN_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/PWR_EN
add wave -noupdate -divider OUTPUT
add wave -noupdate -radix binary /VGA_controller_tb/dut/SPRITES_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_HS
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_VS
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_BLANK_N
add wave -noupdate -radix hexadecimal /VGA_controller_tb/dut/VGA_R
add wave -noupdate -radix hexadecimal /VGA_controller_tb/dut/VGA_G
add wave -noupdate -radix hexadecimal /VGA_controller_tb/dut/VGA_B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2676725 ps} 0}
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
WaveRestoreZoom {2614091 ps} {2775963 ps}
