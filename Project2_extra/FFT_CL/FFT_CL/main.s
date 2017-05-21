	cpu LMM
	.module main.c
	.area text(rom, con, rel)
	.dbfile ./main.c
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.dbfunc e fft _fft fV
	.dbstruct 0 8 .3
	.dbfield 0 Re D
	.dbfield 4 Im D
	.dbend
;             ve -> X+22
;             vo -> X+20
;              w -> X+12
;              z -> X+4
;              k -> X+2
;              m -> X+0
;            tmp -> X-9
;              n -> X-7
;              v -> X-5
_fft::
	.dbline -1
	push X
	mov X,SP
	add SP,24
	.dbline 65
; //----------------------------------------------------------------------------
; // C main line
; //----------------------------------------------------------------------------
; 
; #include <m8c.h>        // part specific constants and macros
; #include "PSoCAPI.h"    // PSoC API definitions for all User Modules
; 
; 
; /* Factored discrete Fourier transform, or FFT, and its inverse iFFT */
; 
; #include <assert.h>
; #include <math.h>
; #include <stdio.h>
; #include <stdlib.h>
; #include <flashblock.h>
; #include <E2PROMLIB.h>
; 
; #define q	8		/* for 2^3 points */
; #define N	(1<<q)		/* N-point FFT, iFFT */
; 
; typedef float real;
; typedef struct{real Re; real Im;} complex;
; 
; #ifndef PI
; #define PI	3.14159265358979323846264338327950288
; #endif
; 
; union
; {
; 	FLASH_READ_STRUCT read;
; 	FLASH_WRITE_STRUCT write;
; } flashparams;
; 
; 
; /* Print a vector of complexes as ordered pairs. */
; //static void
; //print_vector(
; //	     const char *title,
; //	     complex *x,
; //	     int n)
; //{
; //  int i;
; // // printf("%s (dim=%d):", title, n);
; //  for(i=0; i<n; i++ ) //printf(" %5.2f,%5.2f ", x[i].Re,x[i].Im);
; //  //putchar('\n');
; //  return;
; //}
; 
; /* 
;    fft(v,N):
;    [0] If N==1 then return.
;    [1] For k = 0 to N/2-1, let ve[k] = v[2*k]
;    [2] Compute fft(ve, N/2);
;    [3] For k = 0 to N/2-1, let vo[k] = v[2*k+1]
;    [4] Compute fft(vo, N/2);
;    [5] For m = 0 to N/2-1, do [6] through [9]
;    [6]   Let w.re = cos(2*PI*m/N)
;    [7]   Let w.im = -sin(2*PI*m/N)
;    [8]   Let v[m] = ve[m] + w*vo[m]
;    [9]   Let v[m+N/2] = ve[m] - w*vo[m]
;  */
; 
; 
; void fft(complex *v, int n,complex *tmp )
; {
	.dbline 67
; 	
;   if(n>1) {			/* otherwise, do nothing and return */
	mov A,1
	sub A,[X-6]
	mov A,[X-7]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,(0 ^ 0x80)
	sbb A,[__rX]
	jnc L5
X0:
	.dbline 68
;     int k,m;  complex z, w, *vo, *ve;
	.dbline 69
;     ve = tmp; vo = tmp+n/2;
	mov A,[X-8]
	mov [X+23],A
	mov A,[X-9]
	mov [X+22],A
	.dbline 69
	mov REG[0xd0],>__r0
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-2
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[__r1]
	add A,[X-8]
	mov [X+21],A
	mov A,[__r0]
	adc A,[X-9]
	mov [X+20],A
	.dbline 70
;     for(k=0; k<n/2; k++) {
	mov [X+3],0
	mov [X+2],0
	xjmp L11
L8:
	.dbline 70
	.dbline 71
;       ve[k] = v[2*k];
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov [__r2],A
	asl [__r3]
	rlc [__r2]
	asl [__r3]
	rlc [__r2]
	asl [__r3]
	rlc [__r2]
	mov A,[X+23]
	add [__r3],A
	mov A,[X+22]
	adc [__r2],A
	mov A,[__r0]
	mov REG[0xd4],A
	mov A,[__r2]
	mov REG[0xd5],A
	push X
	mov X,8
X1:
	mov REG[0xd0],>__r0
	mvi A,[__r1]
	mvi [__r3],A
	dec X
	jnz X1
	pop X
	.dbline 72
;       vo[k] = v[2*k+1];
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	add [__r1],1
	adc [__r0],0
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov [__r2],A
	asl [__r3]
	rlc [__r2]
	asl [__r3]
	rlc [__r2]
	asl [__r3]
	rlc [__r2]
	mov A,[X+21]
	add [__r3],A
	mov A,[X+20]
	adc [__r2],A
	mov A,[__r0]
	mov REG[0xd4],A
	mov A,[__r2]
	mov REG[0xd5],A
	push X
	mov X,8
X2:
	mov REG[0xd0],>__r0
	mvi A,[__r1]
	mvi [__r3],A
	dec X
	jnz X2
	pop X
	.dbline 73
;     }
L9:
	.dbline 70
	inc [X+3]
	adc [X+2],0
L11:
	.dbline 70
	mov REG[0xd0],>__r0
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-2
	mov A,[X+3]
	sub A,[__r1]
	mov A,[__r0]
	xor A,-128
	mov [__rX],A
	mov A,[X+2]
	xor A,-128
	sbb A,[__rX]
	jc L8
X3:
	.dbline 74
;     fft( ve, n/2, v );		/* FFT on even-indexed elements of v[] */
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r1],A
	pop A
	add SP,-2
	push A
	mov A,[__r1]
	push A
	mov A,[X+22]
	push A
	mov A,[X+23]
	push A
	xcall _fft
	add SP,-6
	.dbline 75
;     fft( vo, n/2, v );		/* FFT on odd-indexed elements of v[] */
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r1],A
	pop A
	add SP,-2
	push A
	mov A,[__r1]
	push A
	mov A,[X+20]
	push A
	mov A,[X+21]
	push A
	xcall _fft
	add SP,-6
	.dbline 76
;     for(m=0; m<n/2; m++) {
	mov [X+1],0
	mov [X+0],0
	xjmp L15
L12:
	.dbline 76
	.dbline 78
; 					
; 	  w.Re = cos(2*PI*m/(double)n);
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r3],A
	mov A,[X-7]
	mov [__r2],A
	tst [__r2],-128
	jz X4
	mov [__r1],-1
	mov [__r0],-1
	jmp X5
X4:
	mov REG[0xd0],>__r0
	mov [__r1],0
	mov [__r0],0
X5:
	mov REG[0xd0],>__r0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall __long2fp
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	mov A,[X+1]
	mov [__r7],A
	mov A,[X+0]
	mov [__r6],A
	tst [__r6],-128
	jz X6
	mov [__r5],-1
	mov [__r4],-1
	jmp X7
X6:
	mov REG[0xd0],>__r0
	mov [__r5],0
	mov [__r4],0
X7:
	mov REG[0xd0],>__r0
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __long2fp
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,64
	push A
	mov A,-55
	push A
	mov A,15
	push A
	mov A,-37
	push A
	xcall __fpmul
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpdiv
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	add SP,-4
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall _cosf
	add SP,-4
	mov REG[0xd0],>__r0
	mov A,[__r0]
	mov [X+12],A
	mov A,[__r1]
	mov [X+13],A
	mov A,[__r2]
	mov [X+14],A
	mov A,[__r3]
	mov [X+15],A
	.dbline 79
;       w.Im = -sin(2*PI*m/(double)n);
	mov A,[X-6]
	mov [__r3],A
	mov A,[X-7]
	mov [__r2],A
	tst [__r2],-128
	jz X8
	mov [__r1],-1
	mov [__r0],-1
	jmp X9
X8:
	mov REG[0xd0],>__r0
	mov [__r1],0
	mov [__r0],0
X9:
	mov REG[0xd0],>__r0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall __long2fp
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	mov A,[X+1]
	mov [__r7],A
	mov A,[X+0]
	mov [__r6],A
	tst [__r6],-128
	jz X10
	mov [__r5],-1
	mov [__r4],-1
	jmp X11
X10:
	mov REG[0xd0],>__r0
	mov [__r5],0
	mov [__r4],0
X11:
	mov REG[0xd0],>__r0
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __long2fp
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,64
	push A
	mov A,-55
	push A
	mov A,15
	push A
	mov A,-37
	push A
	xcall __fpmul
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpdiv
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	add SP,-4
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall _sinf
	add SP,-4
	mov REG[0xd0],>__r0
	xor [__r0],-128
	mov A,[__r0]
	mov [X+16],A
	mov A,[__r1]
	mov [X+17],A
	mov A,[__r2]
	mov [X+18],A
	mov A,[__r3]
	mov [X+19],A
	.dbline 80
;       z.Re = w.Re*vo[m].Re - w.Im*vo[m].Im;	/* Re(w*vo[m]) */
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X+21]
	add [__r1],A
	mov A,[X+20]
	adc [__r0],A
	mov A,[__r1]
	add A,4
	mov [__r3],A
	mov A,[__r0]
	adc A,0
	mov REG[0xd4],A
	mvi A,[__r3]
	mov [__r4],A
	mvi A,[__r3]
	mov [__r5],A
	mvi A,[__r3]
	mov [__r6],A
	mvi A,[__r3]
	mov [__r7],A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,[X+16]
	push A
	mov A,[X+17]
	push A
	mov A,[X+18]
	push A
	mov A,[X+19]
	push A
	xcall __fpmul
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r8],A
	mvi A,[__r1]
	mov [__r9],A
	mvi A,[__r1]
	mov [__r10],A
	mvi A,[__r1]
	mov [__r11],A
	mov A,[__r8]
	push A
	mov A,[__r9]
	push A
	mov A,[__r10]
	push A
	mov A,[__r11]
	push A
	mov A,[X+12]
	push A
	mov A,[X+13]
	push A
	mov A,[X+14]
	push A
	mov A,[X+15]
	push A
	xcall __fpmul
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-4
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall __fpsub
	pop A
	mov [X+7],A
	pop A
	mov [X+6],A
	pop A
	mov [X+5],A
	pop A
	mov [X+4],A
	add SP,-4
	.dbline 81
;       z.Im = w.Re*vo[m].Im + w.Im*vo[m].Re;	/* Im(w*vo[m]) */
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X+21]
	add [__r1],A
	mov A,[X+20]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r4],A
	mvi A,[__r1]
	mov [__r5],A
	mvi A,[__r1]
	mov [__r6],A
	mvi A,[__r1]
	sub [__r1],4
	mov [__r7],A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,[X+16]
	push A
	mov A,[X+17]
	push A
	mov A,[X+18]
	push A
	mov A,[X+19]
	push A
	xcall __fpmul
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	add [__r1],4
	adc [__r0],0
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r8],A
	mvi A,[__r1]
	mov [__r9],A
	mvi A,[__r1]
	mov [__r10],A
	mvi A,[__r1]
	mov [__r11],A
	mov A,[__r8]
	push A
	mov A,[__r9]
	push A
	mov A,[__r10]
	push A
	mov A,[__r11]
	push A
	mov A,[X+12]
	push A
	mov A,[X+13]
	push A
	mov A,[X+14]
	push A
	mov A,[X+15]
	push A
	xcall __fpmul
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-4
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall __fpadd
	pop A
	mov [X+11],A
	pop A
	mov [X+10],A
	pop A
	mov [X+9],A
	pop A
	mov [X+8],A
	add SP,-4
	.dbline 82
;       v[  m  ].Re = ve[m].Re + z.Re;
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[__r1]
	add A,[X+23]
	mov [__r3],A
	mov A,[__r0]
	adc A,[X+22]
	mov REG[0xd4],A
	mvi A,[__r3]
	mov [__r4],A
	mvi A,[__r3]
	mov [__r5],A
	mvi A,[__r3]
	mov [__r6],A
	mvi A,[__r3]
	mov [__r7],A
	mov A,[X+4]
	push A
	mov A,[X+5]
	push A
	mov A,[X+6]
	push A
	mov A,[X+7]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpadd
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r4]
	mvi [__r1],A
	mov A,[__r5]
	mvi [__r1],A
	mov A,[__r6]
	mvi [__r1],A
	mov A,[__r7]
	mvi [__r1],A
	.dbline 83
;       v[  m  ].Im = ve[m].Im + z.Im;
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[__r1]
	add A,[X+23]
	mov [__r3],A
	mov A,[__r0]
	adc A,[X+22]
	mov [__r2],A
	add [__r3],4
	adc [__r2],0
	mov A,[__r2]
	mov REG[0xd4],A
	mvi A,[__r3]
	mov [__r4],A
	mvi A,[__r3]
	mov [__r5],A
	mvi A,[__r3]
	mov [__r6],A
	mvi A,[__r3]
	mov [__r7],A
	mov A,[X+8]
	push A
	mov A,[X+9]
	push A
	mov A,[X+10]
	push A
	mov A,[X+11]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpadd
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-4
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	add [__r1],4
	adc [__r0],0
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r4]
	mvi [__r1],A
	mov A,[__r5]
	mvi [__r1],A
	mov A,[__r6]
	mvi [__r1],A
	mov A,[__r7]
	mvi [__r1],A
	.dbline 84
;       v[m+n/2].Re = ve[m].Re - z.Re;
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X+23]
	add [__r1],A
	mov A,[X+22]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r4],A
	mvi A,[__r1]
	mov [__r5],A
	mvi A,[__r1]
	mov [__r6],A
	mvi A,[__r1]
	mov [__r7],A
	mov A,[X+4]
	push A
	mov A,[X+5]
	push A
	mov A,[X+6]
	push A
	mov A,[X+7]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpsub
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-4
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-2
	mov A,[X+1]
	add A,[__r5]
	mov [__r5],A
	mov A,[X+0]
	adc A,[__r4]
	mov [__r4],A
	asl [__r5]
	rlc [__r4]
	asl [__r5]
	rlc [__r4]
	asl [__r5]
	rlc [__r4]
	mov A,[X-4]
	add [__r5],A
	mov A,[X-5]
	adc [__r4],A
	mov A,[__r4]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r5],A
	mov A,[__r1]
	mvi [__r5],A
	mov A,[__r2]
	mvi [__r5],A
	mov A,[__r3]
	mvi [__r5],A
	.dbline 85
;       v[m+n/2].Im = ve[m].Im - z.Im;
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	asl [__r1]
	rlc [__r0]
	mov A,[X+23]
	add [__r1],A
	mov A,[X+22]
	adc [__r0],A
	add [__r1],4
	adc [__r0],0
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r4],A
	mvi A,[__r1]
	mov [__r5],A
	mvi A,[__r1]
	mov [__r6],A
	mvi A,[__r1]
	mov [__r7],A
	mov A,[X+8]
	push A
	mov A,[X+9]
	push A
	mov A,[X+10]
	push A
	mov A,[X+11]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	xcall __fpsub
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-4
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	add SP,-2
	mov A,[X+1]
	add A,[__r5]
	mov [__r5],A
	mov A,[X+0]
	adc A,[__r4]
	mov [__r4],A
	asl [__r5]
	rlc [__r4]
	asl [__r5]
	rlc [__r4]
	asl [__r5]
	rlc [__r4]
	mov A,[X-4]
	add [__r5],A
	mov A,[X-5]
	adc [__r4],A
	add [__r5],4
	adc [__r4],0
	mov A,[__r4]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r5],A
	mov A,[__r1]
	mvi [__r5],A
	mov A,[__r2]
	mvi [__r5],A
	mov A,[__r3]
	mvi [__r5],A
	.dbline 86
;     }
L13:
	.dbline 76
	inc [X+1]
	adc [X+0],0
L15:
	.dbline 76
	mov REG[0xd0],>__r0
	mov A,0
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	xcall __divmod_16X16_16
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add SP,-2
	mov A,[X+1]
	sub A,[__r1]
	mov A,[__r0]
	xor A,-128
	mov [__rX],A
	mov A,[X+0]
	xor A,-128
	sbb A,[__rX]
	jc L12
X12:
	.dbline 87
;   }
	.dbline 88
;   return;
	.dbline -2
L5:
	add SP,-24
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l ve 22 pS[.3]
	.dbsym l vo 20 pS[.3]
	.dbsym l w 12 S[.3]
	.dbsym l z 4 S[.3]
	.dbsym l k 2 I
	.dbsym l m 0 I
	.dbsym l tmp -9 pS[.3]
	.dbsym l n -7 I
	.dbsym l v -5 pS[.3]
	.dbend
	.area litabs(rom, abs, lit)
	.org 0x0
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_v::
	.blkb 2048
	.dbsym e v _v A[2048:256]S[.3]
_v1::
	.blkb 2048
	.dbsym e v1 _v1 A[2048:256]S[.3]
_scratch::
	.blkb 2048
	.dbsym e scratch _scratch A[2048:256]S[.3]
	.area text(rom, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_Write_buf::
	.word 20
	.dbsym e Write_buf _Write_buf I
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_wARG_BlockId::
	.word 1
	.dbsym e wARG_BlockId _wARG_BlockId I
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_pARG_FlashBuffer::
	.word 0
	.dbsym e pARG_FlashBuffer _pARG_FlashBuffer I
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_cARG_Temperature::
	.word 25
	.dbsym e cARG_Temperature _cARG_Temperature I
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.area text(rom, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
	.dbfunc e main _main fI
_main::
	.dbline 0 ; func end
	jmp .
	.dbend
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_write::
	.byte 0,0
	.dbsym e write _write I
	.area data(ram, con, rel)
	.dbfile F:\HARDWA~1\Project2\FFT_CL\FFT_CL\main.c
_flashparams::
	.byte 0,0
	.dbsym e flashparams _flashparams I
