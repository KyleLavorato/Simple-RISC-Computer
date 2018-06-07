onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /computer_tb/cycle
add wave -noupdate -radix decimal /computer_tb/test
add wave -noupdate -radix decimal /computer_tb/clkOut
add wave -noupdate -radix decimal /computer_tb/busDataOut
add wave -noupdate -radix decimal /computer_tb/r0_test
add wave -noupdate -radix decimal /computer_tb/r1_test
add wave -noupdate -radix decimal /computer_tb/r2_test
add wave -noupdate -radix decimal /computer_tb/r3_test
add wave -noupdate -radix decimal /computer_tb/r4_test
add wave -noupdate -radix decimal /computer_tb/r5_test
add wave -noupdate -radix decimal /computer_tb/r6_test
add wave -noupdate -radix decimal /computer_tb/r7_test
add wave -noupdate -radix decimal /computer_tb/HI_test
add wave -noupdate -radix decimal /computer_tb/LO_test
add wave -noupdate -radix decimal /computer_tb/PC_test
add wave -noupdate -radix decimal /computer_tb/Zhigh_test
add wave -noupdate -radix decimal /computer_tb/Zlow_test
add wave -noupdate -radix decimal /computer_tb/Y_test
add wave -noupdate -radix decimal /computer_tb/IR_test
add wave -noupdate -radix decimal /computer_tb/clr
add wave -noupdate -radix decimal /computer_tb/PCinc_en
add wave -noupdate -radix decimal /computer_tb/MDRread
add wave -noupdate -radix decimal /computer_tb/r0In
add wave -noupdate -radix decimal /computer_tb/r1In
add wave -noupdate -radix decimal /computer_tb/r2In
add wave -noupdate -radix decimal /computer_tb/r3In
add wave -noupdate -radix decimal /computer_tb/r4In
add wave -noupdate -radix decimal /computer_tb/r5In
add wave -noupdate -radix decimal /computer_tb/r6In
add wave -noupdate -radix decimal /computer_tb/r7In
add wave -noupdate -radix decimal /computer_tb/r8In
add wave -noupdate -radix decimal /computer_tb/r9In
add wave -noupdate -radix decimal /computer_tb/r10In
add wave -noupdate -radix decimal /computer_tb/r11In
add wave -noupdate -radix decimal /computer_tb/r12In
add wave -noupdate -radix decimal /computer_tb/r13In
add wave -noupdate -radix decimal /computer_tb/r14In
add wave -noupdate -radix decimal /computer_tb/r15In
add wave -noupdate -radix decimal /computer_tb/HIIn
add wave -noupdate -radix decimal /computer_tb/LOIn
add wave -noupdate -radix decimal /computer_tb/PCIn
add wave -noupdate -radix decimal /computer_tb/IRIn
add wave -noupdate -radix decimal /computer_tb/MARIn
add wave -noupdate -radix decimal /computer_tb/MDRIn
add wave -noupdate -radix decimal /computer_tb/Y_en
add wave -noupdate -radix decimal /computer_tb/Z_en
add wave -noupdate -radix decimal /computer_tb/r0Out
add wave -noupdate -radix decimal /computer_tb/r1Out
add wave -noupdate -radix decimal /computer_tb/r2Out
add wave -noupdate -radix decimal /computer_tb/r3Out
add wave -noupdate -radix decimal /computer_tb/r4Out
add wave -noupdate -radix decimal /computer_tb/r5Out
add wave -noupdate -radix decimal /computer_tb/r6Out
add wave -noupdate -radix decimal /computer_tb/r7Out
add wave -noupdate -radix decimal /computer_tb/r8Out
add wave -noupdate -radix decimal /computer_tb/r9Out
add wave -noupdate -radix decimal /computer_tb/r10Out
add wave -noupdate -radix decimal /computer_tb/r11Out
add wave -noupdate -radix decimal /computer_tb/r12Out
add wave -noupdate -radix decimal /computer_tb/r13Out
add wave -noupdate -radix decimal /computer_tb/r14Out
add wave -noupdate -radix decimal /computer_tb/r15Out
add wave -noupdate -radix decimal /computer_tb/HIOut
add wave -noupdate -radix decimal /computer_tb/LOOut
add wave -noupdate -radix decimal /computer_tb/PCOut
add wave -noupdate -radix decimal /computer_tb/IROut
add wave -noupdate -radix decimal /computer_tb/MAROut
add wave -noupdate -radix decimal /computer_tb/MDROut
add wave -noupdate -radix decimal /computer_tb/InPortOut
add wave -noupdate -radix decimal /computer_tb/Zlow_en
add wave -noupdate -radix decimal /computer_tb/Zhigh_en
add wave -noupdate -radix decimal /computer_tb/opcode
add wave -noupdate -radix decimal /computer_tb/busDataIn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
