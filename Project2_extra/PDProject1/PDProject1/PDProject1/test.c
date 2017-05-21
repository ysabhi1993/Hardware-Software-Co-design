#include <stdio.h>
#include <math.h>
#include <complex.h>
 
double PI;
typedef double complex;
 
void _fft(complex buf[], complex out[], int n, int step)
{
	int i;
	complex t;
	if (step < n) {
		_fft(out, buf, n, step * 2);
		_fft(out + step, buf + step, n, step * 2);
 
		for (i = 0; i < n; i += 2 * step) {
			t = [acosf(PI * i/n) + asinf(PI * i/n)] * out[i + step]; //cexpl(-I * PI * i / n)
			buf[i/2]     = out[i] + t;
			buf[(i + n)/2] = out[i] - t;
		}
	}
}
 
void fft(complex buf[], int n)
{
	complex out[n];
	for (int i = 0; i < n; i++) out[i] = buf[i];// reversing has to be done 
 
	_fft(buf, out, n, 1);
}
 
 
void show(const char * s, complex buf[]) {
	printf("%s", s);
	for (int i = 0; i < 8; i++)	
		if (!cimag(buf[i]))
			printf("%g ", creal(buf[i]));
		else
			printf("(%g, %g) ", creal(buf[i]), cimag(buf[i]));
}
 
int main()
{
	PI = atan2(1, 1) * 4;
	complex buf[] = {1, 1, 1, 1, 0, 0, 0, 0};
 
	show("Data: ", buf);
	fft(buf, 8);  //parametrise 8 - read value of n
	show("\nFFT : ", buf);
 	return 0;
}
 
 