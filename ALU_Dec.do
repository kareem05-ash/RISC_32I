vlib work
vlog ALU_Dec.v ALU_Dec_TB.v
vsim -voptargs=+acc work.alu_dec_tb
add wave *
run -all
#quit -sim