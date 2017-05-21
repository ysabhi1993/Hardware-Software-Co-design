/*******************************************************************************
* AN 2283 - PSoC 1 Measuring Frequency; 
* Project - Frequency Measurement with PLL;
*
* AN Description:
*
* AN2283 discusses various frequency measurement methods using PSoC 1.
*
* File Name: 'main.c'
*
* Description: C main file.
*
* Author: 				DWV
* Project Version: 		1.1
*
* Project Version Author:
* v1.0 - 					DWV
* v1.1 - 					MSUR
*
* Project Details:
*
* Overview:
*	The project implements the hybrid frequency measurement described in the AN.
*	F_sample = TickTimer's period = VC3 Freq/65536 = 1 sps in the example
*	F_clock = VC3 itself = 65.21739 kHz
*	Input to the frequency measurement timer comes from P0[7]
*	A sample signal (SampleFreq) is generated by the device itself and routed to P0[5]
*	Sample signal is 1.2346 KHz
*
* Kits Used -
*						CY3210 - PSoCEval1
*						CY3217 - MiniProg1
*						CY8C29466-24PXI - PSoC Device
*
* Pin Details:
*
*	Frequency Input 			 		-	P0.1
*	PWM Output (Test/Sample frequency)  -	P0.0
*	Debug LED output			 		-   P1.0
*	LCD Display		 			 		-	P2.0 to P2.6
*
*
********************************************************************************
* Copyright (2014), Cypress Semiconductor Corporation. All Rights Reserved.
********************************************************************************
* This software is owned by Cypress Semiconductor Corporation (Cypress)
* and is protected by and subject to worldwide patent protection (United
* States and foreign), United States copyright laws and international treaty
* provisions. Cypress hereby grants to licensee a personal, non-exclusive,
* non-transferable license to copy, use, modify, create derivative works of,
* and compile the Cypress Source Code and derivative works for the sole
* purpose of creating custom software in support of licensee product to be
* used only in conjunction with a Cypress integrated circuit as specified in
* the applicable agreement. Any reproduction, modification, translation,
* compilation, or representation of this software except as specified above 
* is prohibited without the express written permission of Cypress.
*
* Disclaimer: CYPRESS MAKES NO WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, WITH 
* REGARD TO THIS MATERIAL, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
* Cypress reserves the right to make changes without further notice to the 
* materials described herein. Cypress does not assume any liability arising out 
* of the application or use of any product or circuit described herein. Cypress 
* does not authorize its products for use as critical components in life-support 
* systems where a malfunction or failure may reasonably be expected to result in 
* significant injury to the user. The inclusion of Cypress' product in a life-
* support systems application implies that the manufacturer assumes all risk of 
* such use and in doing so indemnifies Cypress against all charges. 
*
* Use of this Software may be limited by and subject to the applicable Cypress
* software license agreement. 
*******************************************************************************/

#include <m8c.h> 
#include "PSoCAPI.h" 
#include "FreqCode.h"
#include <stdlib.h>

/* IMO frequency in Hz*/
#define SYSCLOCK     23986176.0

/* F_clock or VC3 frequency */
#define FCLOCK       (SYSCLOCK / 368.0)

/* TickTimer's period */
#define PERIOD       65536.0

/* F_sample */
#define FSAMPLE      (FCLOCK / PERIOD)

/* Imported variables from other files */
extern unsigned char bDataAvailable;
extern unsigned int  wSaveCountNum;
extern signed char   cSaveOverFlow;
extern unsigned int  wSaveTickNum;

/* Function prototypes */
void DisplayValue(void);

/* Global varaibles used in the project */
float fFreqValue = 0.0;
char *pString;
char *pTemp;
int iTemp;


/******************************************************************************
* Function Name: main
*******************************************************************************
*
* Summary:
*  main() performs following functions:
*  1: Enables comparator and the sample frequency for frequency measurement
*  2: Initializes the timer block for measurements
*  3: Waits till the sample time is expired
*  4: Calculates the frequency and updates the measured value on the LCD
*
* Parameters:
*  None.
*
* Return:
*  None.
*
******************************************************************************/
void main(void)
{  
   /* Start the comparator */
   Comparator_Start(Comparator_HIGHPOWER);
   
   /* Start the sample/test frequency output */
   SampleFreq_Start();
   
   /* Enable Input Pullup on SignalInput pin (P0[7] in the design */
   SignalInput_Data_ADDR |= SignalInput_MASK; 
   
   /* Start the LCD */
   LCD_Start(); 
   
   /* Enable globa interrupts */
   M8C_EnableGInt;
   
   /* Start TickTimer, Initialize Variables */
   StartFreq(); 
   
   while(1)
   {     	
      	/* Wait till sample period is complete - bDataAvailable is set */
		while(bDataAvailable == 0x00);
		
		/* Clear the bDataAvailable flag */
		bDataAvailable = 0x00;  
		
		/* Turn ON the LED */
      	LEDOut_Data_ADDR |= LEDOut_MASK; 
		
		/* if overflow count is negative, the tick handler ISR was never executed (as it is initialized with -1), set freq val = 0  */
      	if( cSaveOverFlow < 0 )
	  	{
	  		fFreqValue = 0.0;
		}
		/* Enter this if there were overflows in the tick count (up to 127 overflows) */
      	else if ( cSaveOverFlow > 0)
		{
         	/* Take overflow count into frequency calculation */
			/* Freq = F_sample * ((OverFlow_Count<<16) + Signal_Tick_Counts) */
			fFreqValue  = (float)(cSaveOverFlow);
         	fFreqValue *= 65536.0;
         	fFreqValue += (float) wSaveTickNum;
         	fFreqValue += 1.0;
         	fFreqValue *= FSAMPLE;             
    	} 
	    else
		{		  	
	        /* Control comes here, if there is no overflow */
			/* If the captured counts are 0, the freq = 0 or under range */
			if( wSaveTickNum == 0)
			{
			 	fFreqValue = 0.0;
			}
	        /* else Freq = F_clock * Captured_Timer_Counts / Signal_Tick_Counts */
			else
			{
	            fFreqValue  = (float) wSaveTickNum;
	            fFreqValue *= FCLOCK;
	            fFreqValue /= (float) wSaveCountNum;
	        }
	    }
		
		/* Display the measured frequency value */
      	DisplayValue();
		
		/* turn OFF LED to indicate measurement completion */
      	LEDOut_Data_ADDR &= ~LEDOut_MASK; //LED Off
   }
}

/******************************************************************************
* Function Name: DisplayValue
*******************************************************************************
*
* Summary:
*  Displays the measured frequency in kHz in the LCD along with Signal Tick counts
*	and Captured Timer counts
*
* Parameters:
*  None.
*
* Return:
*  None.
*
******************************************************************************/
void DisplayValue(void)
{
   LCD_Position(1,0);
   LCD_PrHexByte( cSaveOverFlow );
   LCD_PrHexInt(wSaveTickNum);     
   LCD_Position(1,10);   
   LCD_PrHexInt(wSaveCountNum);   
   
   LCD_Position(0,0);
   if(fFreqValue == 0.0)
   {
      LCD_PrCString("Underrange");
   }
   else if(fFreqValue < 0.0)
   {
      LCD_PrCString("Overrange ");   
   }
   else
   {
      if(fFreqValue <10.0 )         fFreqValue +=  0.00005;
      else if(fFreqValue <100.0)    fFreqValue +=  0.0005;
      else if(fFreqValue <1000.0)   fFreqValue +=  0.005;
      else if(fFreqValue <10000.0)  fFreqValue +=  0.05;
      else if(fFreqValue <100000.0) fFreqValue +=  0.5;
      else if(fFreqValue <1000000.0)fFreqValue +=  5.0;      
      else                          fFreqValue += 50.0;
	  
      if(fFreqValue < 1000.0)
	  {
         pString = ftoa(fFreqValue, &iTemp);
         for(pTemp = pString; *pTemp != 0x00; pTemp++); //find the end
         while((pTemp - pString) <6)*pTemp++ = '0';//right fill with "0"s 
         *(pString + 6)=0x00;
         LCD_PrString(pString);
         LCD_PrCString(" Hz ");  
      }
      else
	  {
         fFreqValue /= 1000.0;
         pString = ftoa(fFreqValue, &iTemp);
         for(pTemp = pString; *pTemp != 0x00; pTemp++); //find the end
         while((pTemp - pString) <6)*pTemp++ = '0';//right fill with "0"s 
         *(pString + 6)=0x00;
         LCD_PrString(pString);
         LCD_PrCString("kHz ");            
      }                   
   }
}
