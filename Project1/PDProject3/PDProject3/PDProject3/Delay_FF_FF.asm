include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules


export _main
export _Delay10msTimes:

area text(rom)
.SECTION 
 
_Delay10msTimes:				;call this subroutine in your program
RAM_PROLOGUE RAM_USE_CLASS_1
mov A,0xFF
loop:
mov [80h],0xFF
loop1:
dec [80h]
jnz loop1

dec A
jnz loop
RAM_EPILOGUE RAM_USE_CLASS_1
ret
.ENDSECTION 

.terminate:
    jmp .terminate