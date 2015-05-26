/*
 * =======================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  ���� (AVIC)
 *          Email:  avic633@gmail.com  
 *             QQ:  984597569
 *
 * ======================================================================
 */

/*-----------------------------------------------------------------------
 * Include 
 *---------------------------------------------------------------------*/
#include "../inc/sopc.h"
#include <unistd.h>
#include <stdio.h>

/* 
 * ===  FUNCTION  ========================================================
 *         Name:  main
 *  Description:  
 * =======================================================================
 */
int main(void)
{
    int i; 
    
    while(1){
        for(i=0;i<4;i++){
            LED->DATA = 1 << i;            
            usleep(100000);
        }
        printf("led change\n");
    }

    return 0;
}
