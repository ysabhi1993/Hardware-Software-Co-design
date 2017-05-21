Project:      output/CE58788
Build Number: 0
Date:         Wed Dec 17 12:02:38 2014
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0150   00D0 =    208. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0150  _packet_data
       0188  LoadConfigTBL_example_crc_spim_Bank0
       01E9  LoadConfigTBL_example_crc_spim_Bank1
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
       0222  LoadConfigTBL_example_crc_spim_Ordered
       0327  _LoadConfigInit
       0327  LoadConfigInit
       0337  _LoadConfig_example_crc_spim
       0337  LoadConfig_example_crc_spim
       0392  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0392   0208 =    520. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0392  _SPIM_ISR
       0393  _SPIM_EnableInt
       0393  SPIM_EnableInt
       0397  _SPIM_DisableInt
       0397  SPIM_DisableInt
       039B  SPIM_Start
       039B  _SPIM_Start
       03A0  _SPIM_Stop
       03A0  SPIM_Stop
       03A4  SPIM_SendTxData
       03A4  _SPIM_SendTxData
       03A7  bSPIM_ReadRxData
       03A7  SPIM_bReadRxData
       03A7  _SPIM_bReadRxData
       03A7  _bSPIM_ReadRxData
       03AA  SPIM_bReadStatus
       03AA  _SPIM_bReadStatus
       03AA  _bSPIM_ReadStatus
       03AA  bSPIM_ReadStatus
       03AD  LCD_PrCString
       03AD  _LCD_PrCString
       03BF  LCD_HEX_STR
       03CF  _LCD_PrHexByte
       03CF  LCD_PrHexByte
       03E2  LCD_PrHexInt
       03E2  _LCD_PrHexInt
       03E9  LCD_PrString
       03E9  _LCD_PrString
       03FB  LCD_Write_Data
       03FB  _LCD_WriteData
       03FB  _LCD_Write_Data
       03FB  LCD_WriteData
       040F  _LCD_Control
       040F  LCD_Control
       04BF  _LCD_Init
       04BF  _LCD_Start
       04BF  LCD_Start
       04BF  LCD_Init
       052E  LCD_ROW_OFFSET
       0532  LCD_Position
       0532  _LCD_Position
       0542  _LCD_Delay50uTimes
       0542  LCD_Delay50uTimes
       0548  LCD_Delay50u_Table
       0550  _LCD_Delay50u
       0550  LCD_Delay50u
       0564  CRC16_Start
       0564  _CRC16_Start
       0568  CRC16_Stop
       0568  _CRC16_Stop
       056C  _CRC16_WriteSeed
       056C  CRC16_WriteSeed
       057E  _CRC16_WritePolynomial
       057E  CRC16_WritePolynomial
       0590  wCRC16_ReadCRC
       0590  _wCRC16_ReadCRC
       0590  _CRC16_wReadCRC
       0590  CRC16_wReadCRC
       059A  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   059A   01AB =    427. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       059A  __text_start
       059A  _main
       0615  _sendDataToCRC
       06B0  _outputData
       0745  __xidata_start
       0745  __text_end
       074B  __xidata_end

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
               virtual_registers   0003   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0003  __rY
       0004  __rX
       0005  __r3
       0006  __r2
       0007  __r1
       0008  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0004 =      4. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0009  _wMasterCrc
       000B  _flagReg
       000C  _bStringIndex

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ spimint.asm, spim.asm, psocconfigtbl.asm, psocconfig.asm, lcd.asm, crc16.asm, rY.asm, rX.asm, r3.asm ]
[ r2.asm, r1.asm, r0.asm ]

Area Definitions

-blit:0x150.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x3
-Bexample_crc_spim_RAM
-rwh:SSCParmBlk:0xf7.0xff

