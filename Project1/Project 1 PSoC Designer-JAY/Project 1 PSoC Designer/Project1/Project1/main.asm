;-----------------------------------------------------------------------------
; Assembly main line
;inititalize index page
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules
include "program_defines.inc"


export _main
export addr_internal_inc_ms
export addr_inc_ms
export addr_inc_s
export addr_inc_m
export addr_inc_h

export read_addr_inc_ms
export read_addr_inc_s
export read_addr_inc_m
export read_addr_inc_h

export addr_lng_p
export addr_shrt_p

export addr_acc_mode

export md_flg

export count_saved
export read_saved
export save_time_index

export iResult1





area var(RAM)                     
addr_internal_inc_ms: 	blk 1
addr_inc_ms: 			blk 1
addr_inc_s: 			blk 1
addr_inc_m: 			blk 1
addr_inc_h: 			blk 1

read_addr_inc_ms: 		blk 1
read_addr_inc_s: 		blk 1
read_addr_inc_m: 		blk 1
read_addr_inc_h: 		blk 1

addr_lng_p: 			blk 1
addr_shrt_p: 			blk 1

addr_acc_mode: 			blk 1

md_flg: 				blk 1

count_saved:			blk 1
read_saved: 			blk 1
save_time_index:		blk 1

iResult1:       		blk 2


area text(ROM,REL)
;export time_counter
_main:

;==================================================
;DUMMY VALUES
;==================================================


mov reg[MVW_PP],06
;1st
mov [00h],00h
mov A,20h
mvi [00h],A		;milli-seconds
mov A,30h
mvi [00h],A		;seconds
mov A,10h
mvi [00h],A		;minutes	
mov A,02h
mvi [00h],A		;hours
;2nd
mov A,10h
mvi [00h],A
mov A,3Bh
mvi [00h],A
mov A,20h
mvi [00h],A
mov A,07h
mvi [00h],A
;3rd
mov A,20h
mvi [00h],A
mov A,30h
mvi [00h],A
mov A,10h
mvi [00h],A
mov A,02h
mvi [00h],A
;4th
mov A,10h
mvi [00h],A
mov A,3Bh
mvi [00h],A
mov A,20h
mvi [00h],A
mov A,07h
mvi [00h],A
;5th
mov A,20h
mvi [00h],A
mov A,30h
mvi [00h],A
mov A,10h
mvi [00h],A
mov A,02h
mvi [00h],A
;6th
mov A,10h
mvi [00h],A
mov A,3Bh
mvi [00h],A
mov A,20h
mvi [00h],A
mov A,07h
mvi [00h],A
;7th
mov A,20h
mvi [00h],A
mov A,30h
mvi [00h],A
mov A,10h
mvi [00h],A
mov A,02h
mvi [00h],A
;8th
mov A,10h
mvi [00h],A
mov A,3Bh
mvi [00h],A
mov A,20h
mvi [00h],A
mov A,07h
mvi [00h],A
;9th
mov A,20h
mvi [00h],A
mov A,30h
mvi [00h],A
mov A,10h
mvi [00h],A
mov A,02h
mvi [00h],A
;10th
mov A,10h
mvi [00h],A
mov A,3Bh
mvi [00h],A
mov A,20h
mvi [00h],A
mov A,07h
mvi [00h],A

mov reg[CUR_PP],00


 	call LCD_Start


Initialize_Interrupt:
	M8C_EnableIntMask INT_MSK1, INT_MSK1_DBB01					;enable digital block one interrupt
	M8C_EnableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask
	M8C_EnableGInt	;enable global interrupts

Initialize_Variables:
	mov [addr_internal_inc_ms],00h
	mov [addr_inc_ms],00h
	mov [addr_inc_s],00h
	mov [addr_inc_m],00h
	mov [addr_inc_h],00h
	mov [md_flg],01h

Set_Up_Anolog:
	mov   A, PGA_1_HIGHPOWER
    lcall PGA_1_Start		;offset
	
	mov   A, PGA_2_HIGHPOWER 
    lcall PGA_2_Start
	
    mov   A, LPF2_1_HIGHPOWER
    lcall LPF2_1_Start
	
    mov   A, 7                    ; Set resolution to 7 Bits -- I think this gets set in GUI? LS
    call  DUALADC_1_SetResolution

    mov   A, DUALADC_1_HIGHPOWER     ; Set Power and Enable A/D
    call  DUALADC_1_Start

    mov   A, 00h                   ; Start A/D in continuous sampling mode - or put 20 to get 20 cycles in A
    call  DUALADC_1_GetSamples
	
	
	lcall Timer16_1_Start
	
	mov reg[MVW_PP], 6				;writing on memory page 6
	mov reg[MVR_PP], 6				;reading from memory page 6

	
loop:

	mov A, 01h
	mov X, 00h
	call LCD_Position
	mov A, [addr_shrt_p]
	call LCD_PrHexByte
	
	mov A, 01h
	mov X, 05h
	call LCD_Position
	mov A, [md_flg]
	call LCD_PrHexByte
	
;
;	mov A, 01h
;	mov X, 0Ah
;	call LCD_Position
;	mov A, [md_flg]
;	call LCD_PrHexByte

	


Chcklngp:
    cmp [addr_lng_p],01h 
	jnz StaySameMode		;if its not set stay in same mode

	;toggle if you get long press
	mov A, reg[PRT1DR]
	xor A, FFh
	mov reg[PRT1DR], A
	
	mov [addr_lng_p],00h  	;reset long press value
	mov [addr_shrt_p],00h  	;reset short press value
	


next_Mode:
    and F, FBh			;clear CF
	asl [md_flg]
	

	cmp [md_flg],20h
	jnz StaySameMode
	mov [md_flg],01h

StaySameMode:
	cmp [md_flg],01h
	jz Accuracy_m          
	cmp [md_flg],02h
	jz Threshold_m
	cmp [md_flg],04h
	jz Button_m
	cmp [md_flg],08h
	jz Sound_m
	cmp [md_flg],10h
	jz Mem_Display
	
	

;---------------------MODES-----------------------------------------------------
;-------------------------------------------------------------------------------
;---------------------START ACCURACY MODE---------------------------------------

Accuracy_m:
   cmp [addr_shrt_p], 00h
	jnz check_acc_ms
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >ACCURACY_MODE
	mov X, <ACCURACY_MODE
	call LCD_PrCString
	jmp loop

check_acc_ms:
	cmp [addr_shrt_p], 01h
	jnz check_acc_halfsec
	mov [addr_acc_mode], tenthsec_mode	;tenth second mode by default
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >TENTHSEC_MODE
	mov X, <TENTHSEC_MODE
	call LCD_PrCString
	jmp loop

check_acc_halfsec:
	cmp [addr_shrt_p] , 02h
	jnz check_acc_sec
	mov [addr_acc_mode], halfsec_mode
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >HALFSEC_MODE
	mov X, <HALFSEC_MODE
	call LCD_PrCString
	jmp loop
	
check_acc_sec:
	cmp [addr_shrt_p] , 03h
	jnz check_acc_end
	mov [addr_acc_mode], sec_mode
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >SEC_MODE
	mov X, <SEC_MODE
	call LCD_PrCString
	jmp loop

check_acc_end:
	cmp [addr_shrt_p], 04h
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h
	
	jmp loop
	
;---------------------END ACCURACY MODE--------------------------------------
	
;---------------------START THRESHOLD MODE-----------------------------------
	
Threshold_m:
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >THRESHOLD_MODE
	mov X, <THRESHOLD_MODE
	call LCD_PrCString 
	mov [count_saved], 00h			;back to initialized value
	mov [save_time_index], 00
	jmp loop
	
;---------------------END THRESHOLD MODE--------------------------------------
	
;---------------------START BUTTON MODE---------------------------------------

Button_m:
here:
    cmp [addr_shrt_p], 00h
	jnz check_but_clear
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >BUTTON_MODE
	mov X, <BUTTON_MODE
	call LCD_PrCString
	

check_but_clear:
	cmp [addr_shrt_p], 01h
	jnz check_but_start
	mov [addr_inc_ms], 00h
	mov [addr_inc_s], 00h
	mov [addr_inc_m], 00h
	mov [addr_inc_h], 00h
	
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >CLEAR_TIME
	mov X, <CLEAR_TIME
	call LCD_PrCString
	;call Display_Time_LCD
	jmp loop
	
check_but_start:

	cmp [addr_shrt_p], 02h
	jnz check_but_stop
		
		cmp [addr_acc_mode],sec_mode
		jz label_sec_mode

		cmp [addr_acc_mode],halfsec_mode
		jz label_halfsec_mode

	label_tenthsec_mode:
		mov [addr_inc_ms], [addr_internal_inc_ms]
		jmp check_ms

	label_halfsec_mode: 
		mov A, [addr_internal_inc_ms]
		mov X, A
		cmp A, 32h
		jnz check_if_00
		mov [addr_inc_ms], [addr_internal_inc_ms]
		jmp check_ms
	check_if_00:
		mov A, X
		cmp A, 00h
		jnz check_ms
		mov [addr_inc_ms], [addr_internal_inc_ms]
		jmp check_ms
		
	label_sec_mode: 
		mov A, [addr_internal_inc_ms]					;copy over because you need to compare
		cmp A, 00h
		jnz check_ms									;keep display value as is
		;if it is 00 
		mov [addr_inc_ms], [addr_internal_inc_ms]		;update value to be displayed
		;jmp check_ms
		

	check_ms:
		mov A, [addr_internal_inc_ms] 	;
		cmp A, 64h 		;compare to 100
		jnz display_ms
		
	reset_ms:
		mov [addr_internal_inc_ms], 00h
		inc [addr_inc_s]		;increment seconds
		
	display_ms:
		mov A, 00h
		mov X, 09h
		call LCD_Position
		mov A, [addr_inc_ms]
		call LCD_PrHexByte
		
	check_sec:	
		mov A, [addr_inc_s]	;move [251] to A as to not mess up the actual number in [251] during compare
		cmp A, 3Ch		;compare with 60
						;need to check CF : if it's not set than [251] is larger than 60
		jnz display_sec

	reset_sec:
		mov [addr_inc_s],00h
		inc [addr_inc_m]		;increment minutes
		
	display_sec:
	    mov A, 00h
		mov X, 06h
		call LCD_Position
		mov A, [addr_inc_s]
		call LCD_PrHexByte
		
		
	check_min:
		mov A, [addr_inc_m]	;move [251] to A as to not mess up the actual number in [251] during compare
		cmp A, 3Ch		;compare with 60
						;need to check CF : if it's not set than [251] is larger than 60
		jnz display_min

	reset_min:
		mov [addr_inc_s],00h
		inc [addr_inc_h]

	display_min:
	    mov A, 00h
		mov X, 03h
		call LCD_Position
		mov A, [addr_inc_m]
		call LCD_PrHexByte
		
	check_hour:
		mov A, [addr_inc_h]
		cmp A, 18h		;compare with 24
		jnz display_hour
		
	reset_hour:
		mov [addr_inc_h], 00h
		
	display_hour:
		mov A, 00h
		mov X, 00h
		call LCD_Position
		mov A, [addr_inc_h]
		call LCD_PrHexByte
	jmp loop
	
check_but_stop:
	cmp [addr_shrt_p], 03h
	jnz before_check_but_end
;	call Save_Time
	
;	mov [count_saved], 00h			;back to initialized value
;	mov [save_time_index], 00

save_and_count:
		mov A, [addr_inc_h]
		;mov A, FFh
		mvi [save_time_index], A
		mov A, [addr_inc_m]
		;mov A, EEh
		mvi [save_time_index], A
		mov A, [addr_inc_s]
		;mov A, DDh
		mvi [save_time_index], A
		mov A, [addr_inc_ms]
		;mov A, CCh
		mvi [save_time_index], A
		
		;inc [count_saved]
		
	mov A, 01h
	mov X, 0Ch
	call LCD_Position
	mov A, [count_saved]
	call LCD_PrHexByte
	
	
	;inc [addr_shrt_p]
	jmp loop
	;stop timer

	
before_check_but_end:
	cmp [addr_shrt_p], 04h
	jnz check_but_end
	
;	mov A, 00h
;	mov X, 00h
;	call LCD_Position
;	mov A, >DEBUG_MODE
;	mov X, <DEBUG_MODE
;	call LCD_PrCString
;	
;	mov A, 00h
;	mov X, 0Ch
;	call LCD_Position
;	mov A, reg[MVW_PP]
;	call LCD_PrHexByte
;	jmp loop

;	call Display_Read_Time
	
	push A
	push X
	
	;call Clean_LCD_Row0
	
	mov [pg6_reference], 00h
	
	mvi A, [pg6_reference]
	mov [read_addr_inc_h], A
	mvi A, [pg6_reference]
	mov [read_addr_inc_m], A
	mvi A, [pg6_reference]
	mov [read_addr_inc_s], A
	mvi A, [pg6_reference]
	mov [read_addr_inc_ms], A

	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, [read_addr_inc_h]
	call LCD_PrHexByte
	
	mov A, 00h
	mov X, 03h
	call LCD_Position
	mov A, [read_addr_inc_m]
	call LCD_PrHexByte
	
	mov A, 00h
	mov X, 06h
	call LCD_Position
	mov A, [read_addr_inc_s]
	call LCD_PrHexByte
	
	mov A, 00h
	mov X, 09h
	call LCD_Position
	mov A, [read_addr_inc_ms]
	call LCD_PrHexByte	
	
	mov A, 00h
	mov X, 0Ch
	call LCD_Position
	mov A, >SAVE
	mov X, <SAVE
	call LCD_PrCString

	
	;inc [count_saved]
		
	
	pop X
	pop A
	
	jmp loop
	
check_but_end:
	cmp [addr_shrt_p], 05h
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h

	
	jmp loop
	
;---------------------END BUTTON MODE----------------------------------------
	
;---------------------START SOUND MODE---------------------------------------
Sound_m:
	mov [flag_val], 00h
	
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >SOUND_MODE
	mov X, <SOUND_MODE
	call LCD_PrCString
	jmp loop
	
;---------------------END SOUND MODE-----------------------------------------
	
;---------------------START MEMORY MODE--------------------------------------

Mem_Display:
	cmp [addr_shrt_p], 01h
	call average
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >MEMORY_MODE
	mov X, <MEMORY_MODE
	lcall LCD_PrCString
	

	
average:
cmp [addr_shrt_p], 02h
	call here_1
lcall _routine_avg
ret
here_1:

mov reg[MVR_PP], 6			;reading from memory page 6
	
	mov [sum_ms], 00h
	mov [sum_sec_LSB], 00h
	mov [sum_sec_MSB], 00h
	mov [sum_min_LSB], 00h
	mov [sum_min_MSB], 00h
	mov [sum_hr], 00h
	
	mov [avg_ms], 00h
	mov [avg_sec], 00h
	mov [avg_min], 00h
	mov [avg_hr], 00h
	
	mov [max_ms], 00h
	mov [max_sec], 00h
	mov [max_min], 00h
	mov [max_hr], 00h
	
	mov [min_ms], 00h
	mov [min_sec], 00h
	mov [min_min], 00h
	mov [min_hr], 00h
	
	mov [pg6_reference], 00h

	cmp [addr_shrt_p], 01h		;maximum/longest mode
	call shortest_time
	
	mov X, 11
	mov [pg6_reference], 00		;bringing the position at pg6 at the starting position
	jmp next
	
next_A:
	add [pg6_reference], 3
	and F, FBh
	jmp next
next_B:
	add [pg6_reference], 2
	and F, FBh
	jmp next
next_C:
	add [pg6_reference], 1
	and F, FBh
	jmp next
	
next:
	dec X
	jz end_max
	mvi A, [pg6_reference]
	cmp A, [max_hr]
	jz check_min_max
	jc next_A
	mov [max_hr], A
	mvi A, [pg6_reference]
	mov [max_min], A
	mvi A, [pg6_reference]
	mov [max_sec], A
	mvi A, [pg6_reference]
	mov [max_ms], A
	jmp next
check_min_max:
	mvi A, [pg6_reference]
	cmp A, [max_min]
	jz check_sec_max
	jc next_B
	mov [max_min], A
	mvi A, [pg6_reference]
	mov [max_sec], A
	mvi A, [pg6_reference]
	mov [max_ms], A
	jmp next
check_sec_max:
	mvi A, [pg6_reference]
	cmp A, [max_sec]
	jz check_ms_max
	jc next_C
	mov [max_sec], A
	mvi A, [pg6_reference]
	mov [max_ms], A
	jmp next
check_ms_max:
	mvi A, [pg6_reference]
	cmp A, [max_ms]
	jz next
	jc next
	mov [max_ms], A
	jmp next

end_max:
	mov A, 01h
	mov X, 00h
	call LCD_Position
	mov A, [max_hr]
	call LCD_PrHexByte
	
	mov A, 01h
	mov X, 03h
	call LCD_Position
	mov A, [max_min]
	call LCD_PrHexByte
	
	mov A, 01h
	mov X, 06h
	call LCD_Position
	mov A, [max_sec]
	call LCD_PrHexByte
	
	mov A, 01h
	mov X, 09h
	call LCD_Position
	mov A, [max_ms]
	call LCD_PrHexByte
	
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, >MAXIMUM
	mov X, <MAXIMUM
	call LCD_PrCString
	
	ret
	
shortest_time:
		
	mov [pg6_reference], 00
	mov X, 10
	mvi A, [pg6_reference]
	mov [min_hr], A
	mvi A, [pg6_reference]
	mov [min_min], A
	mvi A, [pg6_reference]
	mov [min_sec], A
	mvi A, [pg6_reference]
	mov [min_ms], A
	jmp next_values
	
min_loop:
next_1:
	add [pg6_reference], 3
	and F, FBh
	jmp next_values
next_2:
	add [pg6_reference], 2
	and F, FBh
	jmp next_values
next_3:
	add [pg6_reference], 1
	and F, FBh

next_values:
	dec X
	jz end_min
	mvi A, [pg6_reference]
	cmp A, [min_hr]
	jz check_min_min
	jnc next_1
	mov [min_hr], A
	mvi A, [pg6_reference]
	mov [min_min], A
	mvi A, [pg6_reference]
	mov [min_sec], A
	mvi A, [pg6_reference]
	mov [min_ms], A
	jmp next_values
check_min_min:
	mvi A, [pg6_reference]
	cmp A, [min_min]
	jz check_sec_min
	jnc next_2
	mov [min_min], A
	mvi A, [pg6_reference]
	mov [min_sec], A
	mvi A, [pg6_reference]
	mov [min_ms], A
	jmp next_1
check_sec_min:
	mvi A, [pg6_reference]
	cmp A, [min_sec]
	jz check_ms_min
	jnc next_3
	mov [min_sec], A
	mvi A, [pg6_reference]
	mov [min_ms], A
	jmp next_1
check_ms_min:
	mvi A, [pg6_reference]
	cmp A, [min_ms]
	jz next_values
	jnc next_values
	mov [min_ms], A
	jmp next_values
	
end_min:
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, [min_hr]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 03h
	lcall LCD_Position
	mov A, [min_min]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 06h
	lcall LCD_Position
	mov A, [min_sec]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 09h
	lcall LCD_Position
	mov A, [min_ms]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 04h
	lcall LCD_Position
	mov A, >MINIMUM
	mov X, <MINIMUM
	lcall LCD_PrCString
	
	ret
	

;---------------------END MEMORY MODE----------------------------------------
	
.terminate:
    jmp .terminate
	
;---------------------END OF MAIN CODE----------------------------------------
;-----------------------------------------------------------------------------








;-----------------------------------------------------------------------------
;---------------------ROUTINE CALLS-------------------------------------------

;---------------------CLEAN LCD ROW1------------------------------------------
Clean_LCD_Row0:
	push A
	push X
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >CLEAN_LCD
	mov X, <CLEAN_LCD
	lcall LCD_PrCString
	pop X
	pop A
ret
;---------------------END CLEAN LCD ROW1---------------------------------------
	
;---------------------SAVE TIME------------------------------------------------
Save_Time:
    ;push A
	;push X
	
;		cmp [count_saved], 0Ah			;hasn't reached 10 yet
;		jnz write_saved_time

	reset_count:
;		mov [count_saved], 00h			;back to initialized value
;		mov [save_time_index], 00h	
		
		mov reg[MVW_PP], 6				;writing on memory page 6

	write_saved_time:
		;mov A, [addr_inc_ms]
;		mov A, FFh
;		mvi [save_time_index], A
;		;mov A, [addr_inc_s]
;		mov A, EEh
;		mvi [save_time_index], A
;		;mov A, [addr_inc_m]
;		mov A, DDh
;		mvi [save_time_index], A
;		;mov A, [addr_inc_h]
;		mov A, CCh
;		mvi [save_time_index], A
;		
;		inc [count_saved]
;		
;	mov A, 01h
;	mov X, 0Ch
;	call LCD_Position
;	mov A, [count_saved]
;	call LCD_PrHexByte
	
	;pop X
	;pop A
ret

;---------------------READ TIME------------------------------------------------
Read_Time:
    push A
	push X
	
;		cmp [count_saved], 0Ah			;hasn't reached 10 yet
;		jnz write_saved_time
;
;	reset_count:
;		mov [count_saved], 00h			;back to initialized value
;		mov [save_time_index], 00h	

	read_saved_time:
		mvi A, [save_time_index]
		mov [read_addr_inc_ms], A
		mvi A,[save_time_index]
		mov [read_addr_inc_s], A 
		mvi A, [save_time_index]
		mov [read_addr_inc_m], A
		mvi A, [save_time_index]
		mov [read_addr_inc_h], A
	
		call Display_Read_Time
		
		
		;inc [count_saved]
		
	
	pop X
	pop A
ret


;---------------------DISPLAY READ TIME-----------------------------------------
Display_Read_Time:
;    push A
;	push X
;	
;	;call Clean_LCD_Row0
;	
;	
;	mov A, 00h
;	mov X, 00h
;	call LCD_Position
;	mov A, [read_addr_inc_ms]
;	call LCD_PrHexByte
;	
;	mov A, 00h
;	mov X, 03h
;	call LCD_Position
;	mov A, [read_addr_inc_s]
;	call LCD_PrHexByte
;	
;	mov A, 00h
;	mov X, 06h
;	call LCD_Position
;	mov A, [read_addr_inc_m]
;	call LCD_PrHexByte
;	
;	mov A, 00h
;	mov X, 09h
;	call LCD_Position
;	mov A, [read_addr_inc_h]
;	call LCD_PrHexByte	
;		
;		;inc [count_saved]
;		
;	
;	pop X
;	pop A
ret

;---------------------END OF ROUTINE CALLS------------------------------------
;-----------------------------------------------------------------------------



.LITERAL 
THE_STRNG:
ds "EvryTng is Awsme"
db 00h
.ENDLITERAL 

.LITERAL 
TENTHSEC_MODE:
ds "ACC: TENTH      "
db 00h
.ENDLITERAL 

.LITERAL 
HALFSEC_MODE:
ds "ACC: HALF     "
db 00h
.ENDLITERAL 

.LITERAL 
SEC_MODE:
ds "ACC: SEC       "
db 00h
.ENDLITERAL 

.LITERAL 
ACCURACY_MODE:
ds "ACCURACY MODE "
db 00h
.ENDLITERAL

.LITERAL 
BUTTON_MODE:
ds "BUTTON MODE     "
db 00h
.ENDLITERAL

.LITERAL 
DEBUG_MODE:
ds "DEBUG MODE      "
db 00h
.ENDLITERAL

.LITERAL 
CLEAR_TIME:
ds "00:00:00:00     "
db 00h
.ENDLITERAL

.LITERAL 
MINIMUM:
ds "MINIMUM"
db 00h
.ENDLITERAL 

.LITERAL 
MAXIMUM:
ds "MAXIMUM"
db 00h
.ENDLITERAL 

.LITERAL 
THRESHOLD_MODE:
ds "THRESHOLD MODE"
db 00h
.ENDLITERAL 

.LITERAL 
CLEAN_LCD:
ds "                 "
db 00h
.ENDLITERAL 

.LITERAL 
SOUND_MODE:
ds "SOUND MODE       "
db 00h
.ENDLITERAL 

.LITERAL 
MEMORY_MODE:
ds "MEMORY MODE      "
db 00h
.ENDLITERAL 

.LITERAL 
SAVE:
ds "SAVE"
db 00h
.ENDLITERAL 



