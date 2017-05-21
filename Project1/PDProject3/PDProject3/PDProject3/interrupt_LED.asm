;include "m8c.inc"       ; part specific constants and macros
;include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
;include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules
;
;export _main
;;_interrupt_LED:
;
;area text(rom)
;_main:
; 
;
;push A
;push X
;
;
;call LCD_1_Start
;;lcall LCD_1_init
;mov A,00h
;mov X,00h
;call LCD_1_Position
;mov A,>THE_STR
;mov X,<THE_STR
;call LCD_1_PrCString
;
;.LITERAL
;THE_STR:
;DS "PSoC LCD"
;DB 00h ; String should always be null terminated
;.ENDLITERAL
;
;.terminate:
;jmp .terminate
;
;