#include <m8c.h>
#include "PSoCAPI.h"

void LoopBack(void)
{
	BYTE bData;
	while(1)
	{
		//Wait for the data to be received
		while(!(SPIS_M2_bReadStatus() & SPIS_M2_SPIS_SPI_COMPLETE));
		
		//Read received data
		bData = SPIS_M2_bReadRxData();
		
		//Inverting received data
		bData = ~bData;
		
		//Setup to transmit the response data
		SPIS_M2_SetupTxData(bData);
	}
}

void main(void)
{
	SPIS_M2_Start(SPIS_M2_SPIS_MODE_2 | SPIS_M2_SPIS_LSB_FIRST);
	LoopBack();
}