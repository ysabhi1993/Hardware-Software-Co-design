;-----------------------------------------------------------------------------
; Assembly main line
;inititalize index page
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules
include "program_defines.inc"

export _main
;export addr_internal_inc_ms
export addr_pin_inc_ms
export addr_adc_inc_ms
export addr_timer_inc_ms
export addr_inc_ms
export addr_inc_s
export addr_inc_m
export addr_inc_h

export addr_timer_flag

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
export iResult_count
export iResult_Total
export dOpr2
export dOpr1
export dRes
export threshold_value
 
export sound_timer_running

export debug_register



area var(RAM)                     
;addr_internal_inc_ms: 	blk 1
addr_timer_inc_ms:		blk 1
addr_pin_inc_ms:		blk 1
addr_adc_inc_ms:		blk 1
addr_inc_ms: 			blk 1
addr_inc_s: 			blk 1
addr_inc_m: 			blk 1
addr_inc_h: 			blk 1
addr_timer_flag:		blk 1

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

iResult_Total:			blk	4
iResult1:       		blk 4  ; ADC1 result storage
iResult_count:			blk 4
dOpr2:					blk	4
dOpr1:					blk	4
dRes:					blk 4

threshold_value:		blk 2
incoming_value:			blk 2
sound_timer_running:	blk 1

debug_register:			blk 1


area text(ROM,REL)
;export time_counter
_main:

 	lcall LCD_Start


Initialize_Interrupt:
	M8C_EnableIntMask INT_MSK1, INT_MSK1_DBB01					;enable digital block one interrupt
	M8C_EnableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask
	M8C_EnableGInt	;enable global interrupts

Initialize_Variables:
	mov [addr_internal_inc_ms],00h
	mov [addr_pin_inc_ms], 00h
	mov [addr_adc_inc_ms], 00h
	mov [addr_timer_inc_ms],00h
	mov [addr_inc_ms],00h
	mov [addr_inc_s],00h
	mov [addr_inc_m],00h
	mov [addr_inc_h],00h
	mov [md_flg],01h
	mov [debug_register], 00h
	mov [save_time_index], 00h
	mov [flag_val], 00h

Set_Up_Anolog:
	mov   A, PGA_1_HIGHPOWER
    lcall PGA_1_Start		;offset
	
	mov   A, PGA_2_HIGHPOWER 
    lcall PGA_2_Start
	
    mov   A, LPF2_1_HIGHPOWER
    lcall LPF2_1_Start
	
    mov   A, 7                    ; Set resolution to 7 Bits -- I think this gets set in GUI? LS
    lcall  DUALADC_1_SetResolution

    mov   A, DUALADC_1_HIGHPOWER     ; Set Power and Enable A/D
    lcall  DUALADC_1_Start

    mov   A, 00h                   ; Start A/D in continuous sampling mode - or put 20 to get 20 cycles in A
    lcall  DUALADC_1_GetSamples
	
	
	lcall Timer16_1_Start
	
	mov reg[MVW_PP], 6				;writing on memory page 6
	mov reg[MVR_PP], 6				;reading from memory page 6
	
	mov reg[CUR_PP], 06h
	
	mov [00h], 00h
	mov [01h], 00h
	mov [02h], 05h
	mov [03h], 42h
	
	mov [04h], 00h
	mov [05h], 00h
	mov [06h], 08h
	mov [07h], 56h

	mov [08h], 00h
	mov [09h], 00h
	mov [0Ah], 01h
	mov [0Bh], 00h
	
	mov [0Ch], 00h
	mov [0Dh], 00h
	mov [0Eh], 00h
	mov [0Fh], 00h
	
	mov [10h], 00h
	mov [11h], 00h
	mov [12h], 00h
	mov [13h], 00h
	
	mov [14h], 00h
	mov [15h], 00h
	mov [16h], 00h
	mov [17h], 00h
	
	mov [18h], 00h
	mov [19h], 00h
	mov [1Ah], 00h
	mov [1Bh], 00h
	
	mov [1Ch], 00h
	mov [1Dh], 00h
	mov [1Eh], 00h
	mov [1Fh], 00h
	
	mov [20h], 00h
	mov [21h], 00h
	mov [22h], 00h
	mov [23h], 00h
	
	mov [24h], 00h
	mov [25h], 00h
	mov [26h], 00h
	mov [27h], 00h
	
	mov reg[CUR_PP], 00h

loop:

	mov A, 00h
	mov X, 0Eh
	lcall LCD_Position
	mov A, [addr_shrt_p]
	lcall LCD_PrHexByte
;	
;	mov A, 01h
;	mov X, 03h
;	lcall LCD_Position
;	mov A, [md_flg]
;	lcall LCD_PrHexByte
;	
;	mov A, 01h
;	mov X, 07h
;	lcall LCD_Position
;	mov A, [debug_register]
;	lcall LCD_PrHexByte
;
;	mov A, 01h
;	mov X, 06h
;	lcall LCD_Position
;	mov A, [addr_pin_inc_ms]
;	lcall LCD_PrHexByte
;	
;	mov A, 01h
;	mov X, 09h
;	lcall LCD_Position
;	mov A, [addr_adc_inc_ms]
;	lcall LCD_PrHexByte

;	mov A, 01h
;	mov X, 0Ch
;	lcall LCD_Position
;	mov A, [threshold_value+1]
;	lcall LCD_PrHexByte
;	
;	mov A, 01h
;	mov X, 0Eh
;	lcall LCD_Position
;	mov A, [addr_timer_inc_ms]
;	lcall LCD_PrHexByte

Chcklngp:
    cmp [addr_lng_p],01h 
	jnz StaySameMode		;if its not set stay in same mode

;	;toggle if you get long press
;	mov A, reg[PRT1DR]
;	xor A, FFh
;	mov reg[PRT1DR], A
	
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
	lcall LCD_Position
	mov A, >ACCURACY_MODE
	mov X, <ACCURACY_MODE
	lcall LCD_PrCString
	
	mov [count_saved], 00h
	
	ljmp loop

check_acc_ms:
	cmp [addr_shrt_p], 01h
	jnz check_acc_halfsec
	mov [addr_acc_mode], tenthsec_mode	;tenth second mode by default
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >TENTHSEC_MODE
	mov X, <TENTHSEC_MODE
	lcall LCD_PrCString
	ljmp loop

check_acc_halfsec:
	cmp [addr_shrt_p] , 02h
	jnz check_acc_sec
	mov [addr_acc_mode], halfsec_mode
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >HALFSEC_MODE
	mov X, <HALFSEC_MODE
	lcall LCD_PrCString
	ljmp loop
	
check_acc_sec:
	cmp [addr_shrt_p] , 03h
	jnz check_acc_end
	mov [addr_acc_mode], sec_mode
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >SEC_MODE
	mov X, <SEC_MODE
	lcall LCD_PrCString
	ljmp loop

check_acc_end:
	cmp [addr_shrt_p], 04h
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h
	
	ljmp loop
	
;---------------------END ACCURACY MODE--------------------------------------
	
;---------------------START THRESHOLD MODE-----------------------------------
	
Threshold_m:
	cmp [addr_shrt_p], 00h
	jnz check_input_sensitivity
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >THRESHOLD_MODE
	mov X, <THRESHOLD_MODE
	lcall LCD_PrCString
	
	
	
	ljmp loop
	
check_input_sensitivity:
	cmp [addr_shrt_p], 01h
	jnz calculate_threshold			;this may just exit without short button press 
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >CLEAN_LCD
	mov X, <CLEAN_LCD
	lcall LCD_PrCString
	ljmp loop
	
calculate_threshold:	
	;clear iresult_total
	cmp [addr_shrt_p], 02h
	jnz calculate_threshold			;this may just exit without short button press
	
	mov [iResult_Total+3], 00h
	mov [iResult_Total+2], 00h
	mov [iResult_Total+1], 00h
	mov [iResult_Total+0], 00h
	
	mov [iResult_count+3], 00h
	mov [iResult_count+2], 00h
	mov [iResult_count+1], 00h
	mov [iResult_count+0], 00h
	
	mov [addr_adc_inc_ms],00h	;reset our little timer - not being used by any routine
wait_1_ADC:                              ; Poll until data is complete
    lcall  DUALADC_1_fIsDataAvailable
    jz    wait_1_ADC
	M8C_DisableGInt   

    lcall  DUALADC_1_iGetData1        ; Get ADC1 Data (X=MSB A=LSB)
	M8C_EnableGInt 

	; Reset flag
	lcall  DUALADC_1_ClearFlag 
	;add the received iResult to total results
	and F, FBh
	
	add	[iResult_Total+3], A 	;save LSB
	mov A, X
	adc [iResult_Total+2], A	;save MSB
	adc [iResult_Total+1], 00h
	adc [iResult_Total+0], 00h
	
	inc [iResult_count+3]
	adc [iResult_count+2],00h
	adc [iResult_count+1],00h
	adc [iResult_count+0],00h
	
	cmp [addr_adc_inc_ms], 28h
	jnz wait_1_ADC
	
	mov [dOpr1+0], [iResult_Total+0]
	mov [dOpr1+1], [iResult_Total+1]
	mov [dOpr1+2], [iResult_Total+2]
	mov [dOpr1+3], [iResult_Total+3]
	
	mov [dOpr2+0], [iResult_count+0]
	mov [dOpr2+1], [iResult_count+1]
	mov [dOpr2+2], [iResult_count+2]
	mov [dOpr2+3], [iResult_count+3]
	
	lcall divide_32_routine
	mov [iResult1+3], [dRes+3]
	mov [iResult1+2], [dRes+2]
	mov [iResult1+1], [dRes+1]
	mov [iResult1+0], [dRes+0]
	
	;save to threshold value
	mov [threshold_value+1], [iResult1+3]
	mov [threshold_value+0], [iResult1+2]
	;shift threshold value to make whistle trigger when it's 2x higher
	asl [threshold_value+1]
	asl [threshold_value+0]
	
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >CALC_THRESH_MODE
	mov X, <CALC_THRESH_MODE
	lcall LCD_PrCString
	
	mov A, 00h
	mov X, 0Bh
	lcall LCD_Position
	mov A, [iResult1+3]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 0Dh
	lcall LCD_Position
	mov A, [threshold_value+1]
	lcall LCD_PrHexByte
	
end_input_sensitivity:
	cmp [addr_shrt_p], 03h	
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h
	
	ljmp loop
	
;---------------------END THRESHOLD MODE--------------------------------------
	
;---------------------START BUTTON MODE---------------------------------------

Button_m:
    cmp [addr_shrt_p], 00h
	jnz check_but_clear
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >BUTTON_MODE
	mov X, <BUTTON_MODE
	lcall LCD_PrCString

check_but_clear:
	cmp [addr_shrt_p], 01h
	jnz check_but_start
	mov [addr_inc_ms], 00h
	mov [addr_inc_s], 00h
	mov [addr_inc_m], 00h
	mov [addr_inc_h], 00h
	mov [addr_timer_flag], 01h 			;new count is starting
	
	
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >CLEAR_TIME
	mov X, <CLEAR_TIME
	lcall LCD_PrCString
	;lcall Display_Time_LCD
	ljmp loop
	
check_but_start:
	cmp [addr_shrt_p], 02h
	jnz check_but_stop

	;check if first entry to timer then reset timer
	cmp [addr_timer_flag], 01h
	jnz button_timer_routine
	;else restart timer
	mov [addr_timer_inc_ms], 00h
	mov [addr_timer_flag], 00h
	
button_timer_routine:
		cmp [addr_acc_mode],sec_mode
		jz label_sec_mode

		cmp [addr_acc_mode],halfsec_mode
		jz label_halfsec_mode

	label_tenthsec_mode:
		;mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp check_ms

	label_halfsec_mode: 
;		mov A, [addr_internal_inc_ms]
		mov A, [addr_timer_inc_ms]
		mov X, A
		cmp A, 32h
		jnz check_if_00
;		mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp check_ms
	check_if_00:
		mov A, X
		cmp A, 00h
		jnz check_ms
;		mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp check_ms
		
	label_sec_mode: 
;		mov A, [addr_internal_inc_ms]					;copy over because you need to compare
		mov A, [addr_timer_inc_ms]
		cmp A, 00h
		jnz check_ms									;keep display value as is
		;if it is 00 
;		mov [addr_inc_ms], [addr_internal_inc_ms]		;update value to be displayed
		mov [addr_inc_ms], [addr_timer_inc_ms]
		;ljmp check_ms
		

	check_ms:
;		mov A, [addr_internal_inc_ms] 	;
		mov A, [addr_timer_inc_ms] 	;
		cmp A, 64h 		;compare to 100
		jnz display_ms
		
	reset_ms:
;		mov [addr_internal_inc_ms], 00h
		mov [addr_timer_inc_ms], 00h
		inc [addr_inc_s]		;increment seconds
		
	display_ms:
		mov A, 00h
		mov X, 09h
		lcall LCD_Position
		mov A, [addr_inc_ms]
		lcall LCD_PrHexByte
		
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
		lcall LCD_Position
		mov A, [addr_inc_s]
		lcall LCD_PrHexByte
		
		
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
		lcall LCD_Position
		mov A, [addr_inc_m]
		lcall LCD_PrHexByte
		
	check_hour:
		mov A, [addr_inc_h]
		cmp A, 18h		;compare with 24
		jnz display_hour
		
	reset_hour:
		mov [addr_inc_h], 00h
		
	display_hour:
		mov A, 00h
		mov X, 00h
		lcall LCD_Position
		mov A, [addr_inc_h]
		lcall LCD_PrHexByte
	ljmp loop
	
check_but_stop:
	cmp [addr_shrt_p], 03h
	jnz before_check_but_end
;	lcall Save_Time
	cmp [flag_val], 01h
	jz saved
	mov [flag_val], 01h
;	mov [count_saved], 00h			;back to initialized value
;	mov [save_time_index], 00

;save_and_count:
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
		
		inc [count_saved]
		
	mov A, 01h
	mov X, 09h
	lcall LCD_Position
	mov A, [count_saved]
	lcall LCD_PrHexByte
	
	
	;inc [addr_shrt_p]
saved:
;	mov [flag_val], 00h
	ljmp loop
	;stop timer

	
before_check_but_end:
	cmp [addr_shrt_p], 04h
	jnz check_but_end
	
	mov [flag_val], 00h
	
;	mov A, 00h
;	mov X, 00h
;	lcall LCD_Position
;	mov A, >DEBUG_MODE
;	mov X, <DEBUG_MODE
;	lcall LCD_PrCString
;	
;	mov A, 00h
;	mov X, 0Ch
;	lcall LCD_Position
;	mov A, reg[MVW_PP]
;	lcall LCD_PrHexByte
;	ljmp loop
;	

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
	lcall LCD_Position
	mov A, [read_addr_inc_h]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 03h
	lcall LCD_Position
	mov A, [read_addr_inc_m]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 06h
	lcall LCD_Position
	mov A, [read_addr_inc_s]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 09h
	lcall LCD_Position
	mov A, [read_addr_inc_ms]
	lcall LCD_PrHexByte	
	
	mov A, 00h
	mov X, 0Ch
	lcall LCD_Position
	mov A, >SAVE
	mov X, <SAVE
	lcall LCD_PrCString
	
check_but_end:
	cmp [addr_shrt_p], 05h
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h
	
	ljmp loop
	
;---------------------END BUTTON MODE----------------------------------------
	
;---------------------START SOUND MODE---------------------------------------
Sound_m:
	cmp [addr_shrt_p], 00h
	jnz start_sound_check
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >SOUND_MODE
	mov X, <SOUND_MODE
	lcall LCD_PrCString
	ljmp loop
	
start_sound_check:
	cmp [addr_shrt_p], 01h
	jnz give_time_for_sound_to_occur_for_start
	
	mov [addr_inc_ms], 00h
	mov [addr_inc_s], 00h
	mov [addr_inc_m], 00h
	mov [addr_inc_h], 00h
	mov [addr_timer_flag], 01h 			;new count is starting
	
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >CLEAR_TIME
	mov X, <CLEAR_TIME
	lcall LCD_PrCString
	ljmp loop
	
give_time_for_sound_to_occur_for_start:	
	;clear iresult_total
	cmp [addr_shrt_p], 02h
	jnz run_timer			;this may just exit without short button press
	
	;disable button press to start timer
	M8C_DisableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask
	
	mov [iResult_Total+3], 00h
	mov [iResult_Total+2], 00h
	mov [iResult_Total+1], 00h
	mov [iResult_Total+0], 00h
	
	mov [iResult_count+3], 00h
	mov [iResult_count+2], 00h
	mov [iResult_count+1], 00h
	mov [iResult_count+0], 00h
	
	mov [addr_adc_inc_ms],00h	;reset our little timer - not being used by any routine
wait_2_ADC:                              ; Poll until data is complete
    lcall  DUALADC_1_fIsDataAvailable
    jz    wait_2_ADC
	M8C_DisableGInt   

    lcall  DUALADC_1_iGetData1        ; Get ADC1 Data (X=MSB A=LSB)
	M8C_EnableGInt 

	; Reset flag
	lcall  DUALADC_1_ClearFlag 
	;add the received iResult to total results
	and F, FBh
	
	add	[iResult_Total+3], A 	;save LSB
	mov A, X
	adc [iResult_Total+2], A	;save MSB
	adc [iResult_Total+1], 00h
	adc [iResult_Total+0], 00h
	
	inc [iResult_count+3]
	adc [iResult_count+2],00h
	adc [iResult_count+1],00h
	adc [iResult_count+0],00h
	
	;cmp [addr_adc_inc_ms], 28h
	cmp [addr_adc_inc_ms], 05h;alex changed
	jnz wait_2_ADC
	
	mov [dOpr1+0], [iResult_Total+0]
	mov [dOpr1+1], [iResult_Total+1]
	mov [dOpr1+2], [iResult_Total+2]
	mov [dOpr1+3], [iResult_Total+3]
	
	mov [dOpr2+0], [iResult_count+0]
	mov [dOpr2+1], [iResult_count+1]
	mov [dOpr2+2], [iResult_count+2]
	mov [dOpr2+3], [iResult_count+3]
	
	lcall divide_32_routine
	mov [iResult1+3], [dRes+3]
	mov [iResult1+2], [dRes+2]
	mov [iResult1+1], [dRes+1]
	mov [iResult1+0], [dRes+0]
	
compare_to_threshold:
	mov A, [iResult1+2]				;holds MSB of of result part that we care about (aka lower two bytes)
    cmp A, [threshold_value+0]		;holds MSB of threshold
	jz check_LSB_of_sound			;if they are both zero than check LSB
	jnc start_sound_timer		;if there was no carry, than incoming MSB is greater than threshold MSB = SOUND!
	ljmp loop					;if there was a carry, than threshold MSB is greater than incoming, so incoming isn't high enough
									;if not check if timing is running and continue running it/not running and continue not running it
	
check_LSB_of_sound:	
	mov A, [iResult1+3]				
	cmp A, [threshold_value+1]
	jnc start_sound_timer					;result is more than threshold
	;ljmp check_run_timer							;if not check if timing is running and continue running it/not running and continue not running it
	ljmp loop


start_sound_timer:

	inc [addr_shrt_p]
	ljmp loop

run_timer:
	cmp [addr_shrt_p], 03h
	jnz dont_run_timer
	
	;re-enable button press
	M8C_EnableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask

	mov A, reg[PRT1DR]
	xor A, FFh
	mov reg[PRT1DR], A
	
	cmp [addr_timer_flag], 01h
	jnz sound_timer_routine
	;else restart timer
	mov [addr_timer_inc_ms], 00h
	mov [addr_timer_flag], 00h


sound_timer_routine:
	
	lcall Sound_mode_generic_timer
	
give_time_for_sound_to_occur_for_stop:	

	
	mov [iResult_Total+3], 00h
	mov [iResult_Total+2], 00h
	mov [iResult_Total+1], 00h
	mov [iResult_Total+0], 00h
	
	mov [iResult_count+3], 00h
	mov [iResult_count+2], 00h
	mov [iResult_count+1], 00h
	mov [iResult_count+0], 00h
	
	mov [addr_adc_inc_ms],00h	;reset our little timer - not being used by any routine
wait_2_ADC_stop:                              ; Poll until data is complete
    lcall  DUALADC_1_fIsDataAvailable
    jz    wait_2_ADC_stop
	M8C_DisableGInt   

    lcall  DUALADC_1_iGetData1        ; Get ADC1 Data (X=MSB A=LSB)
	M8C_EnableGInt 

	; Reset flag
	lcall  DUALADC_1_ClearFlag 
	;add the received iResult to total results
	and F, FBh
	
	add	[iResult_Total+3], A 	;save LSB
	mov A, X
	adc [iResult_Total+2], A	;save MSB
	adc [iResult_Total+1], 00h
	adc [iResult_Total+0], 00h
	
	inc [iResult_count+3]
	adc [iResult_count+2],00h
	adc [iResult_count+1],00h
	adc [iResult_count+0],00h
	
	;cmp [addr_adc_inc_ms], 28h
	cmp [addr_adc_inc_ms], 05h;alex changed
	jnz wait_2_ADC
	
	mov [dOpr1+0], [iResult_Total+0]
	mov [dOpr1+1], [iResult_Total+1]
	mov [dOpr1+2], [iResult_Total+2]
	mov [dOpr1+3], [iResult_Total+3]
	
	mov [dOpr2+0], [iResult_count+0]
	mov [dOpr2+1], [iResult_count+1]
	mov [dOpr2+2], [iResult_count+2]
	mov [dOpr2+3], [iResult_count+3]
	
	lcall divide_32_routine
	mov [iResult1+3], [dRes+3]
	mov [iResult1+2], [dRes+2]
	mov [iResult1+1], [dRes+1]
	mov [iResult1+0], [dRes+0]
	
compare_to_threshold_stop:
	mov A, [iResult1+2]				;holds MSB of of result part that we care about (aka lower two bytes)
    cmp A, [threshold_value+0]		;holds MSB of threshold
	jz check_LSB_of_sound_stop			;if they are both zero than check LSB
	jnc stop_the_sound_timer			;if there was no carry, than incoming MSB is greater than threshold MSB = SOUND!
	ljmp loop				;if there was a carry, than threshold MSB is greater than incoming, so incoming isn't high enough
									;if not check if timing is running and continue running it/not running and continue not running it
	
check_LSB_of_sound_stop:	
	mov A, [iResult1+3]				
	cmp A, [threshold_value+1]
	jnc stop_the_sound_timer					;result is more than threshold
	;ljmp check_run_timer							;if not check if timing is running and continue running it/not running and continue not running it
	ljmp loop	

stop_the_sound_timer:
	inc [addr_shrt_p]			;shrt_p should be 04h
	ljmp loop

dont_run_timer:
	cmp [addr_shrt_p], 04h
	jnz before_check_but_end_sound
	;save time here
	
	cmp [flag_val], 01h
	jz saved_sound
	mov [flag_val], 01h
	
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
	
	inc [count_saved]
	
	mov A, 01h
	mov X, 09h
	lcall LCD_Position
	mov A, [count_saved]
	lcall LCD_PrHexByte
	
saved_sound:
	
	ljmp loop
	
before_check_but_end_sound:
	
	cmp [addr_shrt_p], 04h
	jnz end_sound_check
	
	mov [flag_val], 00h
	
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
	lcall LCD_Position
	mov A, [read_addr_inc_h]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 03h
	lcall LCD_Position
	mov A, [read_addr_inc_m]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 06h
	lcall LCD_Position
	mov A, [read_addr_inc_s]
	lcall LCD_PrHexByte
	
	mov A, 00h
	mov X, 09h
	lcall LCD_Position
	mov A, [read_addr_inc_ms]
	lcall LCD_PrHexByte	
	
	mov A, 00h
	mov X, 0Ch
	lcall LCD_Position
	mov A, >SAVE
	mov X, <SAVE
	lcall LCD_PrCString

	
end_sound_check:
	cmp [addr_shrt_p], 05h	
	jc loop				;make sure SP presses is less than 5 in button mode
	mov [addr_shrt_p], 00h


	ljmp loop
;---------------------END SOUND MODE-----------------------------------------
	
;---------------------START MEMORY MODE--------------------------------------

Mem_Display:
	cmp [addr_shrt_p], 00h
	jnz here_1
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >MEMORY_MODE
	mov X, <MEMORY_MODE
	lcall LCD_PrCString
	ljmp loop
	
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
	
;	mov [pg6_reference], 00h

	cmp [addr_shrt_p], 01h		;maximum/longest mode
	jnz shortest_time
	
	mov X, 11
	mov [pg6_reference], 00		;bringing the position at pg6 at the starting position
	ljmp next
	
next_A:
	add [pg6_reference], 3
	and F, FBh
	ljmp next
next_B:
	add [pg6_reference], 2
	and F, FBh
	ljmp next
next_C:
	add [pg6_reference], 1
	and F, FBh
	ljmp next
	
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
	ljmp next
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
	ljmp next
check_sec_max:
	mvi A, [pg6_reference]
	cmp A, [max_sec]
	jz check_ms_max
	jc next_C
	mov [max_sec], A
	mvi A, [pg6_reference]
	mov [max_ms], A
	ljmp next
check_ms_max:
	mvi A, [pg6_reference]
	cmp A, [max_ms]
	jz next
	jc next
	mov [max_ms], A
	ljmp next

end_max:

;	mov A, 01h
;	mov X, 00h
;	lcall LCD_Position
;	mov A, >CLEAN_LCD
;	mov X, <CLEAN_LCD
;	lcall LCD_PrCString
	
	mov A, 01h
	mov X, 00h
	lcall LCD_Position
	mov A, [max_hr]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 03h
	lcall LCD_Position
	mov A, [max_min]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 06h
	lcall LCD_Position
	mov A, [max_sec]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 09h
	lcall LCD_Position
	mov A, [max_ms]
	lcall LCD_PrHexByte
	
;	mov A, 01h
;	mov X, 00h
;	lcall LCD_Position
;	mov A, >CLEAN_LCD
;	mov X, <CLEAN_LCD
;	lcall LCD_PrCString

	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >MAXIMUM
	mov X, <MAXIMUM
	lcall LCD_PrCString
	
	ljmp loop
	
shortest_time:
	cmp [addr_shrt_p], 02h
	jnz average
	
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
	ljmp next_values
	
min_loop:
next_1:
	add [pg6_reference], 3
	and F, FBh
	ljmp next_values
next_2:
	add [pg6_reference], 2
	and F, FBh
	ljmp next_values
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
	ljmp next_values
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
	ljmp next_1
check_sec_min:
	mvi A, [pg6_reference]
	cmp A, [min_sec]
	jz check_ms_min
	jnc next_3
	mov [min_sec], A
	mvi A, [pg6_reference]
	mov [min_ms], A
	ljmp next_1
check_ms_min:
	mvi A, [pg6_reference]
	cmp A, [min_ms]
	jz next_values
	jnc next_values
	mov [min_ms], A
	ljmp next_values
	
end_min:
;	mov A, 01h
;	mov X, 00h
;	lcall LCD_Position
;	mov A, >CLEAN_LCD
;	mov X, <CLEAN_LCD
;	lcall LCD_PrCString
	
	mov A, 01h
	mov X, 00h
	lcall LCD_Position
	mov A, [min_hr]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 03h
	lcall LCD_Position
	mov A, [min_min]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 06h
	lcall LCD_Position
	mov A, [min_sec]
	lcall LCD_PrHexByte
	
	mov A, 01h
	mov X, 09h
	lcall LCD_Position
	mov A, [min_ms]
	lcall LCD_PrHexByte
	
;	mov A, 00h
;	mov X, 00h
;	lcall LCD_Position
;	mov A, >CLEAN_LCD
;	mov X, <CLEAN_LCD
;	lcall LCD_PrCString
	
	mov A, 00h
	mov X, 00h
	lcall LCD_Position
	mov A, >MINIMUM
	mov X, <MINIMUM
	lcall LCD_PrCString
	
	ljmp loop
average:
	cmp [addr_shrt_p],03h
	jnz end_memory_mode
	
	;Computing sum here
	
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
	ljmp add_tonext_msec

find_q_sec:
	sub A,[input_count]
	inc [quotient_val]
	ljmp compute_avg_sec1
	
add_tonext_msec:
	mov reg[CUR_PP], 06h 		;set Current Page Pointer to 2
	mov [B3h], [91h] 				
	mov reg[CUR_PP], 00h	
	
display_avg:
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

end_memory_mode:
	cmp [addr_shrt_p], 04h
	mov [addr_shrt_p], 00h
	ljmp loop


;---------------------END MEMORY MODE----------------------------------------
	
.terminate:
    ljmp .terminate
	
;---------------------END OF MAIN CODE----------------------------------------
;-----------------------------------------------------------------------------

divide_32_routine:	
	push X ; preserve the X register if necessary 
	mov A, >dRes ; push the address of result variable 
	push A 
	mov A, <dRes 
	push A 
	mov A, [dOpr2+0] ; push the second parameter dOpr2 
	push A 
	mov A, [dOpr2+1] 
	push A 
	mov A, [dOpr2+2] 
	push A 
	mov A, [dOpr2+3] 
	push A 
	mov A, [dOpr1+0] ; push the first parameter dOpr1 
	push A 
	mov A, [dOpr1+1] 
	push A 
	mov A, [dOpr1+2] 
	push A 
	mov A, [dOpr1+3] 
	push A 
	lcall divu_32x32_32 ; do the application 
	add SP, 246 ; pop the stack 
	pop X ; restore the X register if necessary
ret	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;alex charan
Sound_mode_generic_timer:
;check_run_timer:

	;lcall Display_Time_LCD
	;ljmp loop

		cmp [addr_acc_mode],sec_mode
		jz Sound_label_sec_mode

		cmp [addr_acc_mode],halfsec_mode
		jz Sound_label_halfsec_mode

	Sound_label_tenthsec_mode:
		;mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp Sound_check_ms

	Sound_label_halfsec_mode: 
;		mov A, [addr_internal_inc_ms]
		mov A, [addr_timer_inc_ms]
		mov X, A
		cmp A, 32h
		jnz Sound_check_if_00
;		mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp Sound_check_ms
	Sound_check_if_00:
		mov A, X
		cmp A, 00h
		jnz Sound_check_ms
;		mov [addr_inc_ms], [addr_internal_inc_ms]
		mov [addr_inc_ms], [addr_timer_inc_ms]
		ljmp Sound_check_ms
		
	Sound_label_sec_mode: 
;		mov A, [addr_internal_inc_ms]					;copy over because you need to compare
		mov A, [addr_timer_inc_ms]
		cmp A, 00h
		jnz Sound_check_ms									;keep display value as is
		;if it is 00 
;		mov [addr_inc_ms], [addr_internal_inc_ms]		;update value to be displayed
		mov [addr_inc_ms], [addr_timer_inc_ms]
		;ljmp Sound_check_ms
		

	Sound_check_ms:
;		mov A, [addr_internal_inc_ms] 	;
		mov A, [addr_timer_inc_ms] 	;
		cmp A, 64h 		;compare to 100
		jnz Sound_display_ms
		
	Sound_reset_ms:
;		mov [addr_internal_inc_ms], 00h
		mov [addr_timer_inc_ms], 00h
		inc [addr_inc_s]		;increment seconds
		
	Sound_display_ms:
		mov A, 00h
		mov X, 09h
		lcall LCD_Position
		mov A, [addr_inc_ms]
		lcall LCD_PrHexByte
		
	Sound_check_sec:	
		mov A, [addr_inc_s]	;move [251] to A as to not mess up the actual number in [251] during compare
		cmp A, 3Ch		;compare with 60
						;need to check CF : if it's not set than [251] is larger than 60
		jnz Sound_display_sec

	Sound_reset_sec:
		mov [addr_inc_s],00h
		inc [addr_inc_m]		;increment minutes
		
	Sound_display_sec:
	    mov A, 00h
		mov X, 06h
		lcall LCD_Position
		mov A, [addr_inc_s]
		lcall LCD_PrHexByte
		
		
	Sound_check_min:
		mov A, [addr_inc_m]	;move [251] to A as to not mess up the actual number in [251] during compare
		cmp A, 3Ch		;compare with 60
						;need to check CF : if it's not set than [251] is larger than 60
		jnz Sound_display_min

	Sound_reset_min:
		mov [addr_inc_s],00h
		inc [addr_inc_h]

	Sound_display_min:
	    mov A, 00h
		mov X, 03h
		lcall LCD_Position
		mov A, [addr_inc_m]
		lcall LCD_PrHexByte
		
	Sound_check_hour:
		mov A, [addr_inc_h]
		cmp A, 18h		;compare with 24
		jnz Sound_display_hour
		
	Sound_reset_hour:
		mov [addr_inc_h], 00h
		
	Sound_display_hour:
		mov A, 00h
		mov X, 00h
		lcall LCD_Position
		mov A, [addr_inc_h]
		lcall LCD_PrHexByte
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;-----------------------------------------------------------------------------
;---------------------ROUTINE lcallS-------------------------------------------


;---------------------END OF ROUTINE lcallS------------------------------------
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
ds "BUTTON MODE    "
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
MEMORY_MODE:
ds "MEMORY MODE     "
db 00h
.ENDLITERAL

.LITERAL 
THRESHOLD_MODE:
ds "THRESHOLD MODE  "
db 00h
.ENDLITERAL


.LITERAL 
CALC_THRESH_MODE:
ds "CALC THRESH:    "
db 00h
.ENDLITERAL

.LITERAL 
WHISTLE_MODE:
ds "WHISTLE:        "
db 00h
.ENDLITERAL

.LITERAL 
SOUND_MODE:
ds "SOUND MODE      "
db 00h
.ENDLITERAL

.LITERAL 
SOUND_TIMER:
ds "START S TIMER   "
db 00h
.ENDLITERAL

.LITERAL 
STOP_SOUND_TIMER:
ds "STOP S TIMER    "
db 00h
.ENDLITERAL

.LITERAL 
CLEAN_LCD:
ds "                "
db 00h
.ENDLITERAL


.LITERAL 
SAVE:
ds "SAVE"
db 00h
.ENDLITERAL 

.LITERAL 
THREE_SPACE:
ds "   "
db 00h
.ENDLITERAL 

.LITERAL 
NINE_SPACE:
ds "         "
db 00h
.ENDLITERAL 

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

.LITERAL 
MINIMUM:
ds "MINIMUM         "
db 00h
.ENDLITERAL 

.LITERAL 
MAXIMUM:
ds "MAXIMUM          "
db 00h
.ENDLITERAL 
