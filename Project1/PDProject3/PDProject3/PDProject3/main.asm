;-----------------------------------------------------------------------------
; Assembly main line
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules


export _main


_main:

    ; M8C_EnableGInt ; Uncomment this line to enable Global Interrupts
	; Insert your main assembly code here.


Toggle_LED:
mov reg[PRT0DR],0x01
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes

xor reg[PRT0DR],0x01
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes
call _Delay10msTimes

jmp Toggle_LED:

.terminate:
    jmp .terminate




