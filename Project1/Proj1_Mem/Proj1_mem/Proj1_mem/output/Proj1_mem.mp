Project:      output/Proj1_mem
Build Number: 0
Date:         Thu Nov 03 23:21:52 2016
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   0074 =    116. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_proj1_mem_Bank0
       01EF  LoadConfigTBL_proj1_mem_Bank1
       0214  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0214   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0214  __func_lit_start
       0216  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0216   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0216  LoadConfigTBL_proj1_mem_Ordered
       031B  LoadConfigInit
       031B  _LoadConfigInit
       032B  LoadConfig_proj1_mem
       032B  _LoadConfig_proj1_mem
       0386  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0386   028F =    655. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0386  LCD_PrCString
       0386  _LCD_PrCString
       0398  LCD_HEX_STR
       03A8  LCD_PrHexByte
       03A8  _LCD_PrHexByte
       03BB  LCD_PrHexInt
       03BB  _LCD_PrHexInt
       03C2  LCD_PrString
       03C2  _LCD_PrString
       03D4  LCD_Write_Data
       03D4  _LCD_WriteData
       03D4  LCD_WriteData
       03D4  _LCD_Write_Data
       03E8  LCD_Control
       03E8  _LCD_Control
       0498  _LCD_Init
       0498  LCD_Init
       0498  LCD_Start
       0498  _LCD_Start
       0507  LCD_ROW_OFFSET
       050B  LCD_Position
       050B  _LCD_Position
       051B  LCD_Delay50uTimes
       051B  _LCD_Delay50uTimes
       0521  LCD_Delay50u_Table
       0529  LCD_Delay50u
       0529  _LCD_Delay50u
       053D  _LCD_DrawBG
       056E  _LCD_DrawVBG
       05A2  LCD_InitVBG
       05A2  _LCD_InitVBG
       05D3  LCD_BG_TYPE1
       05DA  LCD_BG_TYPE2
       05E1  LCD_InitBG
       05E1  _LCD_InitBG
       0615  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0615   02C8 =    712. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0615  __text_start
       0615  _main
       0699  _routine_avg
       08C2  _mod_A_X
       08DD  __text_end
       08DD  __xidata_start
       08DF  __xidata_end

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
               virtual_registers   0003   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0003  __r1
       0004  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.asm ]
obj/routine_avg.o	[ routine_avg.asm ]
obj/routine_max.o	[ routine_max.asm ]
obj/routine_mod.o	[ routine_mod.asm ]
obj/routine_mul.o	[ routine_mul.asm ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, lcd.asm, r1.asm, r0.asm ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x3
-Bproj1_mem_RAM
-rwh:SSCParmBlk:0xf7.0xff

