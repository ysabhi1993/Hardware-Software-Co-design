include "m8c.inc"			;Part specific file
include "m8ssc.inc"			;Part specific file
include "memory.inc"

export _main

_main:
while(1)
mov a ,00h
mov [PRT0DR],a
xor a, ffh
loop:
dec a
jnz loop
mov [PRT0DR],a
xor a, ffh
loop1:
dec a
jnz loop1

.terminate:
    jmp .terminate
