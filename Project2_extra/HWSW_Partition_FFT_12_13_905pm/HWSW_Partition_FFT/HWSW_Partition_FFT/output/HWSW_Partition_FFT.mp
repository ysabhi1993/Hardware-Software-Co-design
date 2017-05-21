Project:      output/HWSW_Partition_FFT
Build Number: 0
Date:         Wed Dec 14 18:25:32 2016
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   0074 =    116. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_hwsw_partition_fft_Bank0
       01EF  LoadConfigTBL_hwsw_partition_fft_Bank1
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
       0216  LoadConfigTBL_hwsw_partition_fft_Ordered
       031B  LoadConfigInit
       031B  _LoadConfigInit
       032B  LoadConfig_hwsw_partition_fft
       032B  _LoadConfig_hwsw_partition_fft
       0386  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0386   04A1 =   1185. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0386  _LCD_1_PrCString
       0386  LCD_1_PrCString
       0398  LCD_1_HEX_STR
       03A8  _LCD_1_PrHexByte
       03A8  LCD_1_PrHexByte
       03BB  LCD_1_PrHexInt
       03BB  _LCD_1_PrHexInt
       03C2  _LCD_1_PrString
       03C2  LCD_1_PrString
       03D4  _LCD_1_Write_Data
       03D4  _LCD_1_WriteData
       03D4  LCD_1_Write_Data
       03D4  LCD_1_WriteData
       03E8  _LCD_1_Control
       03E8  LCD_1_Control
       0498  _LCD_1_Start
       0498  _LCD_1_Init
       0498  LCD_1_Start
       0498  LCD_1_Init
       0507  LCD_1_ROW_OFFSET
       050B  LCD_1_Position
       050B  _LCD_1_Position
       051B  _LCD_1_Delay50uTimes
       051B  LCD_1_Delay50uTimes
       0521  LCD_1_Delay50u_Table
       0529  _LCD_1_Delay50u
       0529  LCD_1_Delay50u
       053D  _LCD_1_DrawBG
       056E  _LCD_1_DrawVBG
       05A2  _LCD_1_InitVBG
       05A2  LCD_1_InitVBG
       05D3  LCD_1_BG_TYPE1
       05DA  LCD_1_BG_TYPE2
       05E1  LCD_1_InitBG
       05E1  _LCD_1_InitBG
       0616  _bFlashWriteBlock
       0616  bFlashWriteBlock
       068C  _FlashBlockLocal1
       06D1  _FlashBlockLocal2
       072C  _FlashBlockLocal3
       07BC  _FlashReadBlock
       07BC  FlashReadBlock
       0827  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0827   30FF =  12543. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0827  __text_start
       0827  _FFT
       15AC  _main
       263D  _ltoa
       28B6  _ftoa
       2D05  _cosf
       2D67  _floorf
       2E87  _frexpf
       2F5D  _logf
       320C  _sinus
       3547  _sinf
       35AD  _sqrtf
       3926  __xidata_start
       3926  __text_end
       3944  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   0143 =    323. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       0140  _bGetPowerSetting
       0140  bGetPowerSetting

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                      SSCParmBlk   0000   0100 =    256. bytes (abs,ovr,ram)

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
               virtual_registers   0520   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0520  __rZ
       0521  __rY
       0522  __rX
       0523  __r11
       0524  __r10
       0525  __r9
       0526  __r8
       0527  __r7
       0528  __r6
       0529  __r5
       052A  __r4
       052B  __r3
       052C  __r2
       052D  __r1
       052E  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0539 =   1337. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0003  _data_imm
       0023  _data_re
       0043  _final_data_imm
       0063  _mod
       0083  _save_data_imm
       00A3  _save_data_re
       00C3  _final_data_re
       00F2  _max
       00F6  _i
       0100  _temp_array_read
       0200  _temp_array_result
       0300  _temp_array_result_read
       0400  _temp_array
       0500  _final_mod
       052F  _FlashParams
       0537  _zero
       053B  _df
       053F  _data_read
       0541  _data
       0543  _ind
       0545  _status
       0547  _z
       0549  _j
       054B  _p
       054D  _a
       054F  _k
       0551  _errno

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, lcd_1.asm, flashblock.asm, rZ.asm, rY.asm, rX.asm, r11.asm, r10.asm ]
[ r9.asm, r8.asm, r7.asm, r6.asm, r5.asm, r4.asm, r3.asm, r2.asm, r1.asm, r0.asm, divmod_16x16_16_util.asm ]
[ divmodu_32x32_32_util.asm, fp2long_util.asm, fp_analysiseject_util.asm, fp_clrreg_util.asm ]
[ fp_nan_res_util.asm, fp_saveres_util.asm, fp_sendtoreg_util.asm, fp_sinf_res_util.asm, fp_szero_res_util.asm ]
[ fp_type_oprnd_util.asm, fp_unnormal_util.asm, fpadd_util.asm, fpcmp_util.asm, fpdiv_util.asm ]
[ fpmul_util.asm, fpsub_util.asm, i_div16_block_util.asm, i_div32_block_util.asm, i_div32_not_util.asm ]
[ i_mulu8_block_util.asm, long2fp_util.asm, ltoa.s, ftoa.s, cosf.s, floorf.s, frexpf.s, logf.s, sinf.s ]
[ sqrtf.s, errno.s ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-bSSCParmBlk:0xf7.0xff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x520
-Bhwsw_partition_fft_RAM
-rwh:SSCParmBlk:0xf7.0xff

