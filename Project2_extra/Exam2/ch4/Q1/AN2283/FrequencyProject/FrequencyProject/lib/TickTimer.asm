;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: TickTimer.asm
;;   Version: 2.6, Updated on 2013/5/19 at 10:44:39
;;  Generated by PSoC Designer 5.4.2946
;;
;;  DESCRIPTION: Timer16 User Module software implementation file
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API functions
;;        returns. For Large Memory Model devices it is also the caller's 
;;        responsibility to perserve any value in the CUR_PP, IDX_PP, MVR_PP and 
;;        MVW_PP registers. Even though some of these registers may not be modified
;;        now, there is no guarantee that will remain the case in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2013. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "TickTimer.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  TickTimer_EnableInt
export _TickTimer_EnableInt
export  TickTimer_DisableInt
export _TickTimer_DisableInt
export  TickTimer_Start
export _TickTimer_Start
export  TickTimer_Stop
export _TickTimer_Stop
export  TickTimer_WritePeriod
export _TickTimer_WritePeriod
export  TickTimer_WriteCompareValue
export _TickTimer_WriteCompareValue
export  TickTimer_wReadCompareValue
export _TickTimer_wReadCompareValue
export  TickTimer_wReadTimer
export _TickTimer_wReadTimer
export  TickTimer_wReadTimerSaveCV
export _TickTimer_wReadTimerSaveCV

; The following functions are deprecated and subject to omission in future releases
;
export  wTickTimer_ReadCompareValue  ; deprecated
export _wTickTimer_ReadCompareValue  ; deprecated
export  wTickTimer_ReadTimer         ; deprecated
export _wTickTimer_ReadTimer         ; deprecated
export  wTickTimer_ReadTimerSaveCV   ; deprecated
export _wTickTimer_ReadTimerSaveCV   ; deprecated

export  wTickTimer_ReadCounter       ; obsolete
export _wTickTimer_ReadCounter       ; obsolete
export  wTickTimer_CaptureCounter    ; obsolete
export _wTickTimer_CaptureCounter    ; obsolete


AREA frequencyproject_RAM (RAM,REL)

;-----------------------------------------------
;  Constant Definitions
;-----------------------------------------------


;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------


AREA UserModules (ROM, REL)

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_EnableInt
;
;  DESCRIPTION:
;     Enables this timer's interrupt by setting the interrupt enable mask bit
;     associated with this User Module. This function has no effect until and
;     unless the global interrupts are enabled (for example by using the
;     macro M8C_EnableGInt).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_EnableInt:
_TickTimer_EnableInt:
   RAM_PROLOGUE RAM_USE_CLASS_1
   TickTimer_EnableInt_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_DisableInt
;
;  DESCRIPTION:
;     Disables this timer's interrupt by clearing the interrupt enable
;     mask bit associated with this User Module.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_DisableInt:
_TickTimer_DisableInt:
   RAM_PROLOGUE RAM_USE_CLASS_1
   TickTimer_DisableInt_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_Start
;
;  DESCRIPTION:
;     Sets the start bit in the Control register of this user module.  The
;     timer will begin counting on the next input clock.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_Start:
_TickTimer_Start:
   RAM_PROLOGUE RAM_USE_CLASS_1
   TickTimer_Start_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_Stop
;
;  DESCRIPTION:
;     Disables timer operation by clearing the start bit in the Control
;     register of the LSB block.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_Stop:
_TickTimer_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   TickTimer_Stop_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_WritePeriod
;
;  DESCRIPTION:
;     Write the 16-bit period value into the Period register (DR1). If the
;     Timer user module is stopped, then this value will also be latched
;     into the Count register (DR0).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: fastcall16 WORD wPeriodValue (LSB in A, MSB in X)
;  RETURNS:   Nothing
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_WritePeriod:
_TickTimer_WritePeriod:
   RAM_PROLOGUE RAM_USE_CLASS_1
   mov   reg[TickTimer_PERIOD_LSB_REG], A
   mov   A, X
   mov   reg[TickTimer_PERIOD_MSB_REG], A
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_WriteCompareValue
;
;  DESCRIPTION:
;     Writes compare value into the Compare register (DR2).
;
;     NOTE! The Timer user module must be STOPPED in order to write the
;           Compare register. (Call TickTimer_Stop to disable).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    fastcall16 WORD wCompareValue (LSB in A, MSB in X)
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_WriteCompareValue:
_TickTimer_WriteCompareValue:
   RAM_PROLOGUE RAM_USE_CLASS_1
   mov   reg[TickTimer_COMPARE_LSB_REG], A
   mov   A, X
   mov   reg[TickTimer_COMPARE_MSB_REG], A
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_wReadCompareValue
;
;  DESCRIPTION:
;     Reads the Compare registers.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      fastcall16 WORD wCompareValue (value of DR2 in the X & A registers)
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 TickTimer_wReadCompareValue:
_TickTimer_wReadCompareValue:
 wTickTimer_ReadCompareValue:                    ; this name deprecated
_wTickTimer_ReadCompareValue:                    ; this name deprecated
   RAM_PROLOGUE RAM_USE_CLASS_1
   mov   A, reg[TickTimer_COMPARE_MSB_REG]
   mov   X, A
   mov   A, reg[TickTimer_COMPARE_LSB_REG]
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_wReadTimerSaveCV
;
;  DESCRIPTION:
;     Returns the value in the Count register (DR0), preserving the
;     value in the compare register (DR2).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;  RETURNS:   fastcall16 WORD wCount (value of DR0 in the X & A registers)
;  SIDE EFFECTS:
;     1) May cause an interrupt, if interrupt on Compare is enabled.
;     2) If enabled, Global interrupts are momentarily disabled.
;     3) The user module is stopped momentarily while the compare value is
;        restored.  This may cause the Count register to miss one or more
;        counts depending on the input clock speed.
;     4) The A and X registers may be modified by this or future implementations
;        of this function.  The same is true for all RAM page pointer registers in
;        the Large Memory Model.  When necessary, it is the calling function's
;        responsibility to perserve their values across calls to fastcall16 
;        functions.
;
;  THEORY of OPERATION:
;     1) Read and save the Compare register.
;     2) Read the Count register, causing its data to be latched into
;        the Compare register.
;     3) Read and save the Counter value, now in the Compare register,
;        to the buffer.
;     4) Disable global interrupts
;     5) Halt the timer
;     6) Restore the Compare register values
;     7) Start the Timer again
;     8) Restore global interrupt state
;
 TickTimer_wReadTimerSaveCV:
_TickTimer_wReadTimerSaveCV:
 wTickTimer_ReadTimerSaveCV:                     ; this name deprecated
_wTickTimer_ReadTimerSaveCV:                     ; this name deprecated
 wTickTimer_ReadCounter:                         ; this name deprecated
_wTickTimer_ReadCounter:                         ; this name deprecated

CpuFlags:      equ   0
wCount_MSB:    equ   1
wCount_LSB:    equ   2

   RAM_PROLOGUE RAM_USE_CLASS_2
   mov   X, SP                                   ; X <- stack frame pointer
   add   SP, 3                                   ; Reserve space for flags, count
   mov   A, reg[TickTimer_CONTROL_LSB_REG]       ; save the Control register
   push  A
   mov   A, reg[TickTimer_COMPARE_LSB_REG]       ; save the Compare register
   push  A
   mov   A, reg[TickTimer_COMPARE_MSB_REG]
   push  A
   mov   A, reg[TickTimer_COUNTER_LSB_REG]       ; synchronous copy DR2 <- DR0
                                                 ; This may cause an interrupt!
   mov   A, reg[TickTimer_COMPARE_MSB_REG]       ; Now grab DR2 (DR0) and save
   mov   [X+wCount_MSB], A
   mov   A, reg[TickTimer_COMPARE_LSB_REG]
   mov   [X+wCount_LSB], A
   mov   A, 0                                    ; Guess the global interrupt state
   tst   reg[CPU_F], FLAG_GLOBAL_IE              ; Currently Disabled?
   jz    .SetupStatusFlag                        ;   Yes, guess was correct
   mov   A, FLAG_GLOBAL_IE                       ;    No, modify our guess
.SetupStatusFlag:                                ; and ...
   mov   [X+CpuFlags], A                         ;   StackFrame[0] <- Flag Reg image
   M8C_DisableGInt                               ; Disable interrupts globally
   TickTimer_Stop_M                              ; Disable (stop) the timer
   pop   A                                       ; Restore the Compare register
   mov   reg[TickTimer_COMPARE_MSB_REG], A
   pop   A
   mov   reg[TickTimer_COMPARE_LSB_REG], A
   pop   A                                       ; restore start state of the timer
   mov   reg[TickTimer_CONTROL_LSB_REG], A
   pop   A                                       ; Return result stored in stack frame
   pop   X
   RAM_EPILOGUE RAM_USE_CLASS_2
   reti                                          ; Flag Reg <- StackFrame[0]

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: TickTimer_wReadTimer
;
;  DESCRIPTION:
;     Performs a software capture of the Count register.  A synchronous
;     read of the Count register is performed.  The timer is NOT stopped.
;
;     WARNING - this will cause loss of data in the Compare register.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      fastcall16 WORD wCount, (value of DR0 in the X & A registers)
;  SIDE EFFECTS:
;    May cause an interrupt.
;
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
;  THEORY of OPERATION:
;     1) Read the Count register - this causes the count value to be
;        latched into the Compare registers.
;     2) Read and return the Count register values from the Compare
;        registers into the return buffer.
;
 TickTimer_wReadTimer:
_TickTimer_wReadTimer:
 wTickTimer_ReadTimer:                           ; this name deprecated
_wTickTimer_ReadTimer:                           ; this name deprecated
 wTickTimer_CaptureCounter:                      ; this name deprecated
_wTickTimer_CaptureCounter:                      ; this name deprecated

   RAM_PROLOGUE RAM_USE_CLASS_1
   mov   A, reg[TickTimer_COUNTER_LSB_REG]       ; synchronous copy DR2 <- DR0
                                                 ; This may cause an interrupt!

   mov   A, reg[TickTimer_COMPARE_MSB_REG]       ; Return DR2 (actually DR0)
   mov   X, A
   mov   A, reg[TickTimer_COMPARE_LSB_REG]
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION

; End of File TickTimer.asm
