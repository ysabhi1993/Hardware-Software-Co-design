;-----------------------------------------------------------------------------
; Assembly main line
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

export _main
Enable gie
	
_main:
M8C_EnableGInt
    ; Insert your main assembly code here.
#DM initilize
or F,01H ;GIE enable
or reg[INT_MSK0],20h ;enable interrupts for gpio
or reg[PRT0IE],80h 
or reg[PRT0IC0],80h
and reg[PRT1IC1],7Fh

.terminate:
    jmp .terminate
