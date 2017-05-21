;  Generated by PSoC Designer 5.4.3191
;
;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: PSoCGPIOINT.asm
;;   Version: 2.0.0.20, Updated on 2003/07/17 at 12:10:35
;;  @PSOC_VERSION
;;
;;  DESCRIPTION: PSoC GPIO Interrupt Service Routine
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "PSoCGPIOINT.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export   PSoC_GPIO_ISR


;-----------------------------------------------
;  Constant Definitions
;-----------------------------------------------


;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------
	

;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------
include "program_defines.inc"
;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)


;-----------------------------------------------------------------------------
;  FUNCTION NAME: PSoC_GPIO_ISR
;
;  DESCRIPTION: Unless modified, this implements only a null handler stub.
;
;-----------------------------------------------------------------------------
;
PSoC_GPIO_ISR:


   ;@PSoC_UserCode_BODY@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom code below this banner
   ;---------------------------------------------------
    	;M8C_DisableGInt
	push A
    push X

	inc [debug_register]
	


	
	mov A,reg[PRT2DR]  ; detect falling edge or rising edge
	and A,80h
	jz falling
	
	rising:
	;mov [addr_internal_inc_ms],00h
	mov [addr_pin_inc_ms],00h
	jmp finished
	
	falling:
;	mov A,[addr_internal_inc_ms]
;	mov X,[addr_internal_inc_ms]
	mov A,[addr_pin_inc_ms]
	mov X,[addr_pin_inc_ms]
	
	sub A,0Ah     ; noise smaller than 0.1s
	jnc shrt_prs         ; not switch noise
	jmp finished
	
	shrt_prs:
	mov A,X     ; noise smaller than 0.1s
	sub A, 1Eh
	jnc lng_prs
	mov [addr_lng_p], 00h
	inc [addr_shrt_p]
	jmp finished
	
	lng_prs:
	mov [addr_lng_p],01h
	mov [addr_shrt_p],00h
	 
    finished:
   	;M8C_EnableGInt;alex1:42PM
	pop X
    pop A
    reti
   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   reti


; end of file PSoCGPIOINT.asm
