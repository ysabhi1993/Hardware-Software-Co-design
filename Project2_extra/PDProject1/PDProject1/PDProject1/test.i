#line 3 "C:\PROGRA~2\Cypress\PSOCDE~1\5.4\Common\CYPRES~1\tools\include\stdarg.h"
typedef char *va_list;

#line 22 "C:\PROGRA~2\Cypress\PSOCDE~1\5.4\Common\CYPRES~1\tools\include\_const.h"
 typedef __flash char *_LITSTR;
#line 17 "C:\PROGRA~2\Cypress\PSOCDE~1\5.4\Common\CYPRES~1\tools\include\stdio.h"
int getchar(void);
int putchar(char);
char *gets(char *);
int puts( char *);
int printf( char *, ...);
int vprintf( char *, va_list va);
int sprintf(char *, char *, ...);
int vsprintf(char *, char *, va_list va);

int scanf( char *, ...);
int vscanf( char *, va_list va);
int sscanf(char *, char *, ...);
int vsscanf(char *, char *, va_list va);






int cputs(__flash char *);
int cscanf(__flash char *, ...);
int csscanf(char *, __flash char *, ...);
int cprintf(__flash char *, ...);
int csprintf(char *, __flash char *, ...);
#line 10 "C:\PROGRA~2\Cypress\PSOCDE~1\5.4\Common\CYPRES~1\tools\include\math.h"
float acosf(float x);
float asinf(float x);
float atan2f(float y, float x);
float atanf(float x);
float ceilf(float y);
float cosf(float x);
float coshf(float x);
float exp10f(float x);
float expf(float x);
float fabsfLMM(float x);
float floorf(float y);
float fmodf(float y, float z);
float frexpf(float x, int *eptr);
float froundf(float d);
float ldexpf(float d, int n);
float log10f(float x);
float logf(float x);
float modff(float y, float *i);
float powf(float x,float y);
float sinf(float x);
float sinhf(float x);
float sqrtf(float x);
float tanf(float x);
float tanhf(float x);

#line 44 "F:\HARDWA~1\Project2\PDPROJ~1\PDPROJ~1\PDPROJ~1\complex.h"
double creal (double _Complex);
double cimag (double _Complex);
double carg (double _Complex);
double cabs (double _Complex);
#line 5 "F:\HARDWA~1\Project2\PDPROJ~1\PDPROJ~1\PDPROJ~1\test.c"
double PI;
typedef double _Complex;

void _fft(_Complex buf[], _Complex out[], int n, int step)
{
 int i;
 _Complex t;
 if (step < n) {
 _fft(out, buf, n, step * 2);
 _fft(out + step, buf + step, n, step * 2);

 for (i = 0; i < n; i += 2 * step) {
 t = [acosf(PI * i/n) + asinf(PI * i/n)] * out[i + step]; 
 buf[i/2] = out[i] + t;
 buf[(i + n)/2] = out[i] - t;
 }
 }
}

void fft(_Complex buf[], int n)
{
 _Complex out[n];
 for (int i = 0; i < n; i++) out[i] = buf[i]; 

 _fft(buf, out, n, 1);
}


void show(const char * s, _Complex buf[]) {
 printf("%s", s);
 for (int i = 0; i < 8; i++) 
 if (!cimag(buf[i]))
 printf("%g ", creal(buf[i]));
 else
 printf("(%g, %g) ", creal(buf[i]), cimag(buf[i]));
}

int main()
{
 PI = atan2f(1, 1) * 4;
 _Complex buf[] = {1, 1, 1, 1, 0, 0, 0, 0};

 show("Data: ", buf);
 fft(buf, 8); 
 show("\nFFT : ", buf);
 return 0;
}
