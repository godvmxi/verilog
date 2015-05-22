/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "../inc/sopc.h"
#include "../inc/uart.h"


void receive(void){
    unsigned char buffer[50] = {0};
    if(uart.receive_flag){
            memset(buffer,0,50);// clear buffer

            strcpy(buffer,uart.receive_buffer);//copy uart.receive_buffer to buffer

            uart.receive_flag = 0;//clear flags
        }
        uart.send_string(sizeof(buffer),buffer);
        
}

void syslog(unsigned char buf[]){
    uart.send_string(strlen(buf),buf);     
    uart.send_string(2,"\r\n");   
}
int main()
{
    int i = 0 ;

    uart.init();
    printf("Hello from Nios II!\n");
  
    while(1){
        for(i=0;i<4;i++){
            LED->DATA = 1 << i;
            usleep(500000);
        }
        //uart.send_string(sizeof(buffer),buffer);
        syslog("-->on");
        LCD_PWM->DATA = 1;
        lcd_prepare_data();
       
       
        for(i=0;i<4;i++){
            LED->DATA = 1 << i;
            usleep(500000);
        }
        //uart.send_string(sizeof(buffer),buffer);
        syslog("-->off");
        LCD_PWM->DATA = 0;
    }

    return 0;
}
