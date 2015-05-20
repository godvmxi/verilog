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
//#define _LCD
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

#ifdef _LCD
#define LCD_CS            ((PIO_STR *) LCD_CS_BASE)
#define LCD_SCL           ((PIO_STR *) LCD_SCL_BASE)
#define LCD_A0            ((PIO_STR *) LCD_A0_BASE)
#define LCD_SI            ((PIO_STR *) LCD_SI_BASE)
#endif /* _LCD */


#ifdef _LED
#define LED          ((PIO_STR *) PIO_LED_BASE)      
#endif /*_LED*/

#endif /*SOPC_H_*/

