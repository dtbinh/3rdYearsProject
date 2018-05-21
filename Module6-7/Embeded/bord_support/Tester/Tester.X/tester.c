/* 
 * File:    tester.c
 * Author:  Dr.Santi Nuratch
 *          Embedded Intelligence Lab., INC-KMUTT
 * Created on 22 September 2016, 13:14
 */


#include "System.h"
#include "BL_Support.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/******************************************************************************/
/*                             GLOBAL VARIABLES                               */
/******************************************************************************/
unsigned int t1_ticks   = 0;
unsigned int u1_isr_cnt = 0;
BOOLEAN  t1_isr_flag = FALSE;
BOOLEAN  u1_isr_flag = TRUE;
/******************************************************************************/
/*                            BOARD INITIALIZATION                            */
/******************************************************************************/
void System_Init(void) {

    /* LED<1:0>     */
    // LED0 -- RA2
    // LED1 -- RA4
    int tris_a = get_tris_a();
    set_tris_a(tris_a&0xFFEB);  // 1111 1111 1110 1011 : Set A2 and A4 to output
    
    int port_a = input_a();
    output_a(port_a&0xFFEB);    // 1111 1111 1110 1011 : Turn ON the LED0 and LED1
    
    /* LED<3:2>     */
    // LED2 -- RB2
    // LED3 -- RB3
    int tris_b = get_tris_b();
    set_tris_b(tris_b&=0xFFF3);  // 1111 1111 1111 0011 : Set B2 and B3 to output
    
    int port_b = input_b();
    output_b(port_b&=0xFFF3);    // 1111 1111 1111 0011 : Turn ON the LED2 and LED3
    
    // Buzzer is connected to RB11
    set_tris_b(tris_b&=0xF7FF);  // 1111 0111 1111 1111 : Set B11 output
    output_b(port_b&=0xF7FF);    // 1111 0111 1111 1111 : Turn of the buzzer driver (a transistor)
    
    delay_ms(500);              // Wait 0.5 seconds to see the LEDs
    
    // Turn the LEDs OFF
    output_a(port_a|=0x0014);    // 0000 0000 0001 0100 : Turn OFF the LED0 and LED1
    output_b(port_b|=0x000C);    // 0000 0000 0000 1100 : Turn OFF the LED2 and LED3
    
    
    /* SW<3:0>  */
    // SW<3:0> are connected to RB<7:4>
    set_tris_b(tris_b|=0x00F0);  // 0000 0000 1111 0000 : Set RB<7:4> to input pins  

    
    /* ADC<3:0> are connected to AN<3:0> */
    /* AN0 -- RA0 -- POT0
     * AN1 -- RA1 -- POT1 -- LDR
     * AN2 -- RB0 -- POT2
     * AN3 -- RB3 -- POT3
     */
    setup_adc_ports(sAN0 | sAN1 | sAN2 | sAN3 );    
    setup_adc(ADC_CLOCK_INTERNAL | ADC_CLOCK_DIV_2); 
    set_adc_channel(0);

    
    /* Setup timer1 to interrupt every 1mS */
    /* 16MHz/8/2000 = 1kHz */
    setup_timer1(TMR_INTERNAL |TMR_DIV_BY_8, 2000);
    enable_interrupts(INT_TIMER1);
    
    
    /* Setup UART and Enable its RxD interrupt */
    clear_interrupt(INT_RDA); 
    enable_interrupts(INT_RDA);
    
    
    /* Print a message to the default UART (UART1 in this case) */
    printf("\r\nTester Ready!\r\n");
    
    /* Beep sound */
    Beep();
}



#INT_TIMER1
void TIMER1_ISR(void) {
    t1_ticks++;
    t1_isr_flag = TRUE;
    Beep_Service();
    Switch_Service();
    ADC_Service();
}

unsigned int System_GetTicks(void){
    disable_interrupts(INT_TIMER1);
    unsigned int tt = t1_ticks; 
    enable_interrupts(INT_TIMER1);
    return tt;
}


#define U1_BUFF_LENGTH 64
unsigned int u1_buff_put = 0;
unsigned int u1_buff_get = 0;
unsigned int u1_buff_cnt = 0;
char u1_buffer[U1_BUFF_LENGTH];

#INT_RDA 
void UART1_Isr() { 
    char c = getc();
    u1_isr_flag = TRUE;
    u1_buffer[u1_buff_put++] = c;
    u1_buff_put = (u1_buff_put>=U1_BUFF_LENGTH)?0:u1_buff_put;
    u1_buff_cnt++;
    u1_isr_cnt++;
}

char U1QPut(char c) {
    if(u1_buff_cnt >= U1_BUFF_LENGTH)
        return 0;
    u1_buffer[u1_buff_put++] = c;
    u1_buff_put = (u1_buff_put>=U1_BUFF_LENGTH)?0:u1_buff_put;  
    u1_buff_cnt++;
    return c;
}

char U1QGet(void) {
    char c = 0;
    if(u1_buff_cnt <= 0)
        return 0;
    c = u1_buffer[u1_buff_get++];
    u1_buff_get = (u1_buff_get>=U1_BUFF_LENGTH)?0:u1_buff_get;  
    u1_buff_cnt--;
    return c;
}


// :dddd\r\n
#define FRAME_LENGHT 16
char buffer_receive [FRAME_LENGHT];
unsigned char buffer_index = 0;
char buffer_output [FRAME_LENGHT];
BOOLEAN frame_received_flag = FALSE;
void Data_Processing(char c) {
    static unsigned char state = 0;
    switch(state) {
        case 0:
            if(c == ':') {
                buffer_index = 0;
                state++;
            }
            break;
        case 1:
            if(c == '\r') state++;
            else {
                if(buffer_index < FRAME_LENGHT)
                    buffer_receive[buffer_index++] = c;
            }
            break;
        case 2:
            if(c == '\n'){
                buffer_receive[buffer_index++] = 0;
                for(int i=0; i<buffer_index; i++) {
                    buffer_output[i] = buffer_receive[i];
                }
                frame_received_flag = TRUE;
                buffer_index = 0;
            }
            else{
                state = 0;
            }
            state = 0;
            break;
    }
    
}



void main(void) {

    /* Temporal variables */
    unsigned int counter = 0;
    unsigned int cnt=0, d_cnt = 0;
    unsigned int s_ticks, e_ticks;
    int adc0, adc1, adc2, adc3;
    
    /* Disable global interrupt */
    disable_interrupts(GLOBAL);
    
    /* Initialise all IOs */
    System_Init();

    /* Enable global interrupt */
    enable_interrupts(GLOBAL);

    while(TRUE) {
        
        if(t1_isr_flag==TRUE){      // 1mS
            t1_isr_flag = FALSE;
            counter++;
            
            if(counter%100 == 0){   // 100mS
                LED_Write(cnt);
                cnt++;
            }
            
            if(counter%200 == 0){     // 200mS
                counter = 0;
                DI_TMR1();
                s_ticks = t1_ticks;
                EI_TMR1();
                adc0 = ADC_Read(0);
                adc1 = ADC_Read(1);
                adc2 = ADC_Read(2);
                adc3 = ADC_Read(3);
                printf(":%4d,%4d,%4d,%4d\r\n", adc0, adc1, adc2, adc3); 
                
                DI_TMR1();
                e_ticks = t1_ticks;
                EI_TMR1();
                //printf("Processing time = %u ticks\r\n" e_ticks-s_ticks);
            } 
            
            if(PSW_Check()) {
                int tone[]={80, 85, 90, 95};
                int id =  PSW_GetId();
                if(id != 0xFF){
                    Beep_SetTone(tone[id]);
                    Beep();
                    printf("SW:%d\r\n", id);
                }
            }
            
            DI_RXD1();
            d_cnt = u1_buff_cnt;
            EI_RXD1();
            if(d_cnt > 0) {
                char c = U1QGet();
                printf("Received: %c\r\n", c);
                Beep_SetTone(90);
                Beep();
                
                Data_Processing(c);
            }
            
            if(frame_received_flag){
                frame_received_flag = FALSE;
                
                int value = atoi(buffer_output);
                printf("Value= %u\r\n", value);
            }
        }  
    }
}

