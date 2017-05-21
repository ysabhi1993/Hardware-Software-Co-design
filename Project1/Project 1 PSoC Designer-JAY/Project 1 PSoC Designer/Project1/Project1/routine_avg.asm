vlog Controllogic1.sv
vsim check_timing -c -do "run -all"
vlog read_writeMEM.sv
vlog MVM3_part1.sv