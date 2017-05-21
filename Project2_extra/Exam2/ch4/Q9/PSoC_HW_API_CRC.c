//----------------------------------------------------------------------------
// C main line
//----------------------------------------------------------------------------

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include "CRC16_1.h"

void SetupCCITT(void)
{
    // stop the CRC16 user module
    CRC16_1_Stop();

    // load the CCITT polynomial
    CRC16_1_WritePolynomial(CRC_CCITT_POLYNOMIAL); 

  // load the CCITT seed
    CRC16_1_WriteSeed(CRC_CCITT_SEED); 

  // start the CRC16
    CRC16_1_Start(); 
}


void main(void)
{
	int i;
	char p;
	p=0;
	// M8C_EnableGInt ; // Uncomment this line to enable Global Interrupts
	// Insert your main routine code here.
	
	SetupCCITT();
	
	for (i = 0; i<16; i++)
	{
		p++;
	}
	
	 CRC16_1_Stop(); 
	
}
