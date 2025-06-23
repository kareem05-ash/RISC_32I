vlib work
vlog Next_PC_Logic.v Next_PC_Logic_TB.v
vsim -voptargs=+acc work.next_pc_logic_tb
add wave *
run -all
#quit -sim