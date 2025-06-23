vlib work
vlog Reg_File.v Reg_File_TB.v
vsim -voptargs=+acc work.reg_file_tb
add wave *
run -all
#quit -sim