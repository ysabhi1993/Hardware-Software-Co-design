;*******************************************************************************
; AN 2283 - PSoC 1 Measuring Frequency; 
; Project - Frequency Measurement without PLL;
;
; AN Description:
;
; AN2283 discusses various frequency measurement methods using PSoC 1.
;
; File Name: 'freqcode.asm'
;
; Description: Contains assembly functions for starting the frequency
; 				measurement counter.
;
; Author: 				DWV
; Project Version: 		1.1
;
; Project Version Author:
; v1.0 - 					DWV
; v1.1 - 					MSUR
;
;
;
;*******************************************************************************
; Copyright (2014), Cypress Semiconductor Corporation. All Rights Reserved.
;*******************************************************************************
; This software is owned by Cypress Semiconductor Corporation (Cypress)
; and is protected by and subject to worldwide patent protection (United
; States and foreign), United States copyright laws and international treaty
; provisions. Cypress hereby grants to licensee a personal, non-exclusive,
; non-transferable license to copy, use, modify, create derivative works of,
; and compile the Cypress Source Code and derivative works for the sole
; purpose of creating custom software in support of licensee product to be
; used only in conjunction with a Cypress integrated circuit as specified in
; the applicable agreement. Any reproduction, modification, translation,
; compilation, or representation of this software except as specified above 
; is prohibited without the express written permission of Cypress.
;
; Disclaimer: CYPRESS MAKES NO WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, WITH 
; REGARD TO THIS MATERIAL, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
; Cypress reserves the right to make changes without further notice to the 
; materials described herein. Cypress does not assume any liability arising out 
; of the application or use of any product or circuit described herein. Cypress 
; does not authorize its products for use as critical components in life-support 
; systems where a malfunction or failure may reasonably be expected to result in 
; significant injury to the user. The inclusion of Cypress' product in a life-
; support systems application implies that the manufacturer assumes all risk of 
; such use and in doing so indemnifies Cypress against all charges. 
;
; Use of this Software may be limited by and subject to the applicable Cypress
; software license agreement. 
;******************************************************************************/

export _StartFreq
include "m8c.inc"
include "memory.inc"
include "PSoCAPI.inc"
_StartFreq:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >_bDataAvailable
      mov [_cOverFlow],ffh                  ;set tick count to -1
      mov [_wTickCount + 0],ffh             
      mov [_wTickCount + 1],ffh
      mov [_bDataAvailable],0                   ;clear bDataReady0
      and reg[INT_CLR1],~TickTimer_INT_MASK ;clear timer int
      TickTimer_EnableInt_M                 ;enable timer int
      TickTimer_Start_M                     ;start timer 
      and  reg[INT_CLR0],~02h               ;clear comparator int
      or   reg[INT_MSK0],02h                ;enable comparator int    
      RAM_EPILOGUE RAM_USE_CLASS_4 
   ret
