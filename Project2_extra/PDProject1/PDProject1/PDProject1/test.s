	cpu LMM
	.module test.c
	.area text(rom, con, rel)
	.dbfile ./test.c
	.dbfile F:\HARDWA~1\Project2\PDPROJ~1\PDPROJ~1\PDPROJ~1\test.c
	.dbfunc e _fft __fft fV
;           step -> X-11
;              n -> X-9
;            out -> X-7
;            buf -> X-5
__fft::
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l step -11 I
	.dbsym l n -9 I
	.dbsym l out -7 pD
	.dbsym l buf -5 pD
	.dbend
	.dbfunc e fft _fft fV
;              n -> X-7
;            buf -> X-5
_fft::
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l n -7 I
	.dbsym l buf -5 pD
	.dbend
