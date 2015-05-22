#include "../inc/lcd.h"
#define LCD_PIN_CTRL(PIN,value) if(value){ LCD_CTRL->DATA = LCD_CTRL->DATA | PIN } else { LCD_CTRL->DATA = LCD_CTRL->DATA & (^PIN) };

#define LCD_DCLK_UP    LCD_DCLK->DATA=0xffffffff;
#define LCD_DCLK_DOWN  LCD_DCLK->DATA=0;
/*
 * power on sequence
 * 
 */
void lcd_power_on(void){

    
}
/*
 * power on sequence
 * 
 */
void lcd_power_off(void){
 
    
}

//#define LCD_CTRL_UD_PIN        0x20
//#define LCD_CTRL_VS_PIN        0x10
//#define LCD_CTRL_HS_PIN        0x8
//#define LCD_CTRL_DE_PIN        0x4
//#define LCD_CTRL_MODE_PIN      0x2
//#define LCD_CTRL_LR_PIN        0x1
void lcd_mode_init(void){
    //set lcd mode to de mode or hs mode .will use hs mode,need hsync and vsync
    LCD_PIN_CTRL(LCD_CTRL_MODE_PIN,0); 
    //scan left to right
    LCD_PIN_CTRL(LCD_CTRL_LR_PIN,1);  
    //scan up to down
    LCD_PIN_CTRL(LCD_CTRL_UD_PIN,0);
    //init clk start value
    LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);
    //disable data output
    LCD_PIN_CTRL(LCD_CTRL_DE_PIN,0);

}


void lcd_dlck_data_send_cycle(unsigned short *data,int mode){
        //set data ready  //will change data
    LCD_DATA_RGB_R  = 0xce;
    LCD_DATA_RGB_G  = 0xde;
    LCD_DATA_RGB_B  = 0x30;
    
    LCD_DCLK_UP ;
    DCLK_DELAY ;    //wait for data stable
    LCD_DCLK_DOWN;  //send out the lcd data to lcd control
    DCLK_DELAY ;   
}
    
void lcd_hsync_single_cycle(unsigned short *data,int hsyncNum ;int mode){
    //set data ready  //will change data
    int i = 0;
    //TW part    
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,0);
    lcd_dlck_data_send_cycle(0xff,0);
    lcd_dlck_data_send_cycle(0xff,0);
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);

    //HBP part
    lcd_dlck_data_send_cycle(0xff,0);
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);
    //HV part
    if (data == NULL)
    {
        for (i=0;i< hsyncNum;i++){
            lcd_dlck_data_send_cycle(0xff,mode);
        }
    }
    else {
        for (i=0;i< hsyncNum;i++){
            lcd_dlck_data_send_cycle(data[i],mode);
        }
    }
    //HFP part
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,0);
    lcd_dlck_data_send_cycle(0xff,0);
    lcd_dlck_data_send_cycle(0xff,0);
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);    
    
}


void lcd_scan_whole_screen(unsigned short *data,int width.int heigh,int mode){
    int i  = 0;
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);
    LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);
    DCLK_DELAY ;
    LCD_PIN_CTRL(LCD_CTRL_DE_PIN,0);//disable de
    LCD_DCLK_DOWN ;//prepare DCLK DOWN
    for (i = 0;i<LCD_VSYNC_VW ;i++){ //LCD_VSYNC_VW  ==  HSYNC CYCLES .
        
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,0);
        DCLK_DELAY ;
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);
        //LCD_CTRL_HS_PIN actions ,de not eable 
        lcd_hsync_single_cycle(0xff,0); 
        
        
    }
    LCD_DCLK_DOWN;
    //vsync tvb

    for (i = 0;i<LCD_VSYNC_VW ;i++){
        
        lcd_hsync_single_cycle(0xff,0); 
        
        
    }
    LCD_DCLK_DOWN;
    LCD_PIN_CTRL(LCD_CTRL_DE_PIN,1);  //valid DE signal ,ready for data
    for (i = 0;i<LCD_VSYNC_W ;i++){
        lcd_hsync_single_cycle(0xff,0);  //fill valid data to lcd
    }
    LCD_PIN_CTRL(LCD_CTRL_DE_PIN,0);
    for (i = 0;i<LCD_VSYNC_VFP ;i++){
        LCD_PIN_CTRL(LCD_CTRL_DE_PIN,0);//disable de
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,0);
        DCLK_DELAY ;
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);
        //LCD_CTRL_HS_PIN actions ,de not eable 
        
        
    }
    
    
}
void lcd_prepare_data(unsigned short *data),int width.int heigh,int mode{
        while(1){
            lcd_scan_whole_screen(0,800,480,0);
        }
}


