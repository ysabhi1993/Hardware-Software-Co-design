M1 to M2 SPI
M3 to M4 UART


//datasheet
void main(void)
{
	//default is assumed for mode and msb
	BYTE bIndex;
	SPIM_Start();
	SPIM_SetMOSI(SPIM_MOSI_P15); // Set MOSI pin to P1.5
	bIndex = 0;
	TIME_DELAY;
	//Slave select is grounded on the slave module
	//clock is automatically defined	
	while (bIndex < sizeof(Message))
	{
		// Send the whole message by loading the every next byte into TX buffer
		// Replace the transmitted byte with the received one from other SPI device
		Message[bIndex] = SPIM_bIO(Message[bIndex]);
		bIndex++;
		TIME_DELAY; // Insert a user provided function here to make delay
	}
	SPIM_Stop();
}

//from text book
#include "PSoCAPI.h"
char Message[] = "Hello world!";
char *pStr = Message;

void main() {
	SPIM_Start (SPIM_MODE_0 | SPIM_MSB_FIRST);
	while (*pStr != 0) {
		while (!(SPIM_bReadStatus() & SPIM_TX_BUFFER_EMPTY));
		SPIM_SendTxData (*pStr);
		pStr++;
	}
}
