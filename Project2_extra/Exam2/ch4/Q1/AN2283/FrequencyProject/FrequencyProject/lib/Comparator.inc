;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   Comparator.inc
;;  Version: 3.3, Updated on 2013/5/19 at 10:42:26
;;  Generated by PSoC Designer 5.4.2946
;;
;;  DESCRIPTION:  Assembler declarations for the CMPPRG user module interface.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2013. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************


;--------------------------------------------------
; Constants for Comparator API's
;--------------------------------------------------
Comparator_OFF:        equ 0
Comparator_LOWPOWER:   equ 1
Comparator_MEDPOWER:   equ 2
Comparator_HIGHPOWER:  equ 3

Comparator_REF1_000:   equ f0h
Comparator_REF0_937:   equ e0h
Comparator_REF0_875:   equ d0h
Comparator_REF0_812:   equ c0h
Comparator_REF0_750:   equ b0h
Comparator_REF0_688:   equ a0h
Comparator_REF0_625:   equ 90h
Comparator_REF0_562:   equ 80h
Comparator_REF0_500:   equ 70h
Comparator_REF0_437:   equ 60h
Comparator_REF0_375:   equ 50h
Comparator_REF0_312:   equ 40h
Comparator_REF0_250:   equ 30h
Comparator_REF0_188:   equ 20h
Comparator_REF0_125:   equ 10h
Comparator_REF0_062:   equ 00h
Comparator_REF0_042:   equ 14h
Comparator_REF0_021:   equ 04h

;--------------------------------------------------
; Register Address Constants for Comparator
;--------------------------------------------------
Comparator_COMP_CR0:    equ 71h
Comparator_COMP_CR1:    equ 72h
Comparator_COMP_CR2:    equ 73h
Comparator_COMP_CR3:    equ 70h

; end of file Comparator.inc