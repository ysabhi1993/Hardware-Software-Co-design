Project:      output/Debouncer_Counter_LCD
Build Number: 0
Date:         Thu Oct 20 21:45:40 2016
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   0080 =    128. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_debouncer_counter_lcd_Bank0
       01F5  LoadConfigTBL_debouncer_counter_lcd_Bank1
       0220  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0220   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0220  __func_lit_start
       0222  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0222   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0222  LoadConfigTBL_debouncer_counter_lcd_Ordered
       0327  _LoadConfigInit
       0327  LoadConfigInit
       0337  _LoadConfig_debouncer_counter_lcd
       0337  LoadConfig_debouncer_counter_lcd
       0392  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0392   02D9 =    729. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0392  _Timer8_1_ISR
       0393  _Timer8_1_EnableInt
       0393  Timer8_1_EnableInt
       0397  _Timer8_1_DisableInt
       0397  Timer8_1_DisableInt
       039B  _Timer8_1_Start
       039B  Timer8_1_Start
       039F  _Timer8_1_Stop
       039F  Timer8_1_Stop
       03A3  _Timer8_1_WritePeriod
       03A3  Timer8_1_WritePeriod
       03A6  Timer8_1_WriteCompareValue
       03A6  _Timer8_1_WriteCompareValue
       03A9  _bTimer8_1_ReadCompareValue
       03A9  _Timer8_1_bReadCompareValue
       03A9  bTimer8_1_ReadCompareValue
       03A9  Timer8_1_bReadCompareValue
       03AC  bTimer8_1_ReadTimerSaveCV
       03AC  _bTimer8_1_ReadCounter
       03AC  Timer8_1_bReadTimerSaveCV
       03AC  bTimer8_1_ReadCounter
       03AC  _Timer8_1_bReadTimerSaveCV
       03AC  _bTimer8_1_ReadTimerSaveCV
       03D7  bTimer8_1_CaptureCounter
       03D7  bTimer8_1_ReadTimer
       03D7  _bTimer8_1_CaptureCounter
       03D7  _Timer8_1_bReadTimer
       03D7  _bTimer8_1_ReadTimer
       03D7  Timer8_1_bReadTimer
       03DC  LCD_PrCString
       03DC  _LCD_PrCString
       03EE  LCD_HEX_STR
       03FE  _LCD_PrHexByte
       03FE  LCD_PrHexByte
       0411  LCD_PrHexInt
       0411  _LCD_PrHexInt
       0418  LCD_PrString
       0418  _LCD_PrString
       042A  LCD_WriteData
       042A  _LCD_Write_Data
       042A  LCD_Write_Data
       042A  _LCD_WriteData
       043E  _LCD_Control
       043E  LCD_Control
       04EE  _LCD_Start
       04EE  LCD_Start
       04EE  _LCD_Init
       04EE  LCD_Init
       055D  LCD_ROW_OFFSET
       0561  LCD_Position
       0561  _LCD_Position
       0571  LCD_Delay50uTimes
       0571  _LCD_Delay50uTimes
       0577  LCD_Delay50u_Table
       057F  _LCD_Delay50u
       057F  LCD_Delay50u
       0593  _LCD_DrawBG
       05C4  _LCD_DrawVBG
       05F8  LCD_InitVBG
       05F8  _LCD_InitVBG
       0629  LCD_BG_TYPE1
       0630  LCD_BG_TYPE2
       0637  LCD_InitBG
       0637  _LCD_InitBG
       066B  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   066B   005C =     92. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       066B  __text_start
       066B  _main
       06A1  PSoC_GPIO_ISR
       06C7  __xidata_start
       06C7  __text_end
       06C9  __xidata_end

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
<library>	[ timer8_1int.asm, timer8_1.asm, psocgpioint.asm, psocconfigtbl.asm, psocconfig.asm, lcd.asm ]
[ r1.asm, r0.asm ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x3
-Bdebouncer_counter_lcd_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

