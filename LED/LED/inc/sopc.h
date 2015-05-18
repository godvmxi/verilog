/*
 * =====================================================================================
 *
 *       Filename:  sopc.h
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2009-8-6 10:09:46
 *       Revision:  
 *       Compiler:  Nios II IDE
 *
 *         Author:  
 *          Email:  avic633@gmail.com
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
#ifdef _LED
#define LED          ((PIO_STR *) PIO_LED_BASE)      
#endif /*_LED*/

#endif /*SOPC_H_*/

