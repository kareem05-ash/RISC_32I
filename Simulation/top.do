vlib work
vlog RISC_Top.v RISC_Top_TB.v
vsim -voptargs=+acc work.risc_top_tb
add wave *
run -all
#quit -sim