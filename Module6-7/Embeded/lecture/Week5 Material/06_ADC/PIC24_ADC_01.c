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

#define PIC24_ADC_01_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "PIC24_ADC_01.H"

/****************************************************************************/
/**                                                                        **/
/**                        DEFINITIONS AND MACROS                          **/
/**                                                                        **/
/****************************************************************************/

#define ARR_LNG 4
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
static void HardwareInit (void);
static void MovingAvgInit (void);
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

static volatile MOVING_AVG_STRUCT MvgAvgStruct0, MvgAvgStruct1;
static volatile APP_DAT_TYPE BuffArray0[ARR_LNG];
static volatile APP_DAT_TYPE BuffArray1[ARR_LNG];

static volatile APP_DAT_TYPE ad0, ad1;
static volatile int16u value0, value1;
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
	disable_interrupts(INTR_GLOBAL);
	HardwareInit ();
	MovingAvgInit ();
	enable_interrupts(INTR_GLOBAL);
	for(;;)
	{
	}
	return 0;
}

static void HardwareInit (void)
{
	setup_adc_ports(NO_ANALOGS);
// ADC Channel 0,1,2,3 /////////
	setup_adc(ADC_CLOCK | ADC_CLOCK_DIV_2 | ADC_TAD_MUL_2);
	setup_adc_ports(sAN0 | sAN1);
// GPIO LED 0-3: A2, A4, B2, B3 ; SW 0-3: B4, B5, B6, B7
	set_tris_a (get_tris_a () & 0xffeb);
	set_tris_b (get_tris_b () | 0x0ff3);
	output_high(LED0);
	output_high(LED1);
	output_high(LED2);
	output_high(LED3);


// Timer3 //////
	clear_interrupt(INT_TIMER5);
	enable_interrupts(INT_TIMER5);
	set_timer3(0);
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_256, 62499);
	return;
}

static void MovingAvgInit (void)
{
	InitMvgAvg (&MvgAvgStruct0, BuffArray0, ARR_LNG);
	InitMvgAvg (&MvgAvgStruct1, BuffArray1, ARR_LNG);
	return;
}

#INT_TIMER3
void Tmr3ISR (void)
{
	set_adc_channel(0);
	value0 = read_adc();
	set_adc_channel(1);
	value1 = read_adc();
	MovingAvg (&MvgAvgStruct0, value0, &ad0);
	MovingAvg (&MvgAvgStruct1, value1, &ad1);
	printf ("<%u, %u> <%u, %u>\r\n", value0, ad0, value1, ad1);
	return;
}

/****************************************************************************/

/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/