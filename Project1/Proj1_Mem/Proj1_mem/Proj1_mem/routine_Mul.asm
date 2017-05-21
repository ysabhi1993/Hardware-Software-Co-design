;
;include "m8c.inc"       ; part specific constants and macros
;include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
;include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules
;
;export _main
;
;_main:
;
;;mov [85h],3Ch
;;mov [86h],00h
;;mov [75h],09h
;;mov [76h],00h
;;mov [78h],FFh
;mov reg[MVW_PP],03h
;mov [00h],00
;mov A,
;
;compute_prd:
;mov A,00h
;add A,3Ch
;cmp A,[78h]
;jc no_overflow
;inc [86h]
;no_overflow:
;dec [75h]
;cmp [75h],00h
;jnz compute_prd
;
;mov [77h],A
;
;
;
;
;call   LCD_Start       ; Initialize LCD
;   	mov    A,00h           ; Set cursor position at row = 0
;   	mov    X,00h           ; col = 5
;   	call   LCD_Position
;   	mov    A,[86h]      	; Load pointer to ROM string
;    call   LCD_PrHexByte           
;	
;  	mov    A,00h           ; Set cursor position at row = 0
;   	mov    X,02h           ; col = 5
;   	call   LCD_Position
;   	mov    A,[77h]      	; Load pointer to ROM string
;   	call   LCD_PrHexByte  
;.terminate:
;jmp .terminate
;