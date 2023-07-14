onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /memory_block_tb/dut/IN_CLK
add wave -noupdate -radix hexadecimal /memory_block_tb/dut/IN_ADDR
add wave -noupdate -radix binary -radixshowbase 0 /memory_block_tb/dut/SELECTOR
add wave -noupdate -radix hexadecimal /memory_block_tb/dut/MEM_RGB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7908 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 123
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
WaveRestoreZoom {0 ps} {30720 ps}
