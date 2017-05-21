;------------------------------------------------------
; Assembly main line
;------------------------------------------------------
;debouncer circuit
include "m8c.inc"
include "memory.inc"
include "PSoCAPI.inc"

export bShadow

area bss(RAM)		;alocations area in RAM - use 'area bss' for RAM
	bShadow: blk 1	;reserve a RAM location named bShadow of blk/byte size 1
area text(rom,rel ) ;'text' (this can be anything pg 25 in AL) in ROM, rel = linker can relocate the code or data



;just to print on LCD
export _main

area text(rom,rel )	;nexts lines are code


_main:
 ;GPIOs are configured with GUI
 	call LCD_Start
	mov A, 01h
	mov X, 00h
	call LCD_Position
	mov A, >THE_STRNG
	mov X, <THE_STRNG
	call LCD_PrCString
  
    M8C_EnableIntMask INT_MSK1, INT_MSK1_DBB01					;enable digital block one interrupt
	M8C_EnableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask
	M8C_EnableGInt												;enable global interrupts
	mov [250], 00h 	;holds value of interrupt number
	mov [251], 00h 	;holds value of seconds
	mov [252], 00h	;holds value of minutes
	
	;start timer

	lcall Timer16_sec_Start


 loop:
    nop
	nop
	nop
	nop
	nop

    jmp loop

.LITERAL 
THE_STRNG:
ds "EvryTng is Awsme"
db 00h
.ENDLITERAL 
;