transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/reg32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/computer.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/reg64.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/Bus32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/encoder.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/mdr.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/alu.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/add32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/sub32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/div32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/mul32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/or32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/and32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/not32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/addOne.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/neg32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/shl32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/shr32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/rol32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/ror32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/Clock.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/selectAndEncode.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/Decode4to16.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/regR0.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/conFF.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/conFFCompare.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/outPort.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/inPort.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/ram512.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/ControlUnit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/stack32.v}

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/elec374/project {C:/altera/13.0sp1/elec374/project/computerP3_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  computerP3_tb

add wave *
view structure
view signals
run 200 ns
