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
#define LCD_CTRL_UD        0x20
#define LCD_CTRL_VS        0x10
#define LCD_CTRL_HS        0x8
#define LCD_CTRL_DE        0x4
#define LCD_CTRL_MODE      0x2
#define LCD_CTRL_LR        0x1

#define LCD_CTRL           ((PIO_STR *) PIO_LCD_CTRL_BASE)
#define LCD_PWM           ((PIO_STR *) PIO_LCD_PWM_BASE)
#endif /* _LCD */


#ifdef _LED
#define LED          ((PIO_STR *) PIO_LED_BASE)      
#endif /*_LED*/

#endif /*SOPC_H_*/

