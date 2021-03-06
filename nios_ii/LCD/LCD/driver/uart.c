/*
 * =====================================================================================
 *
 *       Filename:  uart.c
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  ���� (AVIC)
 *			Email:  avic633@gmail.com  
 *			   QQ:  984597569
 *			  URL:  http://kingst.cnblogs.com
 *
 * =====================================================================================
 */

/*--------------------------------------------------------------------------------------
 *  Include
 *-------------------------------------------------------------------------------------*/ 
#include "sys/alt_irq.h"     
#include <stdlib.h>
#include <stdio.h>
#include "../inc/uart.h"
#include "../inc/sopc.h"

/*--------------------------------------------------------------------------------------
 *  Function Prototype
 *------------------------------------------------------------------------------------*/
static int uart_send_byte(unsigned char data);
static void uart_send_string(unsigned int len, unsigned char *str);
static int uart_init(void);
static void uart_ISR(void);
static int set_baudrate(unsigned int baudrate);

/*--------------------------------------------------------------------------------------
 *  Struct initialize
 *------------------------------------------------------------------------------------*/
UART_T uart={
    .receive_flag=0,
    .receive_count=0,
    .send_byte=uart_send_byte,
    .send_string=uart_send_string,
    .init=uart_init,
    .baudrate=set_baudrate
    };

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  uart_send_byte
 *  Description:  
 * =====================================================================================
 */
int uart_send_byte(unsigned char data)
{
    UART->TXDATA.BITS.TRANSMIT_DATA = data;
    while(!UART->STATUS.BITS.TRDY);

    return 0;
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  uart_send_string
 *  Description:  
 * =====================================================================================
 */
void uart_send_string(unsigned int len, unsigned char *str)
{
    while(len--)
    {
        uart_send_byte(*str++);  
    }
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  uart_init
 *  Description:  
 * =====================================================================================
 */
int uart_init(void)
{
    set_baudrate(115200);
    
    UART->CONTROL.BITS.IRRDY=1;
    UART->STATUS.WORD=0;
    
    alt_irq_register(RS232_IRQ, NULL, uart_ISR);

    return 0;
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  uart_ISR
 *  Description:  
 * =====================================================================================
 */
static void uart_ISR(void)
{     
	while(!(UART->STATUS.BITS.RRDY));

	uart.receive_buffer[uart.receive_count++] = UART->RXDATA.BITS.RECEIVE_DATA;

	if(uart.receive_buffer[uart.receive_count-1]=='\n'){
		uart.receive_buffer[uart.receive_count]='\0';
//		uart_send_string(uart.receive_count,uart.receive_buffer);
		uart.receive_count=0;
		uart.receive_flag=1;
	}


}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  set_baudrate
 *  Description:  
 * =====================================================================================
 */
int set_baudrate(unsigned int baudrate)
{    
	UART->DIVISOR.WORD=(unsigned int)(ALT_CPU_FREQ/baudrate+0.5);

	return 0;
}

