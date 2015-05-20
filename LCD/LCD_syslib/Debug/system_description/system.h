/* system.h
 *
 * Machine generated for a CPU named "cpu" as defined in:
 * D:\work\FPGA\quartus\nios_ii\LCD\kernel.ptf
 *
 * Generated: 2015-05-21 00:08:33.777
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "kernel"
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEIVE"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x00001878
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x00001878
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x00001878
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 100000000
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0
#define NIOS2_INTERRUPT_CONTROLLER_ID 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x04000020
#define NIOS2_RESET_ADDR 0x00000000
#define NIOS2_BREAK_ADDR 0x00001020

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO

/*
 * sysid configuration
 *
 */

#define SYSID_NAME "/dev/sysid"
#define SYSID_TYPE "altera_avalon_sysid"
#define SYSID_BASE 0x00001870
#define SYSID_SPAN 8
#define SYSID_ID 12345678u
#define SYSID_TIMESTAMP 1432136928u
#define SYSID_REGENERATE_VALUES 0
#define ALT_MODULE_CLASS_sysid altera_avalon_sysid

/*
 * sdram configuration
 *
 */

#define SDRAM_NAME "/dev/sdram"
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_BASE 0x04000000
#define SDRAM_SPAN 33554432
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_ADDR_WIDTH 13
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_CAS_LATENCY 2
#define SDRAM_T_RFC 66.0
#define SDRAM_T_RP 15.0
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 15.0
#define SDRAM_T_AC 5.4
#define SDRAM_T_WR 14.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_SHARED_DATA 0
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_IS_INITIALIZED 1
#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller

/*
 * epcs configuration
 *
 */

#define EPCS_NAME "/dev/epcs"
#define EPCS_TYPE "altera_avalon_epcs_flash_controller"
#define EPCS_BASE 0x00000000
#define EPCS_SPAN 2048
#define EPCS_IRQ 0
#define EPCS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_DATABITS 8
#define EPCS_TARGETCLOCK 20
#define EPCS_CLOCKUNITS "MHz"
#define EPCS_CLOCKMULT 1000000
#define EPCS_NUMSLAVES 1
#define EPCS_ISMASTER 1
#define EPCS_CLOCKPOLARITY 0
#define EPCS_CLOCKPHASE 0
#define EPCS_LSBFIRST 0
#define EPCS_EXTRADELAY 0
#define EPCS_TARGETSSDELAY 100
#define EPCS_DELAYUNITS "us"
#define EPCS_DELAYMULT "1e-006"
#define EPCS_PREFIX "epcs_"
#define EPCS_REGISTER_OFFSET 0x400
#define EPCS_IGNORE_LEGACY_CHECK 1
#define EPCS_USE_ASMI_ATOM 0
#define EPCS_CLOCKUNIT "kHz"
#define EPCS_DELAYUNIT "us"
#define EPCS_DISABLEAVALONFLOWCONTROL 0
#define EPCS_INSERT_SYNC 0
#define EPCS_SYNC_REG_DEPTH 2
#define ALT_MODULE_CLASS_epcs altera_avalon_epcs_flash_controller

/*
 * jtag_uart configuration
 *
 */

#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_BASE 0x00001878
#define JTAG_UART_SPAN 8
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_READ_CHAR_STREAM ""
#define JTAG_UART_SHOWASCII 1
#define JTAG_UART_RELATIVEPATH 1
#define JTAG_UART_READ_LE 0
#define JTAG_UART_WRITE_LE 0
#define JTAG_UART_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 1
#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart

/*
 * PIO_LCD_PWM configuration
 *
 */

#define PIO_LCD_PWM_NAME "/dev/PIO_LCD_PWM"
#define PIO_LCD_PWM_TYPE "altera_avalon_pio"
#define PIO_LCD_PWM_BASE 0x00001800
#define PIO_LCD_PWM_SPAN 16
#define PIO_LCD_PWM_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_PWM_DRIVEN_SIM_VALUE 0
#define PIO_LCD_PWM_HAS_TRI 0
#define PIO_LCD_PWM_HAS_OUT 1
#define PIO_LCD_PWM_HAS_IN 0
#define PIO_LCD_PWM_CAPTURE 0
#define PIO_LCD_PWM_DATA_WIDTH 1
#define PIO_LCD_PWM_RESET_VALUE 0
#define PIO_LCD_PWM_EDGE_TYPE "NONE"
#define PIO_LCD_PWM_IRQ_TYPE "NONE"
#define PIO_LCD_PWM_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_PWM_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_PWM_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_PWM altera_avalon_pio

/*
 * PIO_LCD_CTRL configuration
 *
 */

#define PIO_LCD_CTRL_NAME "/dev/PIO_LCD_CTRL"
#define PIO_LCD_CTRL_TYPE "altera_avalon_pio"
#define PIO_LCD_CTRL_BASE 0x00001810
#define PIO_LCD_CTRL_SPAN 16
#define PIO_LCD_CTRL_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_CTRL_DRIVEN_SIM_VALUE 0
#define PIO_LCD_CTRL_HAS_TRI 0
#define PIO_LCD_CTRL_HAS_OUT 1
#define PIO_LCD_CTRL_HAS_IN 0
#define PIO_LCD_CTRL_CAPTURE 0
#define PIO_LCD_CTRL_DATA_WIDTH 8
#define PIO_LCD_CTRL_RESET_VALUE 0
#define PIO_LCD_CTRL_EDGE_TYPE "NONE"
#define PIO_LCD_CTRL_IRQ_TYPE "NONE"
#define PIO_LCD_CTRL_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_CTRL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_CTRL_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_CTRL altera_avalon_pio

/*
 * PIO_LCD_B configuration
 *
 */

#define PIO_LCD_B_NAME "/dev/PIO_LCD_B"
#define PIO_LCD_B_TYPE "altera_avalon_pio"
#define PIO_LCD_B_BASE 0x00001820
#define PIO_LCD_B_SPAN 16
#define PIO_LCD_B_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_B_DRIVEN_SIM_VALUE 0
#define PIO_LCD_B_HAS_TRI 0
#define PIO_LCD_B_HAS_OUT 1
#define PIO_LCD_B_HAS_IN 0
#define PIO_LCD_B_CAPTURE 0
#define PIO_LCD_B_DATA_WIDTH 6
#define PIO_LCD_B_RESET_VALUE 0
#define PIO_LCD_B_EDGE_TYPE "NONE"
#define PIO_LCD_B_IRQ_TYPE "NONE"
#define PIO_LCD_B_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_B_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_B_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_B altera_avalon_pio

/*
 * PIO_LCD_G configuration
 *
 */

#define PIO_LCD_G_NAME "/dev/PIO_LCD_G"
#define PIO_LCD_G_TYPE "altera_avalon_pio"
#define PIO_LCD_G_BASE 0x00001830
#define PIO_LCD_G_SPAN 16
#define PIO_LCD_G_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_G_DRIVEN_SIM_VALUE 0
#define PIO_LCD_G_HAS_TRI 0
#define PIO_LCD_G_HAS_OUT 1
#define PIO_LCD_G_HAS_IN 0
#define PIO_LCD_G_CAPTURE 0
#define PIO_LCD_G_DATA_WIDTH 6
#define PIO_LCD_G_RESET_VALUE 0
#define PIO_LCD_G_EDGE_TYPE "NONE"
#define PIO_LCD_G_IRQ_TYPE "NONE"
#define PIO_LCD_G_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_G_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_G_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_G altera_avalon_pio

/*
 * PIO_LCD_R configuration
 *
 */

#define PIO_LCD_R_NAME "/dev/PIO_LCD_R"
#define PIO_LCD_R_TYPE "altera_avalon_pio"
#define PIO_LCD_R_BASE 0x00001840
#define PIO_LCD_R_SPAN 16
#define PIO_LCD_R_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_R_DRIVEN_SIM_VALUE 0
#define PIO_LCD_R_HAS_TRI 0
#define PIO_LCD_R_HAS_OUT 1
#define PIO_LCD_R_HAS_IN 0
#define PIO_LCD_R_CAPTURE 0
#define PIO_LCD_R_DATA_WIDTH 6
#define PIO_LCD_R_RESET_VALUE 0
#define PIO_LCD_R_EDGE_TYPE "NONE"
#define PIO_LCD_R_IRQ_TYPE "NONE"
#define PIO_LCD_R_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_R_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_R_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_R altera_avalon_pio

/*
 * PIO_LCD_CLK configuration
 *
 */

#define PIO_LCD_CLK_NAME "/dev/PIO_LCD_CLK"
#define PIO_LCD_CLK_TYPE "altera_avalon_pio"
#define PIO_LCD_CLK_BASE 0x00001850
#define PIO_LCD_CLK_SPAN 16
#define PIO_LCD_CLK_DO_TEST_BENCH_WIRING 0
#define PIO_LCD_CLK_DRIVEN_SIM_VALUE 0
#define PIO_LCD_CLK_HAS_TRI 0
#define PIO_LCD_CLK_HAS_OUT 1
#define PIO_LCD_CLK_HAS_IN 0
#define PIO_LCD_CLK_CAPTURE 0
#define PIO_LCD_CLK_DATA_WIDTH 1
#define PIO_LCD_CLK_RESET_VALUE 0
#define PIO_LCD_CLK_EDGE_TYPE "NONE"
#define PIO_LCD_CLK_IRQ_TYPE "NONE"
#define PIO_LCD_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LCD_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LCD_CLK_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LCD_CLK altera_avalon_pio

/*
 * PIO_LED configuration
 *
 */

#define PIO_LED_NAME "/dev/PIO_LED"
#define PIO_LED_TYPE "altera_avalon_pio"
#define PIO_LED_BASE 0x00001860
#define PIO_LED_SPAN 16
#define PIO_LED_DO_TEST_BENCH_WIRING 0
#define PIO_LED_DRIVEN_SIM_VALUE 0
#define PIO_LED_HAS_TRI 0
#define PIO_LED_HAS_OUT 1
#define PIO_LED_HAS_IN 0
#define PIO_LED_CAPTURE 0
#define PIO_LED_DATA_WIDTH 4
#define PIO_LED_RESET_VALUE 0
#define PIO_LED_EDGE_TYPE "NONE"
#define PIO_LED_IRQ_TYPE "NONE"
#define PIO_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LED_FREQ 100000000
#define ALT_MODULE_CLASS_PIO_LED altera_avalon_pio

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       SDRAM
#define ALT_RODATA_DEVICE     SDRAM
#define ALT_RWDATA_DEVICE     SDRAM
#define ALT_EXCEPTIONS_DEVICE SDRAM
#define ALT_RESET_DEVICE      EPCS


#endif /* __SYSTEM_H_ */
