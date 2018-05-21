/*
*************************** C SOURCE FILE ************************************

project   :
filename  : CTEMPLATE.C
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

#define PIC24_FREQ_COUNTER_01_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "PIC24_FREQ_COUNTER_01.h"

/****************************************************************************/
/**                                                                        **/
/**                        DEFINITIONS AND MACROS                          **/
/**                                                                        **/
/****************************************************************************/

#define CCR1N 16000

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

static volatile int16u ccr1;
static volatile int16u OldCount, NewCount, DiffCount;
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

int main (void)
{
	int16u sw;
	disable_interrupts(INTR_GLOBAL);
	HardwareInit();
	enable_interrupts(INTR_GLOBAL);
	for(;;)
	{
		if(T5Count!= 0)
		{
			printf("Freq = %u KHz\r\n",DiffCount);
			T5Count--;
		}
	}
	return(0);
}

static void HardwareInit(void)
{
	setup_adc_ports(NO_ANALOGS);
	set_tris_a(get_tris_a() &  0xffeb);
	set_tris_b(get_tris_b() &  0xfff3);
	output_high(LED0);
	output_high(LED1);
	output_high(LED2);
	output_high(LED3);
	
	T5Count = 0;
	OldCount = 0;
	ccr1 = CCR1N;

	set_timer3(0);
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_1, 65535);

	set_compare_time(1,ccr1);
	setup_compare(1, COMPARE_TOGGEL | COMPARE_TIMER2);
	clear_interrupt(INT_OC1);
	enable_interrupts(INT_OC1);

	set_timer2(0);
	setup_timer2(TMR_INTERNAL | TMR_DIV_BY_1, 65535);

	set_timer5(0);
	setup_timer5(TMR_INTERNAL | TMR_DIV_BY_256, 62499);
	enable_interrupts(INT_TIMER5);

	return;
}

#INT_OC1
void OC1ISR(void)
{
	NewCount = get_timer3 ();
	ccr1 = ccr1 + CCR1N;
	DiffCount = NewCount - OldCount;
	OldCount = NewCount;
	return;
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