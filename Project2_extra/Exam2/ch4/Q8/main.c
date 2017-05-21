//----------------------------------------------------------------------------
// C main line
//----------------------------------------------------------------------------

#include <m8c.h>        // part specific constants and macros
#include <math.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules




	//Function to compute sqroot(n)
int sqroot(int n) {
        int x = n;
		int i;
        for (i = 0; i < (n/2); i++)
             x = (x + n / x) / 2;

        return x;
}

void main(void)
{
	//int x=16;
	float y=16;
	// M8C_EnableGInt ; // Uncomment this line to enable Global Interrupts
	// Insert your main routine code here.
	//int a;
	//a =sqroot(x);
	float b;
	b = sqrtf(y);

}
