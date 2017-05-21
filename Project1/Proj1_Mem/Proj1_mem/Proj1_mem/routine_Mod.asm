include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

export _mod_A_X
area text(rom,rel )
.SECTION 
_mod_A_X:
RAM_PROLOGUE RAM_USE_CLASS_3
mov [40h],00h	;this register is used only inside the mod routine
loop1:
cmp A,[X+0]
jnc dec_A
mov A,[40h]
mov [X+0],A
ret
dec_A:
sub A,[X+0]
inc [40h]
jmp loop1
RAM_EPILOGUE RAM_USE_CLASS_3
ret
.ENDSECTION 
.terminate:
jmp .terminate