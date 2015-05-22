#include "../inc/lcd.h"

#define LCD_PIN_CTRL(PIN,value)  if(1){ \
            if(value){\
                LCD_CTRL->DATA = LCD_CTRL->DATA | ( PIN) ;\
            } \
            else { \
                LCD_CTRL->DATA = LCD_CTRL->DATA & ( ~(PIN) ) ;\
            } \
        }

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
int refresh_conter  = 0;
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


void lcd_dlck_data_send_cycle(unsigned short data,int mode){
        //set data ready  //will change data
    if (refresh_conter == 0 ){
        LCD_DATA_RGB_R->DATA  = 0xff;
        LCD_DATA_RGB_G->DATA  = 0x00;
        LCD_DATA_RGB_B->DATA  = 0x00;
    }
    if(refresh_conter %5 == 0){
    LCD_DATA_RGB_R->DATA  += 5;
    LCD_DATA_RGB_G->DATA  += 14;
    LCD_DATA_RGB_B->DATA  += 34;
    }
    
    LCD_DCLK_UP ;
    DCLK_DELAY ;    //wait for data stable
    LCD_DCLK_DOWN;  //send out the lcd data to lcd control
    DCLK_DELAY ;   
}
    
void lcd_hsync_single_cycle(unsigned short *picBuf,int hsyncNum ,int mode){
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
    if (picBuf == 0)
    {
        for (i=0;i< hsyncNum;i++){
            lcd_dlck_data_send_cycle(0xff,mode);
        }
    }
    else {
        for (i=0;i< hsyncNum;i++){
            lcd_dlck_data_send_cycle(picBuf[i],mode);
        }
    }
    //HFP part
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,0);
    lcd_dlck_data_send_cycle(0xff,0);
    lcd_dlck_data_send_cycle(0xff,0);
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);    
    
}

void lcd_set_init_signal_statue(void){
    LCD_PIN_CTRL(LCD_CTRL_HS_PIN,1);
    LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);
    DCLK_DELAY ;
    LCD_PIN_CTRL(LCD_CTRL_DE_PIN,0);//disable de
    LCD_DCLK_DOWN ;//prepare DCLK DOWN
}
void lcd_scan_whole_vsync_cycle(unsigned short *data,int width,int heigh,int mode){
    int j  = 0;

        //vsync VW part
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,0);//generate vsync start signal
        for (j = 0;j<LCD_VSYNC_VW ;j++){ //
            lcd_hsync_single_cycle(0,width,mode);             
        }
        LCD_PIN_CTRL(LCD_CTRL_VS_PIN,1);//generate vsync start signal over,begin hsync actions

        //vsync VBP part
        lcd_hsync_single_cycle(0,width,mode);

        LCD_PIN_CTRL(LCD_CTRL_DE_PIN,1);  //valid DE signal ,ready for data
        for (j = 0;j<heigh ;j++){
            lcd_hsync_single_cycle(data,width,mode); //should fill usefull data
            data+=j;
        }
        for (j = 0;j<LCD_VSYNC_VFP ;j++){
            lcd_hsync_single_cycle(0,width,mode);        
        }
    

    
    
}
void lcd_prepare_data(unsigned short *data,int width,int heigh,int mode){
    lcd_mode_init();
    lcd_set_init_signal_statue();
    
    while(1){
        
        printf("try fill screen -> %d\r\n",refresh_conter);
        lcd_scan_whole_vsync_cycle(0,480,800,0);
        refresh_conter++;
        
    }
}


