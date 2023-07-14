onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider INPUTS
add wave -noupdate -radix binary /pixel_loader_tb/uut/CLK
add wave -noupdate -radix hexadecimal /pixel_loader_tb/uut/DATA_IN
add wave -noupdate /pixel_loader_tb/uut/SPRITES_EN
add wave -noupdate -divider OUTPUTS
add wave -noupdate /pixel_loader_tb/uut/MEM_CLK
add wave -noupdate -radix symbolic -radixshowbase 0 /pixel_loader_tb/uut/MEM_SEL
add wave -noupdate -radix hexadecimal /pixel_loader_tb/uut/MEM_ADDR
add wave -noupdate -radix hexadecimal /pixel_loader_tb/uut/RGB
add wave -noupdate -divider ENABLES
add wave -noupdate -radix binary /pixel_loader_tb/uut/BACKGROUND_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/BLUE_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/GREEN_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/RED_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/YELLOW_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/LOSE_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/WIN_EN
add wave -noupdate -radix binary /pixel_loader_tb/uut/PWR_EN
add wave -noupdate -divider INTERNAL
add wave -noupdate -radix unsigned /pixel_loader_tb/uut/A_State
add wave -noupdate -radix unsigned /pixel_loader_tb/uut/F_State
add wave -noupdate -radix hexadecimal /pixel_loader_tb/uut/r_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {172 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 129
configure wave -valuecolwidth 96
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
WaveRestoreZoom {90 ps} {191 ps}
