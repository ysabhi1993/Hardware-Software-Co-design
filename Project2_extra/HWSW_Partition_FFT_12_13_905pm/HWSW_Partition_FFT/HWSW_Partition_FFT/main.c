//----------------------------------------------------------------------------
// VC1 provides a sample clock of 3 MHz to the DELTA_SIGMA-11bit, 
// resulting in a sample rate of 7.8 Ksamples per second. 
// VC3 generates the baud clock for the UART by dividing 24 MHz by 156. The UART internally 
// divides VC3 by 8 resulting in a baud rate of 19,200 bps. The serial data is 
// sent as ASCII text with 1 start bit, 8 data bits, 1 stop bit and no parity. 
// This data may be monitored using most terminal software. 
//
//
// PSoCEval1 Connections:
//      port0_pin1 -> External Signal = ADC Input (0-Vdd)
//      port1_pin6 -> RX = RS232 RX
//      port2_pin7 -> TX = RS232 TX
//
//-----------------------------------------------------------------------------


#include <m8c.h>                         // part specific constants and macros
#include "PSoCAPI.h"                     // PSoC API definitions for all User Modules
#include "stdlib.h"
#include "fft.h"                     // PSoC API definitions for all User Modules
#include "math.h"
#include <flashblock.h> 

#define RESOLUTION 12                    // ADC resolution
#define SCALE_BG  (( 1 << RESOLUTION)/55) // BarGraph scale factor

#ifndef PI
#define PI	3.14159265358979323846264338327950288
#endif

//int  iResult; // ADC result variable
int a;
int p;
int j;
int z;
char df[4];
char* data;
char* data_read;
double max,zero=0;
unsigned int i=0;         //index
unsigned int k=0;
unsigned int ind;         
//unsigned int endl=65535;  //uart tag

int status;
// Delta-Sigma-11bit: 7.8 ksps
//unsigned int N_samples=7800;
//double  time;    // time record
//double delta_f;  // frequency sampling interval

//these are before FFT
double temp_array[64]={0};
double temp_array_read[64]={0};

//these are final out of FFT
double temp_array_result[64]={0};
double temp_array_result_read[64]={0};
/*******************************************************************************
*  Defines
*******************************************************************************/
/* Temperature for flash write is set here */
#define Temp 25    

/* Block ID used for flash writes and read  */
#define BLOCK 416 
#define BLOCK_DRSLT 448
#define BLOCK_MODRSLT 480

/* Return value when an error occured during the flash block write function */ 
#define FLASH_ERROR 0    

/* size of the array to be written or read */
#define SIZE 64    

union
    {
        FLASH_WRITE_STRUCT Write;
        FLASH_READ_STRUCT Read;
    } FlashParams;
	
/*******************************************************************************
/*  Global Varibles
/*******************************************************************************/
 /* Buffer to store the values to be written to the flash */
//unsigned char Write_Buffer[64];  
    
/* buffer to store the values to be read from the flash */    
//unsigned char Read_Buffer[64];  

double final_mod[N_points]={0};
double final_data_re[N_points]={0};
double final_data_imm[N_points]={0};

/*
void UART_print_re_imm ()  //send REAL and IMAGINARY parts data
{  
     UART_1_CPutString("Real Part\t\tImaginary Part\n");
     for(i=0;i<N_points;i++)
     {
       UART_1_PutSHexInt(data_re[i]);
        UART_1_CPutString("\t\t");
        UART_1_PutSHexInt(data_imm[i]);
      UART_1_PutCRLF();  
      }
    }
*/

/*
void UART_print_mod ()    //send ABSOLUTE VALUE data
{
   UART_1_PutSHexInt(0);
   for(i=0;i<N_points;i++)
   {
   UART_1_PutSHexInt(mod[i]);
   }
   UART_1_PutSHexInt(endl);
   UART_1_PutCRLF();   
}
*/

/*
void UART_print_data ()   // send REAL data
{
   UART_1_CPutString("Data init\n"); // Example string
    
   for (i=0;i<N_points;i++)
   {
   UART_1_PutSHexInt(data_re[i]);
   UART_1_PutCRLF();
   }

}
*/

/*
//void LCD_print()
//{         
//	// find the fundamental harmonic (except the zero component)
//        max=mod[0];        
//        ind=0;
//        for(i=1;i<N_points/2;i++)
//        	if(mod[i]>max)
//        		{
//        		  max=mod[i];
//        		  ind=i;
//         		 }
//        		
//        itoa(df,(int)(max),10);
//        LCD_1_Position(1,0);
//        LCD_1_PrString(df);
//        
//        itoa(df,(int)(ind*delta_f),10);
//        LCD_1_Position(1,6);
//        LCD_1_PrString(df);
//        
//        LCD_1_Position(1,11);
//        LCD_1_PrCString("Hz");
//}
*/

void main(void)
{
    BYTE bgPos;                          // BarGraph position
    BYTE bError;   
	LCD_1_Start();                       // Init the LCD
	
		
//////////////////////////////////////////////////////////////////////////////////
	/// iterate 32 times because we have a total of 256 elements but are only working
	/// on 8 elements at a time. To get a total of 256 total elements we need to run
	/// this iteration 32 times. 32*8=256 elements
	for(j=0; j<32; j++){
	   //initialize the data 	
	   for(k=0; k<8; k++) {
	    save_data_re[k]  = 0.125*cos(2*PI*((j*8)+k)/(double)N_points); //remember to add j
	    save_data_imm[k] = 0.125*sin(2*PI*((j*8)+k)/(double)N_points);
		//encapsulate into larger array
		//[data_re][data_imm]
		temp_array[2*k] = save_data_re[k];
		temp_array[2*k +1] = save_data_imm[k];
	  }
	

	//write the 8 encapsulated elements to Flash
	FlashParams.Write.wARG_BlockId = BLOCK + j;             /* Block ID  */
    FlashParams.Write.pARG_FlashBuffer = (char *)&temp_array;  /* Start with the first byte of Buffer */ 
    FlashParams.Write.cARG_Temperature = Temp;          /* Place your average expected device temperature here.  
                                                           For optimal flash write conditions the temperature needs to be
                                                           within +/- 20 C of the actual device die temperature.*/
    /* bFlashWriteBlock returns a non-zero value in the case of a flash write failure.
       See flashblock.h line 55 for more details.*/
    /* Write the buffer(WriteData) data to Flash assuming room temp to be 25C  */
    bError = bFlashWriteBlock(&FlashParams.Write);  
	}
	////////////////////////////////////////////////////////////////////////////////////
	/// initialize complete 

	
	////////////////////////////////////////////////////////////////////////////////////
	/// read 8 elements from flash at a time and run FFT on the elements then store the 
	/// result (data_re/data_imm/mod) back in FLASH
for(z=0; z<32; z++){
		 /* If the write operaton is successful, read back the data to the ReadBuffer */
    if ( bError != FLASH_ERROR )  
     {  
        /* Enable global interupts */
        M8C_EnableGInt;                                    
    
        /* Starting at the first byte of the first block */
        FlashParams.Read.wARG_BlockId = BLOCK + z; 
        
        /* RAM buffer to read */
        FlashParams.Read.pARG_FlashBuffer = (char *)&temp_array_read;//encapsulated float array
        
        /* 16 byte read */
        FlashParams.Read.wARG_ReadCount = SIZE; 
        
        /* read the data from the flash to the buffer */
        FlashReadBlock(&FlashParams.Read);               
                              
      }
 
		//decapsulate the array into data_re and data_imm
	    for(k=0; k<8; k++) {
    		data_re[k]  = temp_array_read[2*k];
    		data_imm[k] = temp_array_read[2*k +1];
  			}
    	
			//print out the data read from Flash
			LCD_1_Position(0,0);
			data_read = ftoa(data_re[5], &status);
			LCD_1_PrString(data_read);

		
 	//while (1)// Main loop 

	for (p=0; p<N_points; p++)
    {   
		
			//run FFT on data_re & data_imm
        	FFT(1,exponent,data_re,data_imm );
       
		
			//print out the data from FFT
//			LCD_1_Position(1,0);
//			data = ftoa(data_re[5], &status);
//			LCD_1_PrString(data);
			

		}//end while loop 
	
////////////////////////////////////////////////////////////////////

	//out the data from FFT
	LCD_1_Position(0,0);
	data_read = ftoa(data_re[5], &status);
	LCD_1_PrString(data_read);
	
	/// encapsulate the data_re and data_imm back up
	for(k=0; k<8; k++) {
		//encapsulate into larger array
		//[data_re][data_imm]
		temp_array_result[2*k] = data_re[k];
		temp_array_result[2*k +1] = data_imm[k];
	  }
	
	
	/// write result to Flash
	//write the 8 encapsulated elements to Flash
	FlashParams.Write.wARG_BlockId = BLOCK_DRSLT+z;             /* Block ID  */
    FlashParams.Write.pARG_FlashBuffer = (char *)&temp_array_result;  /* Start with the first byte of Buffer */ 
    FlashParams.Write.cARG_Temperature = Temp;          /* Place your average expected device temperature here.  
                                                           For optimal flash write conditions the temperature needs to be
                                                           within +/- 20 C of the actual device die temperature.*/
    /* bFlashWriteBlock returns a non-zero value in the case of a flash write failure.
       See flashblock.h line 55 for more details.*/
    /* Write the buffer(WriteData) data to Flash assuming room temp to be 25C  */
    bError = bFlashWriteBlock(&FlashParams.Write);  

	
	
	//write the mod elements to Flash
	FlashParams.Write.wARG_BlockId = BLOCK_MODRSLT +z;             /* Block ID  */
    FlashParams.Write.pARG_FlashBuffer = (char *)&mod;  /* Start with the first byte of Buffer */ 
    FlashParams.Write.cARG_Temperature = Temp;          /* Place your average expected device temperature here.  
                                                           For optimal flash write conditions the temperature needs to be
                                                           within +/- 20 C of the actual device die temperature.*/
    /* bFlashWriteBlock returns a non-zero value in the case of a flash write failure.
       See flashblock.h line 55 for more details.*/
    /* Write the buffer(WriteData) data to Flash assuming room temp to be 25C  */
    bError = bFlashWriteBlock(&FlashParams.Write);
	
	
	
	
	/* If the write operaton is successful, read back the data to the ReadBuffer */
    if ( bError != FLASH_ERROR )  
     {  
        /* Enable global interupts */
        M8C_EnableGInt;                                    
    
        /* Starting at the first byte of the first block */
        FlashParams.Read.wARG_BlockId = BLOCK_DRSLT +z ; 
        
        /* RAM buffer to read */
        FlashParams.Read.pARG_FlashBuffer = (char *)&temp_array_result_read;//encapsulated float array
        
        /* 16 byte read */
        FlashParams.Read.wARG_ReadCount = SIZE; 
        
        /* read the data from the flash to the buffer */
        FlashReadBlock(&FlashParams.Read);               
                              
      }
	
	
	
		/* If the write operaton is successful, read back the data to the ReadBuffer */
    if ( bError != FLASH_ERROR )  
     {  
        /* Enable global interupts */
        M8C_EnableGInt;                                    
    
        /* Starting at the first byte of the first block */
        FlashParams.Read.wARG_BlockId = BLOCK_MODRSLT + z; 
        
        /* RAM buffer to read */
        FlashParams.Read.pARG_FlashBuffer = (char *)&final_mod;//encapsulated float array
        
        /* 16 byte read */
        FlashParams.Read.wARG_ReadCount = SIZE; 
        
        /* read the data from the flash to the buffer */
        FlashReadBlock(&FlashParams.Read);               
                              
      }
	
	//decapsulate the array into final_data_re and final_data_imm
	    for(k=0; k<8; k++) {
    		final_data_re[k]  = temp_array_result_read[2*k];
    		final_data_imm[k] = temp_array_result_read[2*k +1];
  		}

		//print out the data read from Flash
			LCD_1_Position(1,0);
			data_read = ftoa(final_data_re[5], &status);
			LCD_1_PrString(data_read);
	}
}//end main