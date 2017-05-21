Project:      output/Debouncer_Counter_LCD
Build Number: 0
Date:         Fri Oct 21 00:28:36 2016
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   008C =    140. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_debouncer_counter_lcd_Bank0
       01FB  LoadConfigTBL_debouncer_counter_lcd_Bank1
       022C  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   022C   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       022C  __func_lit_start
       022E  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   022E   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       022E  LoadConfigTBL_debouncer_counter_lcd_Ordered
       0333  _LoadConfigInit
       0333  LoadConfigInit
       0343  _LoadConfig_debouncer_counter_lcd
       0343  LoadConfig_debouncer_counter_lcd
       039E  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   039E   0328 =    808. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       039E  _Timer16_sec_ISR
       03D7  _Timer16_sec_EnableInt
       03D7  Timer16_sec_EnableInt
       03DB  _Timer16_sec_DisableInt
       03DB  Timer16_sec_DisableInt
       03DF  _Timer16_sec_Start
       03DF  Timer16_sec_Start
       03E3  Timer16_sec_Stop
       03E3  _Timer16_sec_Stop
       03E7  Timer16_sec_WritePeriod
       03E7  _Timer16_sec_WritePeriod
       03ED  _Timer16_sec_WriteCompareValue
       03ED  Timer16_sec_WriteCompareValue
       03F3  Timer16_sec_wReadCompareValue
       03F3  _wTimer16_sec_ReadCompareValue
       03F3  _Timer16_sec_wReadCompareValue
       03F3  wTimer16_sec_ReadCompareValue
       03F9  wTimer16_sec_ReadTimerSaveCV
       03F9  Timer16_sec_wReadTimerSaveCV
       03F9  _Timer16_sec_wReadTimerSaveCV
       03F9  _wTimer16_sec_ReadTimerSaveCV
       03F9  _wTimer16_sec_ReadCounter
       03F9  wTimer16_sec_ReadCounter
       042F  wTimer16_sec_ReadTimer
       042F  _wTimer16_sec_CaptureCounter
       042F  _Timer16_sec_wReadTimer
       042F  _wTimer16_sec_ReadTimer
       042F  wTimer16_sec_CaptureCounter
       042F  Timer16_sec_wReadTimer
       0437  _LCD_PrCString
       0437  LCD_PrCString
       0449  LCD_HEX_STR
       0459  LCD_PrHexByte
       0459  _LCD_PrHexByte
       046C  LCD_PrHexInt
       046C  _LCD_PrHexInt
       0473  _LCD_PrString
       0473  LCD_PrString
       0485  LCD_Write_Data
       0485  _LCD_Write_Data
       0485  _LCD_WriteData
       0485  LCD_WriteData
       0499  _LCD_Control
       0499  LCD_Control
       0549  _LCD_Init
       0549  LCD_Start
       0549  _LCD_Start
       0549  LCD_Init
       05B8  LCD_ROW_OFFSET
       05BC  LCD_Position
       05BC  _LCD_Position
       05CC  LCD_Delay50uTimes
       05CC  _LCD_Delay50uTimes
       05D2  LCD_Delay50u_Table
       05DA  _LCD_Delay50u
       05DA  LCD_Delay50u
       05EE  _LCD_DrawBG
       061F  _LCD_DrawVBG
       0653  LCD_InitVBG
       0653  _LCD_InitVBG
       0684  LCD_BG_TYPE1
       068B  LCD_BG_TYPE2
       0692  LCD_InitBG
       0692  _LCD_InitBG
       06C6  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   06C6   004B =     75. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       06C6  __text_start
       06C6  _main
       0700  PSoC_GPIO_ISR
       0711  __xidata_start
       0711  __text_end
       0713  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   0143 =    323. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       0140  _bGetPowerSetting
       0140  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   0003 =      3. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _NO_SHADOW
       0000  Port_2_Data_SHADE
       0000  NO_SHADOW
       0000  _Port_2_Data_SHADE
       0001  _Port_2_DriveMode_0_SHADE
       0001  Port_2_DriveMode_0_SHADE
       0002  _Port_2_DriveMode_1_SHADE
       0002  Port_2_DriveMode_1_SHADE

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0000   0001 =      1. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __bss_start
       0005  bShadow

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0003   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0003  __r1
       0004  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.asm ]
<library>	[ timer16_secint.asm, timer16_sec.asm, psocgpioint.asm, psocconfigtbl.asm, psocconfig.asm, lcd.asm ]
[ r1.asm, r0.asm ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x3
-Bdebouncer_counter_lcd_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

