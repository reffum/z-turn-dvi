proc compilecode {} {
	set SRC ../../src
	vlog -novopt tb.sv
	vlog -novopt ${SRC}/serdes_5_to_1.sv
	vlog ../glbl.v
}

proc setupsim {} {
	vsim -novopt -L unisims_ver -L simprims_ver -L unimacro_ver -L secureip -onfinish final tb glbl
	log -r /*

	add wave -in -out UUT/*

	run -all

	wave zoom full
}

alias c "compilecode"
alias s "setupsim"
