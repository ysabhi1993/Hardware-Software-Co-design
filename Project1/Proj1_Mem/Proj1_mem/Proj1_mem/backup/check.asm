;;83h = 2;
;;======================================================================================================
;;computes average of minutes:
;;======================================================================================================
;
;compute_avg_min:
;;A=remainder of the previous operation
;;multiply that value with 60 (to convert remaining hours into minutes) and add it to minutes
;
;mov reg[CUR_PP], 2 		;set Current Page Pointer to 2
;mov [10h], [92h] 			
;mov [11h], 00h 			
;mov reg[CUR_PP], 0
;;=======================================================
;;compute remainder after hrs are converted into minutes. 
;;=======================================================
;Com_rem:
;mov A,00h
;mov [75h],06h	;This will be used to convert remainder into min or sec
;; add remainder to A and repeat the operation for "value in [71h]" times
;add A,[86h]
;;==============================================================
;;compute product internally 
;;==============================================================
;;compute product
;compute_prd:
;add A,[85h]
;dec [75h]
;jnz compute_prd
;
;;==============================================================
;;compute remainder and add to previous product
;;==============================================================
;compute_rem:
;cmp A,[71h]
;jnc find_q1
;mov [86h],A					;86h holds the remainder
;dec [71h]
;cmp [71h],00h
;jz add_tonext
;jmp Com_rem
;
;find_q1:
;sub A,[71h]
;jmp compute_rem
;dec [71h]
;cmp [71h],00h
;jz add_tonext
;jmp Com_rem
;
;;==============================================================
;;add remainder from above computation to "sum of minutes"
;;==============================================================
;
;add_tonext:
;mov [EBh], 10h 		;initialize MVI read pointer to 10h
;mvi A, [EBh]		;read the value in 92h into A
;add A,[86h]
;
;;================================================================================
;;compute quotient(gives the average of minutes) and remainder(added to seconds)
;;================================================================================
;compute_avg:
;cmp A,[71h]
;jnc find_q_min
;mov [82h],[11h]				;register 83h holds the quotient
;mov [85h],A					;85h holds the remainder
;jmp compute_avg_sec
;
;find_q_min:
;sub A,[71h]
;inc [11h]
;jmp compute_avg
;