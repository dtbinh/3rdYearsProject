#include "System.h"
#include "BL_Support.h"
#include <stdio.h>
#include <stdlib.h>


unsigned int t1_ticks = 0;
BOOLEAN  t1_isr_flag = FALSE;

#INT_TIMER1
void TIMER1_ISR(void) {
    t1_ticks++;
    t1_isr_flag = TRUE;
}


void main(void) {
    unsigned int counter = 0;
    disable_interrupts(GLOBAL);
    setup_timer1(TMR_INTERNAL |TMR_DIV_BY_8, 2000);
    enable_interrupts(INT_TIMER1);
    enable_interrupts(GLOBAL);
    
    printf("System Ready!\r\n");
    
    while(TRUE) {
        
        output_toggle(PIN_A2);
        output_toggle(PIN_A4);
        output_toggle(PIN_B2);
        output_toggle(PIN_B3);
        
        unsigned int t1 = t1_ticks;
        printf("%d : %d\r\n", counter++, t1);
        delay_ms(200);
    }
}
