vlib work
vlog PC_Reg.v PC_Reg_TB.v
vsim -voptargs=+acc work.pc_reg_tb
add wave *
run -all
#quit -sim