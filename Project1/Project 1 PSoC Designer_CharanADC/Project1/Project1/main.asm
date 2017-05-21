;;; Sample ASM Code for the DualADC
;;;
;;; Continuously sample using the DualADC and store the values in RAM.
;;;

include "m8c.inc"       ; part specific constants and macros
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

export iResult1  
export iResult_count
export iResult_Total
export dOpr2
export dOpr1
export dRes

;; Create storage for readings
area bss(RAM) 
iResult_Total:		blk	  4
iResult1:       	BLK   4  ; ADC1 result storage
iResult_count:		blk   4
dOpr2:				blk	  4
dOpr1:				blk	  4
dRes:				blk   4
;iResult2:       BLK   2  ; ADC2 result storage
        ; Export results in case they are

;export iResult2          ; used elsewhere.

area text(ROM,REL)


addr_internal_inc_ms: equ 09h
export _main

_main:
	M8C_EnableIntMask INT_MSK0, INT_MSK0_GPIO 					;enable GPIO Interrupt Mask
	or reg[PRT2IE], 80h
	M8C_EnableIntMask INT_MSK1, INT_MSK1_DBB01					;enable digital block one interrupt
    M8C_EnableGInt                 ; Enable interrupts
	
	mov   A, PGA_1_HIGHPOWER
	;mov   A, PGA_1_MEDPOWER
    lcall PGA_1_Start		;offset
	
	mov   A, PGA_2_HIGHPOWER 
    lcall PGA_2_Start
	
    mov   A, LPF2_1_HIGHPOWER
    lcall LPF2_1_Start
	
    mov   A, 7                    ; Set resolution to 7 Bits
    call  DUALADC_1_SetResolution

    mov   A, DUALADC_1_HIGHPOWER     ; Set Power and Enable A/D
    call  DUALADC_1_Start

    mov   A, 00h                   ; Start A/D in continuous sampling mode - or put 20 to get 20 cycles in A
    call  DUALADC_1_GetSamples
	
	mov [addr_internal_inc_ms],00h
	lcall Timer16_1_Start
	call LCD_Start
;A/D conversion loop
ADC_measurement:
	
	;clear iresult_total
	mov [iResult_Total+3], 00h
	mov [iResult_Total+2], 00h
	mov [iResult_Total+1], 00h
	mov [iResult_Total+0], 00h
	
	mov [iResult_count+3], 00h
	mov [iResult_count+2], 00h
	mov [iResult_count+1], 00h
	mov [iResult_count+0], 00h
	
	mov [addr_internal_inc_ms],00h
wait_1_ADC:                              ; Poll until data is complete
    call  DUALADC_1_fIsDataAvailable
    jz    wait_1_ADC
	M8C_DisableGInt   

    call  DUALADC_1_iGetData1        ; Get ADC1 Data (X=MSB A=LSB)
	M8C_EnableGInt 

	; Reset flag
	call  DUALADC_1_ClearFlag 
	;add the received iResult to total results
	and F, FBh
	
	add	[iResult_Total+3], A 	;save LSB
	mov A, X
	adc [iResult_Total+2], A	;save MSB
	adc [iResult_Total+1], 00h
	adc [iResult_Total+0], 00h
	
	inc  [iResult_count+3]
	adc [iResult_count+2],00h
	adc [iResult_count+1],00h
	adc [iResult_count+0],00h
	
	cmp [addr_internal_inc_ms], 28h
	jnz wait_1_ADC
	
	
	mov [dOpr1+0], [iResult_Total+0]
	mov [dOpr1+1], [iResult_Total+1]
	mov [dOpr1+2], [iResult_Total+2]
	mov [dOpr1+3], [iResult_Total+3]
	
	mov [dOpr2+0], [iResult_count+0]
	mov [dOpr2+1], [iResult_count+1]
	mov [dOpr2+2], [iResult_count+2]
	mov [dOpr2+3], [iResult_count+3]
	
	call divide_32_routine
	mov [iResult1+3], [dRes+3]
	mov [iResult1+2], [dRes+2]
	mov [iResult1+1], [dRes+1]
	mov [iResult1+0], [dRes+0]

	

	
;	cmp [iResult1+0],00h        ; compare lsb of ADC output
;	jnz continue
;	cmp [iResult1+1], 45h       ;compare msb of ADC output
;	jnz continue				
;set:
;	;xor reg[PRT1DR], 80h
;	;lcall DUALADC_1_StopAD
;	or reg[PRT2DR], 80h
continue:
	;M8C_EnableGInt

;	mov A, 00h
;	mov X, 00h
;	call LCD_Position
;	mov A, >dRes
;	mov X, <dRes
;	call LCD_PrCString
	
	;call LCD_Start
	mov A, 01h
	mov X, 00h
	call LCD_Position
	mov A, [iResult_Total+0]
	call LCD_PrHexByte
	
	;call LCD_Start
	mov A, 01h
	mov X, 03h
	call LCD_Position
	mov A, [iResult_Total+1]
	call LCD_PrHexByte
	
		;call LCD_Start
	mov A, 01h
	mov X, 06h
	call LCD_Position
	mov A, [iResult_Total+2]
	call LCD_PrHexByte
	
		;call LCD_Start
	mov A, 01h
	mov X, 09h
	call LCD_Position
	mov A, [iResult_Total+3]
	call LCD_PrHexByte
	
		;call LCD_Start
	mov A, 00h
	mov X, 00h
	call LCD_Position
	mov A, [iResult1+0]
	call LCD_PrHexByte
	
	
	mov A, 00h
	mov X, 03h
	call LCD_Position
	mov A, [iResult1+1]
	call LCD_PrHexByte
	
	mov A, 00h
	mov X, 06h
	call LCD_Position
	mov A, [iResult1+2]
	call LCD_PrHexByte
	
	
	mov A, 00h
	mov X, 09h
	call LCD_Position
	mov A, [iResult1+3]
	call LCD_PrHexByte

    jmp   ADC_measurement

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




.LITERAL 
THE_STRNG:
ds "DUAL ADC"
db 00h
.ENDLITERAL
;