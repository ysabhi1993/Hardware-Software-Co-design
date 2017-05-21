;  Generated by PSoC Designer 5.4.3191
;
; =============================================================================
; FILENAME: PSoCConfigTBL.asm
;  
; Copyright (c) Cypress Semiconductor 2013. All Rights Reserved.
;  
; NOTES:
; Do not modify this file. It is generated by PSoC Designer each time the
; generate application function is run. The values of the parameters in this
; file can be modified by changing the values of the global parameters in the
; device editor.
;  
; =============================================================================
 
include "m8c.inc"
;  Personalization tables 
export LoadConfigTBL_project1_Bank1
export LoadConfigTBL_project1_Bank0
export LoadConfigTBL_project1_Ordered
AREA lit(rom, rel)
LoadConfigTBL_project1_Bank0:
;  Instance name DUALADC_1, User Module DUALADC
;       Instance name DUALADC_1, Block Name ADC1(ASD20)
	db		90h, 90h		;DUALADC_1_bfADC1cr0(ASD20CR0)
	db		91h, a0h		;DUALADC_1_bfADC1cr1(ASD20CR1)
	db		92h, 61h		;DUALADC_1_bfADC1cr2(ASD20CR2)
	db		93h, f0h		;DUALADC_1_bfADC1cr3(ASD20CR3)
;       Instance name DUALADC_1, Block Name ADC2(ASD22)
	db		98h, 90h		;DUALADC_1_bfADC2cr0(ASD22CR0)
	db		99h, a0h		;DUALADC_1_bfADC2cr1(ASD22CR1)
	db		9ah, 60h		;DUALADC_1_bfADC2cr2(ASD22CR2)
	db		9bh, f0h		;DUALADC_1_bfADC2cr3(ASD22CR3)
;       Instance name DUALADC_1, Block Name CNT1(DBB20)
	db		43h, 00h		;DUALADC_1_bCounter1_CR0(DBB20CR0)
	db		41h, 00h		;DUALADC_1_bPeriod1(DBB20DR1)
	db		42h, 00h		;DUALADC_1_bCompare1(DBB20DR2)
;       Instance name DUALADC_1, Block Name CNT2(DCB23)
	db		4fh, 00h		;DUALADC_1_bCounter2_CR0(DCB23CR0)
	db		4dh, 00h		;DUALADC_1_bPeriod2(DCB23DR1)
	db		4eh, 00h		;DUALADC_1_bCompare2(DCB23DR2)
;       Instance name DUALADC_1, Block Name PWM16_LSB(DBB21)
	db		47h, 00h		;DUALADC_1_fPWM_LSB_CR0(DBB21CR0)
	db		45h, 00h		;DUALADC_1_bPWM_Period_LSB(DBB21DR1)
	db		46h, 00h		;DUALADC_1_bPWM_IntTime_LSB(DBB21DR2)
;       Instance name DUALADC_1, Block Name PWM16_MSB(DCB22)
	db		4bh, 00h		;DUALADC_1_fPWM_MSB_CR0(DCB22CR0)
	db		49h, 00h		;DUALADC_1_bPWM_Period_MSB(DCB22DR1)
	db		4ah, 00h		;DUALADC_1_bPWM_IntTime_MSB(DCB22DR2)
;  Instance name LCD, User Module LCD
;  Instance name LPF2_1, User Module LPF2
;       Instance name LPF2_1, Block Name FLIN(ASC10)
	db		80h, 94h		;LPF2_1_FLIN_CR0(ASC10CR0)
	db		81h, 88h		;LPF2_1_FLIN_CR1(ASC10CR1)
	db		82h, 00h		;LPF2_1_FLIN_CR2(ASC10CR2)
	db		83h, 24h		;LPF2_1_FLIN_CR3(ASC10CR3)
;       Instance name LPF2_1, Block Name FLOUT(ASD11)
	db		84h, 92h		;LPF2_1_FLOUT_CR0(ASD11CR0)
	db		85h, 40h		;LPF2_1_FLOUT_CR1(ASD11CR1)
	db		86h, 9fh		;LPF2_1_FLOUT_CR2(ASD11CR2)
	db		87h, 20h		;LPF2_1_FLOUT_CR3(ASD11CR3)
;  Instance name LPF2_2, User Module LPF2
;       Instance name LPF2_2, Block Name FLIN(ASC12)
	db		88h, 94h		;LPF2_2_FLIN_CR0(ASC12CR0)
	db		89h, 88h		;LPF2_2_FLIN_CR1(ASC12CR1)
	db		8ah, 00h		;LPF2_2_FLIN_CR2(ASC12CR2)
	db		8bh, 24h		;LPF2_2_FLIN_CR3(ASC12CR3)
;       Instance name LPF2_2, Block Name FLOUT(ASD13)
	db		8ch, 92h		;LPF2_2_FLOUT_CR0(ASD13CR0)
	db		8dh, 40h		;LPF2_2_FLOUT_CR1(ASD13CR1)
	db		8eh, 9fh		;LPF2_2_FLOUT_CR2(ASD13CR2)
	db		8fh, 20h		;LPF2_2_FLOUT_CR3(ASD13CR3)
;  Instance name PGA_1, User Module PGA
;       Instance name PGA_1, Block Name GAIN(ACB00)
	db		71h, fdh		;PGA_1_GAIN_CR0(ACB00CR0)
	db		72h, a3h		;PGA_1_GAIN_CR1(ACB00CR1)
	db		73h, 20h		;PGA_1_GAIN_CR2(ACB00CR2)
	db		70h, 00h		;PGA_1_GAIN_CR3(ACB00CR3)
;  Instance name PGA_2, User Module PGA
;       Instance name PGA_2, Block Name GAIN(ACB01)
	db		75h, 1dh		;PGA_2_GAIN_CR0(ACB01CR0)
	db		76h, 21h		;PGA_2_GAIN_CR1(ACB01CR1)
	db		77h, 20h		;PGA_2_GAIN_CR2(ACB01CR2)
	db		74h, 01h		;PGA_2_GAIN_CR3(ACB01CR3)
;  Instance name PGA_3, User Module PGA
;       Instance name PGA_3, Block Name GAIN(ACB02)
	db		79h, fdh		;PGA_3_GAIN_CR0(ACB02CR0)
	db		7ah, a3h		;PGA_3_GAIN_CR1(ACB02CR1)
	db		7bh, 20h		;PGA_3_GAIN_CR2(ACB02CR2)
	db		78h, 00h		;PGA_3_GAIN_CR3(ACB02CR3)
;  Instance name PGA_4, User Module PGA
;       Instance name PGA_4, Block Name GAIN(ACB03)
	db		7dh, 1dh		;PGA_4_GAIN_CR0(ACB03CR0)
	db		7eh, 21h		;PGA_4_GAIN_CR1(ACB03CR1)
	db		7fh, 20h		;PGA_4_GAIN_CR2(ACB03CR2)
	db		7ch, 01h		;PGA_4_GAIN_CR3(ACB03CR3)
;  Instance name Timer16_1, User Module Timer16
;       Instance name Timer16_1, Block Name TIMER16_LSB(DBB00)
	db		23h, 00h		;Timer16_1_CONTROL_LSB_REG(DBB00CR0)
	db		21h, 98h		;Timer16_1_PERIOD_LSB_REG(DBB00DR1)
	db		22h, 00h		;Timer16_1_COMPARE_LSB_REG(DBB00DR2)
;       Instance name Timer16_1, Block Name TIMER16_MSB(DBB01)
	db		27h, 04h		;Timer16_1_CONTROL_MSB_REG(DBB01CR0)
	db		25h, 3ah		;Timer16_1_PERIOD_MSB_REG(DBB01DR1)
	db		26h, 00h		;Timer16_1_COMPARE_MSB_REG(DBB01DR2)
;  Global Register values Bank 0
	db		60h, 28h		; AnalogColumnInputSelect register (AMX_IN)
	db		66h, 00h		; AnalogComparatorControl1 register (CMP_CR1)
	db		63h, 15h		; AnalogReferenceControl register (ARF_CR)
	db		65h, 00h		; AnalogSyncControl register (ASY_CR)
	db		e6h, 50h		; DecimatorControl_0 register (DEC_CR0)
	db		e7h, 20h		; DecimatorControl_1 register (DEC_CR1)
	db		d6h, 00h		; I2CConfig register (I2C_CFG)
	db		b0h, 00h		; Row_0_InputMux register (RDI0RI)
	db		b1h, 00h		; Row_0_InputSync register (RDI0SYN)
	db		b2h, 00h		; Row_0_LogicInputAMux register (RDI0IS)
	db		b3h, 33h		; Row_0_LogicSelect_0 register (RDI0LT0)
	db		b4h, 33h		; Row_0_LogicSelect_1 register (RDI0LT1)
	db		b5h, 00h		; Row_0_OutputDrive_0 register (RDI0SRO0)
	db		b6h, 00h		; Row_0_OutputDrive_1 register (RDI0SRO1)
	db		b8h, 55h		; Row_1_InputMux register (RDI1RI)
	db		b9h, 00h		; Row_1_InputSync register (RDI1SYN)
	db		bah, 10h		; Row_1_LogicInputAMux register (RDI1IS)
	db		bbh, 33h		; Row_1_LogicSelect_0 register (RDI1LT0)
	db		bch, 33h		; Row_1_LogicSelect_1 register (RDI1LT1)
	db		bdh, 00h		; Row_1_OutputDrive_0 register (RDI1SRO0)
	db		beh, 00h		; Row_1_OutputDrive_1 register (RDI1SRO1)
	db		c0h, 00h		; Row_2_InputMux register (RDI2RI)
	db		c1h, 00h		; Row_2_InputSync register (RDI2SYN)
	db		c2h, 20h		; Row_2_LogicInputAMux register (RDI2IS)
	db		c3h, 33h		; Row_2_LogicSelect_0 register (RDI2LT0)
	db		c4h, 33h		; Row_2_LogicSelect_1 register (RDI3LT1)
	db		c5h, 00h		; Row_2_OutputDrive_0 register (RDI2SRO0)
	db		c6h, 00h		; Row_2_OutputDrive_1 register (RDI2SRO1)
	db		c8h, 55h		; Row_3_InputMux register (RDI3RI)
	db		c9h, 00h		; Row_3_InputSync register (RDI3SYN)
	db		cah, 30h		; Row_3_LogicInputAMux register (RDI3IS)
	db		cbh, 33h		; Row_3_LogicSelect_0 register (RDI3LT0)
	db		cch, 33h		; Row_3_LogicSelect_1 register (RDI3LT1)
	db		cdh, 00h		; Row_3_OutputDrive_0 register (RDI3SRO0)
	db		ceh, 00h		; Row_3_OutputDrive_1 register (RDI3SRO1)
	db		6ch, 00h		; TMP_DR0 register (TMP_DR0)
	db		6dh, 00h		; TMP_DR1 register (TMP_DR1)
	db		6eh, 00h		; TMP_DR2 register (TMP_DR2)
	db		6fh, 00h		; TMP_DR3 register (TMP_DR3)
	db		ffh
LoadConfigTBL_project1_Bank1:
;  Instance name DUALADC_1, User Module DUALADC
;       Instance name DUALADC_1, Block Name ADC1(ASD20)
;       Instance name DUALADC_1, Block Name ADC2(ASD22)
;       Instance name DUALADC_1, Block Name CNT1(DBB20)
	db		40h, 21h		;DUALADC_1_fCounter1FN(DBB20FN)
	db		41h, 45h		;DUALADC_1_fCounter1SL(DBA20IN)
	db		42h, 40h		;DUALADC_1_fCounter1OS(DBA20OU)
;       Instance name DUALADC_1, Block Name CNT2(DCB23)
	db		4ch, 21h		;DUALADC_1_fCounter2FN(DCB23FN)
	db		4dh, 65h		;DUALADC_1_fCounter2SL(DCB23IN)
	db		4eh, 40h		;DUALADC_1_fCounter2OS(DCB23OU)
;       Instance name DUALADC_1, Block Name PWM16_LSB(DBB21)
	db		44h, 01h		;DUALADC_1_bfPWM_LSB_FN(DBB21FN)
	db		45h, 15h		;DUALADC_1_(DBB21IN)
	db		46h, 40h		;DUALADC_1_(DBB21OU)
;       Instance name DUALADC_1, Block Name PWM16_MSB(DCB22)
	db		48h, 21h		;DUALADC_1_bfPWM_MSB_FN(DCB22FN)
	db		49h, 35h		;DUALADC_1_(DCB22IN)
	db		4ah, 40h		;DUALADC_1_(DCB22OU)
;  Instance name LCD, User Module LCD
;  Instance name LPF2_1, User Module LPF2
;       Instance name LPF2_1, Block Name FLIN(ASC10)
;       Instance name LPF2_1, Block Name FLOUT(ASD11)
;  Instance name LPF2_2, User Module LPF2
;       Instance name LPF2_2, Block Name FLIN(ASC12)
;       Instance name LPF2_2, Block Name FLOUT(ASD13)
;  Instance name PGA_1, User Module PGA
;       Instance name PGA_1, Block Name GAIN(ACB00)
;  Instance name PGA_2, User Module PGA
;       Instance name PGA_2, Block Name GAIN(ACB01)
;  Instance name PGA_3, User Module PGA
;       Instance name PGA_3, Block Name GAIN(ACB02)
;  Instance name PGA_4, User Module PGA
;       Instance name PGA_4, Block Name GAIN(ACB03)
;  Instance name Timer16_1, User Module Timer16
;       Instance name Timer16_1, Block Name TIMER16_LSB(DBB00)
	db		20h, 10h		;Timer16_1_FUNC_LSB_REG(DBB00FN)
	db		21h, 01h		;Timer16_1_INPUT_LSB_REG(DBB00IN)
	db		22h, 40h		;Timer16_1_OUTPUT_LSB_REG(DBB00OU)
;       Instance name Timer16_1, Block Name TIMER16_MSB(DBB01)
	db		24h, 30h		;Timer16_1_FUNC_MSB_REG(DBB01FN)
	db		25h, 31h		;Timer16_1_INPUT_MSB_REG(DBB01IN)
	db		26h, 40h		;Timer16_1_OUTPUT_MSB_REG(DBB01OU)
;  Global Register values Bank 1
	db		61h, 00h		; AnalogClockSelect1 register (CLK_CR1)
	db		69h, 00h		; AnalogClockSelect2 register (CLK_CR2)
	db		60h, 00h		; AnalogColumnClockSelect register (CLK_CR0)
	db		62h, bch		; AnalogIOControl_0 register (ABF_CR0)
	db		67h, 33h		; AnalogLUTControl0 register (ALT_CR0)
	db		68h, 33h		; AnalogLUTControl1 register (ALT_CR1)
	db		63h, 00h		; AnalogModulatorControl_0 register (AMD_CR0)
	db		66h, 00h		; AnalogModulatorControl_1 register (AMD_CR1)
	db		d1h, 00h		; GlobalDigitalInterconnect_Drive_Even_Input register (GDI_E_IN)
	db		d3h, 00h		; GlobalDigitalInterconnect_Drive_Even_Output register (GDI_E_OU)
	db		d0h, 00h		; GlobalDigitalInterconnect_Drive_Odd_Input register (GDI_O_IN)
	db		d2h, 00h		; GlobalDigitalInterconnect_Drive_Odd_Output register (GDI_O_OU)
	db		e1h, 27h		; OscillatorControl_1 register (OSC_CR1)
	db		e2h, 00h		; OscillatorControl_2 register (OSC_CR2)
	db		dfh, 0fh		; OscillatorControl_3 register (OSC_CR3)
	db		deh, 00h		; OscillatorControl_4 register (OSC_CR4)
	db		ddh, 00h		; OscillatorGlobalBusEnableControl register (OSC_GO_EN)
	db		e7h, 00h		; Type2Decimator_Control register (DEC_CR2)
	db		ffh
AREA psoc_config(rom, rel)
LoadConfigTBL_project1_Ordered:
;  Ordered Global Register values
	M8C_SetBank0
	mov	reg[00h], 00h		; Port_0_Data register (PRT0DR)
	M8C_SetBank1
	mov	reg[00h], 00h		; Port_0_DriveMode_0 register (PRT0DM0)
	mov	reg[01h], ffh		; Port_0_DriveMode_1 register (PRT0DM1)
	M8C_SetBank0
	mov	reg[03h], ffh		; Port_0_DriveMode_2 register (PRT0DM2)
	mov	reg[02h], 00h		; Port_0_GlobalSelect register (PRT0GS)
	M8C_SetBank1
	mov	reg[02h], 00h		; Port_0_IntCtrl_0 register (PRT0IC0)
	mov	reg[03h], 00h		; Port_0_IntCtrl_1 register (PRT0IC1)
	M8C_SetBank0
	mov	reg[01h], 00h		; Port_0_IntEn register (PRT0IE)
	mov	reg[04h], 00h		; Port_1_Data register (PRT1DR)
	M8C_SetBank1
	mov	reg[04h], 80h		; Port_1_DriveMode_0 register (PRT1DM0)
	mov	reg[05h], 7fh		; Port_1_DriveMode_1 register (PRT1DM1)
	M8C_SetBank0
	mov	reg[07h], 7fh		; Port_1_DriveMode_2 register (PRT1DM2)
	mov	reg[06h], 00h		; Port_1_GlobalSelect register (PRT1GS)
	M8C_SetBank1
	mov	reg[06h], 00h		; Port_1_IntCtrl_0 register (PRT1IC0)
	mov	reg[07h], 00h		; Port_1_IntCtrl_1 register (PRT1IC1)
	M8C_SetBank0
	mov	reg[05h], 00h		; Port_1_IntEn register (PRT1IE)
	mov	reg[08h], 00h		; Port_2_Data register (PRT2DR)
	M8C_SetBank1
	mov	reg[08h], ffh		; Port_2_DriveMode_0 register (PRT2DM0)
	mov	reg[09h], 00h		; Port_2_DriveMode_1 register (PRT2DM1)
	M8C_SetBank0
	mov	reg[0bh], 00h		; Port_2_DriveMode_2 register (PRT2DM2)
	mov	reg[0ah], 00h		; Port_2_GlobalSelect register (PRT2GS)
	M8C_SetBank1
	mov	reg[0ah], 00h		; Port_2_IntCtrl_0 register (PRT2IC0)
	mov	reg[0bh], 80h		; Port_2_IntCtrl_1 register (PRT2IC1)
	M8C_SetBank0
	mov	reg[09h], 80h		; Port_2_IntEn register (PRT2IE)
	mov	reg[0ch], 00h		; Port_3_Data register (PRT3DR)
	M8C_SetBank1
	mov	reg[0ch], 00h		; Port_3_DriveMode_0 register (PRT3DM0)
	mov	reg[0dh], 00h		; Port_3_DriveMode_1 register (PRT3DM1)
	M8C_SetBank0
	mov	reg[0fh], 00h		; Port_3_DriveMode_2 register (PRT3DM2)
	mov	reg[0eh], 00h		; Port_3_GlobalSelect register (PRT3GS)
	M8C_SetBank1
	mov	reg[0eh], 00h		; Port_3_IntCtrl_0 register (PRT3IC0)
	mov	reg[0fh], 00h		; Port_3_IntCtrl_1 register (PRT3IC1)
	M8C_SetBank0
	mov	reg[0dh], 00h		; Port_3_IntEn register (PRT3IE)
	mov	reg[10h], 00h		; Port_4_Data register (PRT4DR)
	M8C_SetBank1
	mov	reg[10h], 00h		; Port_4_DriveMode_0 register (PRT4DM0)
	mov	reg[11h], 00h		; Port_4_DriveMode_1 register (PRT4DM1)
	M8C_SetBank0
	mov	reg[13h], 00h		; Port_4_DriveMode_2 register (PRT4DM2)
	mov	reg[12h], 00h		; Port_4_GlobalSelect register (PRT4GS)
	M8C_SetBank1
	mov	reg[12h], 00h		; Port_4_IntCtrl_0 register (PRT4IC0)
	mov	reg[13h], 00h		; Port_4_IntCtrl_1 register (PRT4IC1)
	M8C_SetBank0
	mov	reg[11h], 00h		; Port_4_IntEn register (PRT4IE)
	mov	reg[14h], 00h		; Port_5_Data register (PRT5DR)
	M8C_SetBank1
	mov	reg[14h], 00h		; Port_5_DriveMode_0 register (PRT5DM0)
	mov	reg[15h], 00h		; Port_5_DriveMode_1 register (PRT5DM1)
	M8C_SetBank0
	mov	reg[17h], 00h		; Port_5_DriveMode_2 register (PRT5DM2)
	mov	reg[16h], 00h		; Port_5_GlobalSelect register (PRT5GS)
	M8C_SetBank1
	mov	reg[16h], 00h		; Port_5_IntCtrl_0 register (PRT5IC0)
	mov	reg[17h], 00h		; Port_5_IntCtrl_1 register (PRT5IC1)
	M8C_SetBank0
	mov	reg[15h], 00h		; Port_5_IntEn register (PRT5IE)
	mov	reg[18h], 00h		; Port_6_Data register (PRT6DR)
	M8C_SetBank1
	mov	reg[18h], 00h		; Port_6_DriveMode_0 register (PRT6DM0)
	mov	reg[19h], 00h		; Port_6_DriveMode_1 register (PRT6DM1)
	M8C_SetBank0
	mov	reg[1bh], 00h		; Port_6_DriveMode_2 register (PRT6DM2)
	mov	reg[1ah], 00h		; Port_6_GlobalSelect register (PRT6GS)
	M8C_SetBank1
	mov	reg[1ah], 00h		; Port_6_IntCtrl_0 register (PRT6IC0)
	mov	reg[1bh], 00h		; Port_6_IntCtrl_1 register (PRT6IC1)
	M8C_SetBank0
	mov	reg[19h], 00h		; Port_6_IntEn register (PRT6IE)
	mov	reg[1ch], 00h		; Port_7_Data register (PRT7DR)
	M8C_SetBank1
	mov	reg[1ch], 00h		; Port_7_DriveMode_0 register (PRT7DM0)
	mov	reg[1dh], 00h		; Port_7_DriveMode_1 register (PRT7DM1)
	M8C_SetBank0
	mov	reg[1fh], 00h		; Port_7_DriveMode_2 register (PRT7DM2)
	mov	reg[1eh], 00h		; Port_7_GlobalSelect register (PRT7GS)
	M8C_SetBank1
	mov	reg[1eh], 00h		; Port_7_IntCtrl_0 register (PRT7IC0)
	mov	reg[1fh], 00h		; Port_7_IntCtrl_1 register (PRT7IC1)
	M8C_SetBank0
	mov	reg[1dh], 00h		; Port_7_IntEn register (PRT7IE)
	M8C_SetBank0
	ret


; PSoC Configuration file trailer PsocConfig.asm
