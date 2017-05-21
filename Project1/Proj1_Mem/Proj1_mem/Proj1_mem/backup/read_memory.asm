;-----------------------------------------------------------------------------
; Assembly main line
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

export _main

_main:
mov reg[MVW_PP],06h
mov [EBh], 10h ;initialize MVI write pointer to 10h
mov A, 8
mvi [EBh], A ;ram_3[10h]=8, ram_0[EBh]=11h
mov A, 1
mvi [EBh], A ;ram_3[11h]=1, ram_0[EBh]=12h

mov reg[MVR_PP],06h
mov 


   lcall   LCD_Start       	;Initialize LCD
   mov    A,00h           	;Set cursor position at row = 0
   ;mov    X,05h          	;col = 5
   lcall   LCD_Position
   mov    A,[X+0]      		;Load pointer to ROM string
   ;mov    X,<THE_STR
   ;call   LCD_PrCString	;Print constant "ROM" string
   lcall   LCD_PrHexByte             


.terminate:
jmp .terminate
