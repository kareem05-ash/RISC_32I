vlib work
vlog Data_Mem.v Data_Mem_TB.v
vsim -voptargs=+acc work.data_mem_tb
add wave *
run -all
#quit -sim