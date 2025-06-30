vlib work
vlog ALU.v ALU_TB.v
vsim -voptargs=+acc work.alu_tb
add wave *
run -all
#quit -sim