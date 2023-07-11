onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_CLK
add wave -noupdate -radix binary /VGA_controller_tb/dut/DISP_EN
add wave -noupdate -radix binary /VGA_controller_tb/dut/VGA_BLANK_N
add wave -noupdate -radix decimal /VGA_controller_tb/dut/X
add wave -noupdate -radix decimal /VGA_controller_tb/dut/Y
add wave -noupdate -radix decimal /VGA_controller_tb/dut/h_c
add wave -noupdate -radix decimal /VGA_controller_tb/dut/v_c
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {6866 ps}
