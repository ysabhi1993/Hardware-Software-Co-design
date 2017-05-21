;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   PGA_3.inc  ( PGA )
;;  Version: 3.2, Updated on 2015/3/4 at 22:26:46
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION:  Assembler declarations for the PGA user module interface.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

;--------------------------------------------------
; Constants for PGA_3 API's.
;--------------------------------------------------

PGA_3_OFF:         equ 0
PGA_3_LOWPOWER:    equ 1
PGA_3_MEDPOWER:    equ 2
PGA_3_HIGHPOWER:   equ 3

PGA_3_G48_0:       equ 0Ch
PGA_3_G24_0:       equ 1Ch
PGA_3_G16_0:       equ 08h
PGA_3_G8_00:       equ 18h
PGA_3_G5_33:       equ 28h
PGA_3_G4_00:       equ 38h
PGA_3_G3_20:       equ 48h
PGA_3_G2_67:       equ 58h
PGA_3_G2_27:       equ 68h
PGA_3_G2_00:       equ 78h
PGA_3_G1_78:       equ 88h
PGA_3_G1_60:       equ 98h
PGA_3_G1_46:       equ A8h
PGA_3_G1_33:       equ B8h
PGA_3_G1_23:       equ C8h
PGA_3_G1_14:       equ D8h
PGA_3_G1_06:       equ E8h
PGA_3_G1_00:       equ F8h
PGA_3_G0_93:       equ E0h
PGA_3_G0_87:       equ D0h
PGA_3_G0_81:       equ C0h
PGA_3_G0_75:       equ B0h
PGA_3_G0_68:       equ A0h
PGA_3_G0_62:       equ 90h
PGA_3_G0_56:       equ 80h
PGA_3_G0_50:       equ 70h
PGA_3_G0_43:       equ 60h
PGA_3_G0_37:       equ 50h
PGA_3_G0_31:       equ 40h
PGA_3_G0_25:       equ 30h
PGA_3_G0_18:       equ 20h
PGA_3_G0_12:       equ 10h
PGA_3_G0_06:       equ 00h

PGA_3_AGNDBUFAPI:  equ 0

;--------------------------------------------------
; Register Address Constants used by PGA_3
;--------------------------------------------------
PGA_3_GAIN_CR0: equ 79h
PGA_3_GAIN_CR1: equ 7ah
PGA_3_GAIN_CR2: equ 7bh
PGA_3_GAIN_CR3: equ 78h
