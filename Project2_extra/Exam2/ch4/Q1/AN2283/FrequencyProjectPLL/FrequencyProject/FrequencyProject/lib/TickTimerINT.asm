;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: TickTimerINT.asm
;;   Version: 2.6, Updated on 2013/5/19 at 10:44:39
;;  Generated by PSoC Designer 5.4.2946
;;
;;  DESCRIPTION: Timer16 Interrupt Service Routine
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2013. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "TickTimer.inc"


;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  _TickTimer_ISR


AREA InterruptRAM (RAM,REL,CON)

;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------
export  _cOverFlow
export _wTickCount
export _wFirstValue
export _wLastValue
export _cSaveOverFlow
export _wSaveTickNum
export _wSaveCountNum
export _bDataAvailable:
;------------------------
; Includes
;------------------------

	
;------------------------
;  Constant Definitions
;------------------------
LSB:	equ 1
MSB:	equ 0

;------------------------
; Variable Allocation
;------------------------
_cOverFlow:      BLK  1
_wTickCount:     BLK  2
_wFirstValue:    BLK  2
_wLastValue:     BLK  2
_cSaveOverFlow:  BLK  1
_wSaveTickNum:   BLK  2
_wSaveCountNum:  BLK  2
_bDataAvailable: BLK  1

;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)


AREA UserModules (ROM, REL)

;-----------------------------------------------------------------------------
;  FUNCTION NAME: _TickTimer_ISR
;
;  DESCRIPTION: Unless modified, this implements only a null handler stub.
;
;-----------------------------------------------------------------------------
;

_TickTimer_ISR:

   ;@PSoC_UserCode_BODY@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom code below this banner
   ;---------------------------------------------------
    push A
	;Move First tick's timer capture value to wSaveCountNum
	;Subtract Last tick's timer capture value from wSaveCountNum 
    mov  [_wSaveCountNum + LSB],[_wFirstValue + LSB]
    mov  [_wSaveCountNum + MSB],[_wFirstValue + MSB]  
    mov  A,[_wLastValue  + LSB]
    sub  [_wSaveCountNum + LSB],A
    mov  A,[_wLastValue  + MSB]
    sbb  [_wSaveCountNum + MSB],A
    
	;Move tick count and cOverFlow values to their respective save values
    mov  [_cSaveOverFlow]    ,[_cOverFlow]
    mov  [_wSaveTickNum + MSB ],[_wTickCount + MSB]
    mov  [_wSaveTickNum + LSB ],[_wTickCount + LSB]
    
	
	;Reset wTickCount and cOverFlow to -1 for the next sample duration
    mov  A,ffh
    mov  [_cOverFlow],A
    mov  [_wTickCount +  MSB],A
    mov  [_wTickCount +  LSB],A
    mov  [_bDataAvailable],A
    pop  A
   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   reti


; end of file TickTimerINT.asm
