//--------------------------------------------------------------------------
//
// Copyright 2008, Cypress Semiconductor Corporation.
//
// This software is owned by Cypress Semiconductor Corporation (Cypress)
// and is protected by and subject to worldwide patent protection (United
// States and foreign), United States copyright laws and international
// treaty provisions. Cypress hereby grants to licensee a personal,
// non-exclusive, non-transferable license to copy, use, modify, create
// derivative works of, and compile the Cypress Source Code and derivative
// works for the sole purpose of creating custom software in support of
// licensee product to be used only in conjunction with a Cypress integrated
// circuit as specified in the applicable agreement. Any reproduction,
// modification, translation, compilation, or representation of this
// software except as specified above is prohibited without the express
// written permission of Cypress.
//
// Disclaimer: CYPRESS MAKES NO WARRANTY OF ANY KIND,EXPRESS OR IMPLIED,
// WITH REGARD TO THIS MATERIAL, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// Cypress reserves the right to make changes without further notice to the
// materials described herein. Cypress does not assume any liability arising
// out of the application or use of any product or circuit described herein.
// Cypress does not authorize its products for use as critical components in
// life-support systems where a malfunction or failure may reasonably be
// expected to result in significant injury to the user. The inclusion of
// Cypress' product in a life-support systems application implies that the
// manufacturer assumes all risk of such use and in doing so indemnifies
// Cypress against all charges.
//
// Use may be limited by and subject to the applicable Cypress software
// license agreement.
//*****************************************************************************
//  FILENAME: main.c
//   Version: *C, Updated on 08 August 2012
//
//  DESCRIPTION: Main file of the Example_CRC Project.
//
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress MicroSystems 2000-2003. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
//
//         CY3210-PSoCEVAL1 Board Project
//Project Objective
//    To demonstrate the operation of the CRC usermodule of the PSoC microcontroller.  For 
//    communication this project uses SPI Master (SPIM) user module. 
//
//Overview
//    A string of 10 characters is transmitted out through MOSI of SPIM (Serial Peripheral 
//    Interface) format on every switch closure at P1[4].  The bit stream is internally 
//    fed into a 16 bit CRC user module in the master. After the entire string is transmitted
//    the CRC is read and displayed on the LCD.
//
//    The following changes were made to the default settings in the Device Editor:
// 
//    Select User Modules
//        o Select a CRC16_1 from Digital Comm category.
//        o Select a SPIM_1 from the Digital Comm category.
//        o Select a LCD_1 from the Misc Digital category.
//        o In this example, these UMs are renamed as CRC16, SPIM and LCD respectively. 
//    Place User Modules
//        1. Select CRC16 and place it on block DBB00 and DBB01.
//        2. Select SPIM and place it on block DCB02.
//        3. Select LCD and select port_2 for the LCD port.
//
//    Set the global resources and UM parameters in the Device Editor as shown under Project 
//    Settings ahead.
//    
//    Upon program execution, all hardware settings from the device configuration are loaded 
//   into the device and main.c is executed.
//
//    The 24 MHz system clock is divided by 16 (VC1) to generate a 1.5 Mhz clock, which is 
//    provided as the clock for SPIM user module.  The effective SPI communication would be 
//    at 0.75 Mhz (ie., half of Input clock).
//
//    The MOSI output of the SPIM is fed into the InputBitStream of CRC16 and the SClk output 
//    of the SPIM user module is provided as the Clock for CRC16, so that whenever a bit is 
//    transmitted out, the same data enters the CRC and then clocked.
//
//    On every switch closure at P1[4] a 10 byte string is transmitted out of SPI.  After the 
//    entire string is transmitted the CRC is read and displayed on the LCD.
//
//    Further information on user modules is supplied in the specific user module data sheet 
//    included with PSoC Designer.
//
//Clock Routing
//    In the device interface, the MOSI output of the SPIM is routed to the InputDataStream 
//    of CRC16 through Row_0_Output_1.  The SClk output of the SPIM user module is routed 
//    to the Input clock of CRC16 through Row_0_Output_0.
//    
//Circuit Connections
//    This example project runs on the CY3210-PSoCEVAL1 board or 
//    compatible hardware.  
//
//Project Settings
//
//    Global Resources 
//
//        CPU	            = 12 MHz (SysClk/2)	        Since communication user module is 
//                                                    used, CPU clock is set to a higher frequency. 
//        VC1	            = 16	                    Divide 24 Mhz system clock by 16 to get a 
//                                                    1.5 Mhz clock (for SPIM source)
//
//    User Module Parameters
//    
//
//    CRC16		
//        InputDataStream	= Row_0_Input_1	        MOSI routed parallely to CRC16 module.
//        Clock	        = Row_0_Output_0	        SClk of SPIM routed parallely to CRC16 module.
//		  Clock Sync	  = Sync to SysClk			Synchronize the clock to SysClock as SClk(VC1 / 2) is derivative of SysClk.
//        InvertInputDataStream = Normal	        Do not invert the data input to CRC16 module.
//        
//    SPIM        
//        Clock           = VC1                      1.5 MHz Clock from VC1.
//        MISO            = Low                      Not used.
//        MOSI            = Row_0_Output_1           Routed to CRC16 module through Row_0_Output_1 net. 
//        SClk            = Row_0_Output_0           Routed to CRC16 module through Row_0_Output_0 net.
//        InterruptMode   = TXComplete               Not used in this project.
//		  Clock Sync	  = Sync to SysClk			 Synchronize the clock to SysClock as VC1 is derivative of SysClk.
//        InvertMISO      = Normal					 Not used.        
//    
//    LCD		
//        LCDPort	        = Port_2	             Port 2 is used to send data to LCD
//        BarGraph	    = Disable					 Bargraph not used in this project
//        	
//				    	
//Input
//
//    Pin              Select             Drive
//    ---------------------------------------------
//    P1[4] (Switch)   StdCPU             Pull Down        
//             
//Output
//
//    Pin              Select             Drive
//    ---------------------------------------------
//    P2[0]-P2[6]      StdCPU             Strong (LCD)
//		
//How to use the Prototype Board
//    � Connect an industry standard Hitachi HD44780 based LCD module in the LCD header for 
//      CY3210-PSoCEVAL1.In CY3210-PSoCEVAL1 board the port 2 pins and the control signals 
//      required for LCD are taken out through J9 slot.The following table shows 
//		the connection between LCD and port 2 pins. 
//      
//
//                Port Pins    LCD Pin
//                ---------------------
//                P2 [0]        LCD_D4
//                P2 [1]        LCD_D5
//                P2 [2]        LCD_D6
//                P2 [3]        LCD_D7
//                P2 [4]        LCD_E
//                P2 [5]        LCD_RS
//                P2 [6]        LCD_RW
//
//    After downloading the Example_CRC project into the PSoC,power on the PSoC device.
//    The following display will appear on LCD.
//    ---------------------------------------------------------------------------------------
//    Press Switch S1
//    ---------------------------------------------------------------------------------------
//      
//    At every switch closure at P1[4], a string of 10 characters is transmitted from SPI.  The 
//    output bit-stream is connected to a CRC user module within the master.  
//
//    After the entire string is transmitted the CRC is read and displayed on the LCD.
//
//	  After the first closure of switch at P1[4],the first string with string index 0 
//	  and its CRC will be displayed on LCD as shown below.
//	---------------------------------------------------------------------------------------
//		00-ABCDEFGHIJ
//		CRC-86F5
//  -----------------------------------------------------------------------------------------
//    After the Second closure of switch at P1[4],the second string with string index 1 
//	  and its CRC will be displayed on LCD as shown below.
//  ---------------------------------------------------------------------------------------
//		01-abcdefghij
//		CRC-A32A
//  -----------------------------------------------------------------------------------------
//    After the Third closure of switch at P1[4],the third string with string index 2 
//	  and its CRC will be displayed on LCD as shown below.
//  ---------------------------------------------------------------------------------------
//		02-1234567890
//		CRC-D321
//  -----------------------------------------------------------------------------------------
//	 Further closure of switch at P1[4] will repeat the display of the strings with 
//   index 0,1 and 2 in the same format shown above.
//  
//
////-------------------------------------------------------------------
// Include Files
//-------------------------------------------------------------------
#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

//-------------------------------------------------------------------
// Prototypes
//-------------------------------------------------------------------
void sendDataToCRC(void);
void outputData(void);

//-------------------------------------------------------------------
// Constant declarations
//-------------------------------------------------------------------
#define     TOTAL_STRINGS     3
#define     TOTAL_BYTES       10

//Strings whose CRC needs to be calculated
const char  packet_data[TOTAL_STRINGS][TOTAL_BYTES+1] = {"ABCDEFGHIJ","abcdefghij","1234567890"};


#define CLEAR_BIT( MSKN_REG, MASK )   (MSKN_REG &= ~MASK)        // Clear Bit Mask(s) 
#define SET_BIT(   MSKN_REG, MASK )   (MSKN_REG |=  MASK)          // Set Bit Mask(s) 

//-------------------------------------------------------------------
// Variable Allocation
//-------------------------------------------------------------------
 
char flagReg;				                      //Flag register (each bit is used as a flag)
WORD wMasterCrc;                                  //Variable to hold 16 bit CRC
BYTE bStringIndex;


//-----------------------------------------------------------------------------
//  FUNCTION NAME: main.c
//
//  DESCRIPTION:
//      Main function. Performs system initialization and loops infinitely.
//      
//-----------------------------------------------------------------------------
//
//  ARGUMENTS:        None
//  RETURNS:          Nothing.
//  SIDE EFFECTS:     None.
//
//  THEORY of OPERATION or PROCEDURE:
//    1) Start the user modules 
//    2) Initialize the CRC and Keep sending a string on every switch closure at P1[4].
//
void main(void)
{
    //Start the LCD
    LCD_Start();
    
	//Initialize and start the SPI Master user module in mode 0
	SPIM_Start(SPIM_SPIM_MODE_0 | SPIM_SPIM_MSB_FIRST);  

    //Position the LCD to Row 1 column 1        
    LCD_Position(0,0);                        
    LCD_PrCString("Press Switch S1");            
    
	//Load Polynomial into CRC16 module
    CRC16_WritePolynomial(0x8810);

    bStringIndex=0;
           
    //Loop infinitely.  
    while(1)
    {
        //Check if switch in P1[4] is pressed
        if ( PRT1DR & 0x10 )
        {
            // Wait for switch to be released
			while (PRT1DR & 0x10);
			
            //Load seed value into CRC16 module
            CRC16_WriteSeed(0x000);
			
			//Start CRC16 module
            CRC16_Start();

            //call a routine to send data to slave (CRC16 module)
            sendDataToCRC();

            //Stop and Read the CRC of master 
            CRC16_Stop();
			
			//Read the 16 bit CRC  
            wMasterCrc = CRC16_wReadCRC();

            //Call the function to display string and its index and CRC on LCD
			outputData();
			                
            //increment the string index
            bStringIndex++;
            if (bStringIndex == TOTAL_STRINGS)        //CRC for all the strings have been calculated
                bStringIndex=0;
		}
	}
}
//-----------------------------------------------------------------------------
//  FUNCTION NAME: sendDataToCRC
//
//  DESCRIPTION:
//      Sends data to CRC UM and gets the CRC value
//-----------------------------------------------------------------------------
//
//  ARGUMENTS:        None
//  RETURNS:          None.
//  SIDE EFFECTS:     None.
//
//  THEORY of OPERATION or PROCEDURE:
//     - Wait Till Tx Buffer is empty and then send the string, byte by byte.
//     - Wait Till Rx Buffer is full. Read and descard the received data.
//
void sendDataToCRC(void)
{
    BYTE bDummy;
    BYTE bCtr;

    // While data remains to be sent 
    bCtr=0;
    while(bCtr<TOTAL_BYTES)
    {
        // Ensure the transmit buffer is free 
        while( ! (SPIM_bReadStatus() & SPIM_SPIM_TX_BUFFER_EMPTY ) );
        // load the next byte 
        SPIM_SendTxData( packet_data[bStringIndex][bCtr] ); 
        
        //Wait till the Receive buffer is full  
        while( ! (SPIM_bReadStatus() & SPIM_SPIM_RX_BUFFER_FULL ) );
        //Read the Recived data and descard (ie., dont use this data)
        bDummy=SPIM_bReadRxData();

        //increment the counter
        bCtr++;
    }    
}

//-----------------------------------------------------------------------------
//  FUNCTION NAME: outputData
//
//  DESCRIPTION:
//      Ouputs data on the LCD
//-----------------------------------------------------------------------------
//
//  ARGUMENTS:        None
//  RETURNS:          None.
//  SIDE EFFECTS:     None.
//
//  THEORY of OPERATION or PROCEDURE:
//     - Output the String index, String and CRC value on the LCD
//
void outputData(void) 
{
    //clear LCD
    LCD_Control(0x01);
    //Position the LCD to Row 0 column 0
    LCD_Position(0,0);
    //Output the index and string
    LCD_PrHexByte(bStringIndex);
    LCD_PrCString("-");
    //Output the string
    LCD_PrCString(packet_data[bStringIndex]);

    //Position the LCD to Row 1 column 0
    LCD_Position(1,0);
    //Output the master CRC
    LCD_PrCString("CRC-");
    LCD_PrHexInt(wMasterCrc);
}