/*
 * =====================================================================================
 *
 *       Filename:  sopc.h 
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  ÂíÈð (AVIC)
 *			Email:  avic633@gmail.com  
 *			   QQ:  984597569
 *			  URL:  http://kingst.cnblogs.com
 *
 * =====================================================================================
 */

#ifndef SOPC_H_
#define SOPC_H_

/*-----------------------------------------------------------------------------
 *  Include
 *-----------------------------------------------------------------------------*/
#include "system.h"

/*-----------------------------------------------------------------------------
 *  Define
 *-----------------------------------------------------------------------------*/  
#define _LCD
#define _LED
#define _UART

/*-----------------------------------------------------------------------------
 *  Peripheral registers structures  
 *-----------------------------------------------------------------------------*/

typedef struct
{
    unsigned long int DATA;
    unsigned long int DIRECTION;
    unsigned long int INTERRUPT_MASK;
    unsigned long int EDGE_CAPTURE;
    
}PIO_STR;
/*--------------------------UART------------------------------------------*/
typedef struct
{
    union{
        struct{
            volatile unsigned long int RECEIVE_DATA         :8;
            volatile unsigned long int NC                   :24;           
        }BITS;
        volatile unsigned long int WORD;
    }RXDATA;

    union{
        struct{
            volatile unsigned long int TRANSMIT_DATA        :8;
            volatile unsigned long int NC                   :24;            
        }BITS;
        volatile unsigned long int WORD;
    }TXDATA;

    union{
        struct{
            volatile unsigned long int PE           :1;
            volatile unsigned long int FE           :1;
            volatile unsigned long int BRK          :1;
            volatile unsigned long int ROE          :1;
            volatile unsigned long int TOE          :1;
            volatile unsigned long int TMT          :1;
            volatile unsigned long int TRDY         :1;
            volatile unsigned long int RRDY         :1;
            volatile unsigned long int E            :1;
            volatile unsigned long int NC           :1;
            volatile unsigned long int DCTS         :1;
            volatile unsigned long int CTS          :1;
            volatile unsigned long int EOP          :1;
            volatile unsigned long int NC1          :19;            
        } BITS;
        volatile unsigned long int WORD;
    }STATUS;

    union{
        struct{
            volatile unsigned long int IPE          :1;
            volatile unsigned long int IFE          :1;
            volatile unsigned long int IBRK         :1;
            volatile unsigned long int IROE         :1;
            volatile unsigned long int ITOE         :1;
            volatile unsigned long int ITMT         :1;
            volatile unsigned long int ITRDY        :1;
            volatile unsigned long int IRRDY        :1;
            volatile unsigned long int IE           :1;
            volatile unsigned long int TRBK         :1;
            volatile unsigned long int IDCTS        :1;
            volatile unsigned long int RTS          :1;
            volatile unsigned long int IEOP         :1;
            volatile unsigned long int NC           :19;            
        }BITS;
        volatile unsigned long int WORD;
    }CONTROL;

    union{
        struct{
            volatile unsigned long int BAUD_RATE_DIVISOR    :16;
            volatile unsigned long int NC                   :16;           
        }BITS;
        volatile unsigned  int WORD;
    }DIVISOR;

}UART_ST;

/*-----------------------------------------------------------------------------
 *  Peripheral declaration
 *-----------------------------------------------------------------------------*/
//set_location_assignment PIN_J6  -to LCD_CTRL[5]   lcd_ud
//set_location_assignment PIN_N11 -to LCD_CTRL[4]   lcd_out_vs
//set_location_assignment PIN_P11 -to LCD_CTRL[3]   lcd_out_hs
//set_location_assignment PIN_N12 -to LCD_CTRL[2]   lcd_out_de
//set_location_assignment PIN_N13 -to LCD_CTRL[1]   lcd_mode
//set_location_assignment PIN_L3  -to LCD_CTRL[0]   lcd_lr
#ifdef _LCD
//#define LCD_CS            ((PIO_STR *) LCD_CS_BASE)
//#define LCD_SCL           ((PIO_STR *) LCD_SCL_BASE)
//#define LCD_A0            ((PIO_STR *) LCD_A0_BASE)
//#define LCD_SI            ((PIO_STR *) LCD_SI_BASE)
#define LCD_CTRL_UD_PIN        0x20
#define LCD_CTRL_VS_PIN        0x10
#define LCD_CTRL_HS_PIN        0x8
#define LCD_CTRL_DE_PIN        0x4
#define LCD_CTRL_MODE_PIN      0x2
#define LCD_CTRL_LR_PIN        0x1

#define LCD_CTRL           ((PIO_STR *) PIO_LCD_CTRL_BASE)
#define LCD_PWM           ((PIO_STR *) PIO_LCD_PWM_BASE)
#define LCD_DCLK           ((PIO_STR *) PIO_LCD_CLK_BASE)

#defin LCD_DATA_RGB_B   ((PIO_STR *)PIO_LCD_B_BASE )
#defin LCD_DATA_RGB_G   ((PIO_STR *)PIO_LCD_G_BASE )
#defin LCD_DATA_RGB_R   ((PIO_STR *)PIO_LCD_R_BASE )

#endif /* _LCD */


#ifdef _LED
#define LED          ((PIO_STR *) PIO_LED_BASE)      
#endif /*_LED*/

#ifdef _UART
#define UART             ((UART_ST *) RS232_BASE)
#endif /*_UART */

#endif /*SOPC_H_*/

