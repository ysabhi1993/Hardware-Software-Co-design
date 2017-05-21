;-----------------------------------------------------------------------------
; Assembly main line
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

export _routine_avg
export _main

input_count: equ 62h	;71h
counter_sum: equ 63h	;69h
counting_adds: equ 64h	;70h
operand_2:equ 65h		;40h
counter_input: equ 67h	
result_avg: equ 77h		;68h
quotient_val: equ 11h	;11h


_main:
mov reg[CUR_PP], 06h
	
	mov [00h], 01h
	mov [01h], 02h
	mov [02h], 02h
	mov [03h], 03h
	
	mov [04h], 03h
	mov [05h], 04h
	mov [06h], 04h
	mov [07h], 05h

	mov [08h], 01h
	mov [09h], 02h
	mov [0Ah], 02h
	mov [0Bh], 03h
	
	mov [0Ch], 03h
	mov [0Dh], 04h
	mov [0Eh], 04h
	mov [0Fh], 05h
	
	mov [10h], 01h
	mov [11h], 02h
	mov [12h], 02h
	mov [13h], 03h
	
	mov [14h], 03h
	mov [15h], 04h
	mov [16h], 04h
	mov [17h], 05h
	
	mov [18h], 01h
	mov [19h], 02h
	mov [1Ah], 02h
	mov [1Bh], 03h
	
	mov [1Ch], 03h
	mov [1Dh], 04h
	mov [1Eh], 04h
	mov [1Fh], 05h
	
	mov [20h], 01h
	mov [21h], 02h
	mov [22h], 02h
	mov [23h], 03h
	
	mov [24h], 08h
	mov [25h], 08h
	mov [26h], 08h
	mov [27h], 08h
	
	mov reg[CUR_PP],00h
		
	mov reg[MVW_PP],06h
	mov reg[MVR_PP],06h
_routine_avg:

;average:
;	cmp [addr_shrt_p],03h
;	jnz end_memory_mode
	
	mov [input_count],0Ah	;This will enable us to add 4 sets of "time" values. This can be changed as per the requirement.
	mov [counting_adds],04h		;since there will be 4 additions to finish adding two "times" we will set a counter for that.
	mov [counter_sum],91h
	mov [counter_input],D0h
	mov [DDh],03h
read_inputs:
	mvi A, [DDh]
	mvi [counter_input], A
	dec [DDh]
	dec [DDh]
	mvi A, [DDh]
	mvi [counter_input], A
	dec [DDh]
	dec [DDh]
	mvi A, [DDh]
	mvi [counter_input], A
	dec [DDh]
	dec [DDh]
	mvi A, [DDh]
	mvi [counter_input], A
	dec [DDh]
	add [DDh],07h
	dec [input_count]
	cmp [input_count],00h
	jnz read_inputs
	
	mov A,00h
	mvi [counter_sum],A
	mvi [counter_sum],A
	mvi [counter_sum],A
	mvi [counter_sum],A
	
	;register counter_sum will point to register 90h so that counter_sum can be implemented in MVI
	;load the first set of inputs into register that hold sum (90h,91h,92h)
	
	mov [input_count],0Ah		
	mov [counter_input],D0h	
compute_sum:
	mov [counting_adds],04h
	mov [counter_sum],91h
add_values:
	;read value from the 1st set of inputs
	mvi A,[counter_input]
	mov [operand_2],A
	;move value in 90h to add to corresponding ms value 
	mvi A,[counter_sum]
	add A,[operand_2]
	cmp A,3Ch	;compare each value with 60 so that when it exceeds 60, add 1 to next value in the sequence.
	jnc add_one	;if A is >= 3C increment the value in the sequence by 1
	;move the sum into 90h register which is designated to hold ms values
	dec [counter_sum]
	mvi [counter_sum],A
	dec [counting_adds]
	cmp [counting_adds],00	;compare if all 4 values are added. 
	jnz add_values
	dec [input_count]		;this counter keeps track of how many sets of values have been added.
	cmp [input_count],00
	jnz compute_sum		;if they are added then start adding new set of values to the existing sum.
	ljmp _avg_cal
	
	;incrementing the next value by 1
add_one:
	sub A,3Ch	;get the value to be written into 90h after subtracting the carry value 
	dec [counter_sum]
	mvi [counter_sum],A 
	mvi A,[counter_sum]	;read value in 91h so that carry value can be added to it
	add A,1		;add carry value
	dec [counter_sum]		
	mvi [counter_sum],A	;write back the value to 91h after adding carry.
	dec [counter_sum]	
	dec [counting_adds]
	cmp [counting_adds],00	;compare if all 4 values are added. 
	jnz add_values
	dec [input_count]		;this counter keeps track of how many sets of values have been added.
	cmp [input_count],00
	jnz compute_sum		;if they are added then start adding new set of values to the existing sum.
	ljmp _avg_cal

	;Computing average here
	
_avg_cal:
	mov [input_count],0Ah
	mov [72h],00h
	mov reg[CUR_PP], 06h
	mov [10h], [94h] 			;ram_2[10h]=value in 93h which is the sum of hours
	mov reg[CUR_PP], 00h		;set Current Page Pointer back to 0
	mov [EBh], 10h 				;initialize MVI read pointer to 10h
	mvi A, [EBh]				;read the value in 93h to A
	mov [86h],00h
	mov [result_avg],B0h
	mov [quotient_val], 00h
	
compute_avg_hr:
	cmp A,[input_count]
	jnc find_q_hr
	mov [85h],A					;85h holds the remainder
	mov A,[quotient_val]
	mvi [result_avg],A	;register 83h holds the quotient
	ljmp compute_avg_min

find_q_hr:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_avg_hr
	
compute_avg_min:
	mov [72h],0Ah
	mov [61h],00h
	mov [68h],00h
	mov A,00h
	
Com_rem:
	mov [quotient_val],00h
	mov [75h], 06h
	
compute_prd:
	add A,[85h]
	dec [75h]
	cmp [75h],00h
	jnz compute_prd
	
compute_rem:
	cmp A,[input_count]
	jnc find_q1
	mov [86h],A			;86h holds the remainder
	mov [68h],[quotient_val]		;holds the quotient
	mov A,[68h]
	add [61h],A
	mov A,00h
	add A,[86h]			;add remainder to A and repeat the operation for "value in [input_count]" times
	dec [72h]
	cmp [72h],00h
	jnz Com_rem
	ljmp add_tonext

find_q1:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_rem
	
add_tonext:
	mov reg[CUR_PP], 06h 		;set Current Page Pointer to 2
	mov [10h], [93h] 				
	mov reg[CUR_PP], 00h

	mov [EBh], 10h 		;initialize MVI read pointer to 10h
	mvi A, [EBh]		;read the value in 92h into A
	add A,[86h]
	mov [quotient_val],00h
	
compute_avg:
	cmp A,[input_count]
	jnc find_q_min
	mov [85h],A					;85h holds the remainder
	mov A,[quotient_val]
	add A,[61h]
	mvi [result_avg],A			;register 81h holds the quotient
	ljmp compute_avg_sec

find_q_min:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_avg
	
compute_avg_sec:
	mov [72h],0Ah
	mov [61h],00h
	mov [68h],00h
	mov A,00h
	
Com_rem_sec:
	mov [quotient_val],00h
	mov [75h],06h	
	
compute_prd_sec:
	add A,[85h]
	dec [75h]
	cmp [75h],00h
	jnz compute_prd_sec
	
compute_rem_sec:
	cmp A,[input_count]
	jnc find_q1_sec
	mov [86h],A			;86h holds the remainder
	mov [68h],[quotient_val]		;holds the quotient
	mov A,[68h]
	add [61h],A
	mov A,00h
	add A,[86h]			;add remainder to A and repeat the operation for "value in [input_count]" times
	dec [72h]
	cmp [72h],00h
	jnz Com_rem_sec
	ljmp add_tonext_sec

find_q1_sec:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_rem_sec
	
add_tonext_sec:
	mov reg[CUR_PP], 06h 		;set Current Page Pointer to 2
	mov [10h], [92h] 				
	mov reg[CUR_PP], 00h

	mov [EBh], 10h 		;initialize MVI read pointer to 10h
	mvi A, [EBh]		;read the value in 92h into A
	add A,[86h]
	mov [quotient_val],00h
	
compute_avg_sec1:
	cmp A,[input_count]
	jnc find_q_sec
	mov [85h],A					;85h holds the remainder
	mov A,[quotient_val]
	add A,[61h]
	mvi [result_avg],A					;register 81h holds the quotient
	ljmp compute_avg_end

find_q_sec:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_avg_sec1
	
compute_avg_end:
	mov [counting_adds],B3h
	mov A,[85h]
	mvi [counting_adds],A
	
	
add_ms:
	mov [72h],0Ah
	add [B3h],A
	dec [72h]
	cmp [72h],01h
	jnz add_ms 
		
	mov [counter_input],B0h
	mvi A,[counter_input]
	mov [C0h],A
	mvi A,[counter_input]
	mov [C1h],A
	mvi A,[counter_input]
	mov [C2h],A
	mvi A,[counter_input]
	mov [C3h],A
	
	;Display
	lcall   LCD_Start       ; Initialize LCD
	mov    A,00h           ; Set cursor position at row = 0
   	mov    X,00h           ; col = 5
   	lcall   LCD_Position
   	mov    A, >STRING3     	; Higher byte
   	mov	   X, <STRING3
    lcall  LCD_PrCString   

	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,00h           ; col = 5
   	lcall   LCD_Position
   	mov    A,[C0h]      	; Higher byte
    lcall   LCD_PrHexByte     
	
	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,02h           ; col = 5
   	lcall   LCD_Position
   	mov    A, >THE_STRING20     	; Higher byte
   	mov	   X, <THE_STRING20
    lcall  LCD_PrCString          
	
  	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,03h           ; col = 5
   	lcall   LCD_Position
   	mov    A,[C1h]      	; Lower byte
   	lcall   LCD_PrHexByte  
	
	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,05h           ; col = 5
   	lcall   LCD_Position
   	mov    A, >THE_STRING20     	; Higher byte
	mov	   X, <THE_STRING20
    lcall   LCD_PrCString          
	
	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,06h           ; col = 5
   	lcall   LCD_Position
   	mov    A,[C2h]      	; Load pointer to ROM string
   	lcall   LCD_PrHexByte   
	
	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,08h           ; col = 5
   	lcall   LCD_Position
   	mov    A, >THE_STRING21      	; Higher byte
	mov	   X, <THE_STRING21
    lcall   LCD_PrCString          
	
	mov    A,01h           ; Set cursor position at row = 0
   	mov    X,09h           ; col = 5
   	lcall   LCD_Position
   	mov    A,[C3h]      	; Load pointer to ROM string
   	lcall   LCD_PrHexByte  


.LITERAL 
THE_STRING20:
ds ":"
db 00h
.ENDLITERAL 

.LITERAL 
THE_STRING21:
ds "."
db 00h
.ENDLITERAL 

.LITERAL 
STRING3:
ds "AVERAGE"
db 00h
.ENDLITERAL 

.terminate:
jmp .terminate
