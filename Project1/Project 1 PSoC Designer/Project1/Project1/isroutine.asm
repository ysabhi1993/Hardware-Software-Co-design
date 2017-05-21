include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

_main:
_GPIO_ISR
and reg[INT_MSK0],DFh ;disabling interrupts
push A
push X
mov A, reg[PRT0DR]
mov [temp1],A ;temp1 is 81h
mov [FLAG_S], 01h ;flag
or reg[PRT0DM0],ack_1 ;08h
and reg[PRT0DM0],ack_0 ;F7h
or reg[INT_MSK0],20h
pop X
pop A
reti
.terminate:
    jmp .terminate
