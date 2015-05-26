#include "../inc/sopc.h"
#ifndef LCD_H_
#define LCD_H_

#define LCD_WIDTH   800
#define LCD_HEIGHT  480

#define LCD_VSYNC_VW    2
#define LCD_VSYNC_VBP   4
#define LCD_VSYNC_W     LCD_WIDTH 
#define LCD_VSYNC_VFP   4

#define LCD_HSYNC_VBP
#define LCD_HSYNC_VBP
#define LCD_HSYNC_VBP
#define LCD_HSYNC_VBP


#define TVW_DELAY    //include 2 HSYNC cycles
#define THK_DELAY    usleep(1)  //1.5DCLK

#define DCLK_DELAY   usleep(10)



#endif /*LCD_H_*/
