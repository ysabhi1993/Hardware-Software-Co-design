;addr_internal_inc_ms: 	equ 09h
;addr_inc_ms: 			equ 10h
;addr_inc_s: 			equ 11h
;addr_inc_m: 			equ 12h
;addr_inc_h: 			equ 13h
;
;read_addr_inc_ms: 		equ 04h
;read_addr_inc_s: 		equ 05h
;read_addr_inc_m: 		equ 06h
;read_addr_inc_h: 		equ 07h
;
;addr_lng_p: 			equ 14h
;addr_shrt_p: 			equ 15h
;
;addr_acc_mode: 		equ 16h
;sec_mode: 				equ 01h
;halfsec_mode: 			equ 02h
;tenthsec_mode: 		equ 03h
;
;md_flg: 				equ 50h
;
;count_saved:			equ 30h
;read_saved: 			equ 31h
;save_time_index:		equ 40h
;
;ADC_value_0:			equ 50h
;ADC_value_1:			equ 51h
;ADC_value_2:			equ 52h
;ADC_value_3:			equ 53h
;	

;export addr_internal_inc_ms
;export addr_inc_ms
;export addr_inc_s
;export addr_inc_m
;export addr_inc_h
;
;export read_addr_inc_ms
;export read_addr_inc_s
;export read_addr_inc_m
;export read_addr_inc_h
;
;export addr_lng_p
;export addr_shrt_p
;
;export addr_acc_mode
;;export sec_mode
;;export halfsec_mode
;;export tenthsec_mode
;
;export md_flg
;
;export count_saved
;export read_saved
;export save_time_index
;
;export ADC_value_0
;export ADC_value_1
;export ADC_value_2
;export ADC_value_3
	



sec_mode: 				equ 01h
halfsec_mode: 			equ 02h
tenthsec_mode: 			equ 03h
max_mode:				equ 01h			;for memory mode
min_mode:				equ 02h			;for memory mode
mem_mode:				equ 60h

;References from the memory module

pg6_reference: equ 40h

sum_hr: equ 41h
sum_min_LSB: equ 42h
sum_min_MSB: equ 43h
sum_sec_LSB: equ 44h
sum_sec_MSB: equ 45h
sum_ms: equ 46h

avg_hr: equ 47h
avg_min: equ 48h
avg_sec: equ 49h
avg_ms: equ 50h

max_hr: equ 51h
max_min: equ 52h
max_sec: equ 53h
max_ms: equ 54h

min_hr: equ 55h
min_min: equ 56h
min_sec: equ 57h
min_ms: equ 58h

flag_val: equ 59h




input_count: equ 62h	;71h
counter_sum: equ 63h	;69h
counting_adds: equ 64h	;70h
operand_2:equ 65h		;40h
counter_input: equ A7h	
result_avg: equ 77h		;68h
quotient_val: equ 11h	;11h