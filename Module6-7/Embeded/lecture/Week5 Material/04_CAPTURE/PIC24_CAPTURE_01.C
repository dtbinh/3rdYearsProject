/*
*************************** C SOURCE FILE ************************************

project   :
filename  : DEMO_LIB.C
version   : 2
date      :

******************************************************************************

Copyright (c) 20xx
All rights reserved.

******************************************************************************

VERSION HISTORY:
----------------------------
Version      : 1
Date         :
Revised by   :
Description  :

Version      : 2
Date         :
Revised by   :
Description  : *
               *
               *

******************************************************************************
*/

#define PIC24_CAPTURE_01_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "PIC24_CAPTURE_01.h"

/****************************************************************************/
/**                                                                        **/
/**                        DEFINITIONS AND MACROS                          **/
/**                                                                        **/
/****************************************************************************/


/****************************************************************************/
/**                                                                        **/
/**                        TYPEDEFS AND STRUCTURES                         **/
/**                                                                        **/
/****************************************************************************/


/****************************************************************************/
/**                                                                        **/
/**                      PROTOTYPES OF LOCAL FUNCTIONS                     **/
/**                                                                        **/
/****************************************************************************/

static void HardwareInit(void);
/****************************************************************************/
/**                                                                        **/
/**                           EXPORTED VARIABLES                           **/
/**                                                                        **/
/****************************************************************************/


/****************************************************************************/
/**                                                                        **/
/**                            GLOBAL VARIABLES                            **/
/**                                                                        **/
/****************************************************************************/

static volatile int16u NewCap, OldCap, Interval;
static volatile int16u T5Count;

/****************************************************************************/
/**                                                                        **/
/**                           EXPORTED FUNCTIONS                           **/
/**                                                                        **/
/****************************************************************************/


/****************************************************************************/
/**                                                                        **/
/**                             LOCAL FUNCTIONS                            **/
/**                                                                        **/
/****************************************************************************/

int main(void)
{
	disable_interrupts(INTR_GLOBAL);
	HardwareInit();
	enable_interrupts(INTR_GLOBAL);
	for(;;)
	{
		if(T5Count != 0)
		{
			T5Count--;
			printf("Interval Clock = %u\r\n", Interval);
		}
	}
	return 0;
}

static void HardwareInit(void)
{
	setup_adc_ports(NO_ANALOGS);
	set_tris_a(get_tris_a() & 0xffeb);
	set_tris_b(get_tris_b() & 0xfff3);
	output_high(LED0);
	output_high(LED1);
	output_high(LED2);
	output_high(LED3);

//  IC 1 with timer2
	
	OldCap = 0;
	setup_capture(2, CAPTURE_RE | INTERRUPT_EVERY_CAPTURE | CAPTURE_TIMER2);
	clear_interrupt(INT_IC2);
	enable_interrupts(INT_IC2);

	set_timer2(0);
	setup_timer2(TMR_INTERNAL | TMR_DIV_BY_1, 65535);
	
// Timer 5
	T5Count = 0;
	set_timer5(0);
	setup_timer5(TMR_INTERNAL | TMR_DIV_BY_256, 62499); 
	clear_interrupt(INT_TIMER5);
	enable_interrupts(INT_TIMER5);
	
	return;
}

#INT_IC2
void IC2ISR(void)
{
	NewCap = get_capture(2);
	Interval = NewCap - OldCap;
	OldCap = NewCap;
}

#INT_TIMER5
void Tmr5ISR(void)
{
	T5Count++;
	return;
}
/****************************************************************************/

/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/