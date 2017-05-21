Project:      output/FrequencyProject
Build Number: 0
Date:         Fri Apr 25 11:34:37 2014
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0200   0020 =     32. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0220  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0220   0004 =      4. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0220  __idata_start
       0224  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0224   022F =    559. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0224  LoadConfigTBL_frequencyproject
       0440  LoadConfigInit
       0440  _LoadConfigInit
       044D  _LoadConfig_frequencyproject
       044D  LoadConfig_frequencyproject
       0453  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0453   0276 =    630. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0453  _TickTimer_ISR
       0477  SampleFreq_EnableInt
       0477  _SampleFreq_EnableInt
       047B  _SampleFreq_DisableInt
       047B  SampleFreq_DisableInt
       047F  _SampleFreq_Start
       047F  SampleFreq_Start
       0483  SampleFreq_Stop
       0483  _SampleFreq_Stop
       0487  _SampleFreq_WritePeriod
       0487  SampleFreq_WritePeriod
       0495  _SampleFreq_WriteCompareValue
       0495  SampleFreq_WriteCompareValue
       04A3  SampleFreq_ReadCompareValue
       04A3  _SampleFreq_ReadCompareValue
       04B3  _SampleFreq_ReadCounter
       04B3  SampleFreq_ReadCounter
       04F6  LCD_PrCString
       04F6  _LCD_PrCString
       0508  LCD_HEX_STR
       0518  LCD_PrHexByte
       0518  _LCD_PrHexByte
       052B  _LCD_PrHexInt
       052B  LCD_PrHexInt
       0532  LCD_PrString
       0532  _LCD_PrString
       053C  LCD_WriteData
       053C  _LCD_WriteData
       053C  LCD_Write_Data
       053C  _LCD_Write_Data
       0550  LCD_Control
       0550  _LCD_Control
       05F7  LCD_Start
       05F7  LCD_Init
       05F7  _LCD_Init
       05F7  _LCD_Start
       0663  LCD_ROW_OFFSET
       0667  LCD_Position
       0667  _LCD_Position
       0673  LCD_Delay50uTimes
       0673  _LCD_Delay50uTimes
       0679  LCD_Delay50u_Table
       0681  LCD_Delay50u
       0681  _LCD_Delay50u
       0695  Comparator_SetPower
       0695  Comparator_Start
       0695  _Comparator_Start
       0695  _Comparator_SetPower
       06A3  Comparator_SetRef
       06A3  _Comparator_SetRef
       06C5  _Comparator_Stop
       06C5  Comparator_Stop
       06C9  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   06C9   126B =   4715. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       06C9  __text_start
       06C9  _StartFreq
       06E5  _main
       0AC3  _DisplayValue
       0E73  _TickHandler_ISR
       1387  _ltoa
       1590  _ftoa
       1934  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0004 =      4. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0000  _fFreqValue
       0004  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0004   000B =     11. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0004  __rZ
       0005  __rY
       0006  __rX
       0007  __r7
       0008  __r6
       0009  __r5
       000A  __r4
       000B  __r3
       000C  __r2
       000D  __r1
       000E  __r0
       000F  __virtual_registers_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   000F   0010 =     16. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       000F  _cOverFlow
       0010  _wTickCount
       0012  _wFirstValue
       0014  _wLastValue
       0016  _cSaveOverFlow
       0017  _wSaveTickNum
       0019  _wSaveCountNum
       001B  _bDataAvailable
       001C  Port_2_Data_SHADE
       001C  NO_SHADOW
       001C  _Port_2_Data_SHADE
       001C  _NO_SHADOW
       001D  Port_2_DriveMode_0_SHADE
       001D  _Port_2_DriveMode_0_SHADE
       001E  _Port_2_DriveMode_1_SHADE
       001E  Port_2_DriveMode_1_SHADE
       001F  __InterruptRAM_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   001F   0015 =     21. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       001F  __bss_start
       001F  _iTemp
       0021  _pTemp
       0023  _pString
       0034  __ramareas_end
       0034  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   00EC =    236. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       00E9  _bGetPowerSetting
       00E9  bGetPowerSetting

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/freqcode.o	[ freqcode.asm ]
obj/main.o	[ main.c ]
obj/tickhander.o	[ tickhander.asm ]
<library>	[ ticktimerint.asm, samplefreq.asm, psocconfigtbl.asm, psocconfig.asm, lcd.asm, comparator.asm ]
[ rZ.asm, rY.asm, rX.asm, r7.asm, r6.asm, r5.asm, r4.asm, r3.asm, r2.asm, r1.asm, r0.asm, divmodu_32x32_32_util.asm ]
[ fp_analysiseject_util.asm, fp_clrreg_util.asm, fp_nan_res_util.asm, fp_saveres_util.asm ]
[ fp_sendtoreg_util.asm, fp_sinf_res_util.asm, fp_szero_res_util.asm, fp_type_oprnd_util.asm ]
[ fp_unnormal_util.asm, fpadd_util.asm, fpcmp_util.asm, fpdiv_util.asm, fpmul_util.asm, i_div32_block_util.asm ]
[ i_div32_not_util.asm, i_mulu8_block_util.asm, long2fp_util.asm, ltoa.s, ftoa.s ]

Area Definitions

-blit:0x200.0x7fff
-bdata:0.0xff
-rwh:SSCParmBlk:0xf7.0xff

