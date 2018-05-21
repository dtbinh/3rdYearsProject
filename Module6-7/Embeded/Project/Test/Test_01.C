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

#define Test_01_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "Test_01.h"

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
static void Timer1(void);
static void PWM(void);
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

static int16u duty1,duty2,duty3;
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
	for(;;)
	{

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
	
	//set EXT
	clear_interrupt(INT_EXT1);
	enable_interrupts(INT_EXT1);
	clear_interrupt(INT_EXT2);
	enable_interrupts(INT_EXT2);
	
	//enable global
	enable_interrupts(INTR_GLOBAL);
	return;
}

static void Timer1(void)
{
	clear_interrupt(INT_TIMER1);
	enable_interrupts(INT_TIMER1);
	set_timer1(0);
	setup_timer1(TMR_INTERNAL | TMR_DIV_BY_256, 31249);
}

static void PWM(void)
{
	duty1 = 7500;
	set_compare_time(1, duty1);
	setup_compare(1, COMPARE_PWM | COMPARE_TIMER3);
	set_pwm_duty(1,duty1);
	
	duty2 = 5000;
	set_compare_time(2, duty2);
	setup_compare(2, COMPARE_PWM | COMPARE_TIMER3);
	set_pwm_duty(2,duty2);

	duty3 = 2500;
	set_compare_time(3, duty3);
	setup_compare(3, COMPARE_PWM | COMPARE_TIMER3);
	set_pwm_duty(3,duty3);	

	set_timer3(0);
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_1, 9999);

	
}

#INT_EXT1
void Intr1ISR(void)
{
	Timer1();
	PWM();
}

#INT_EXT2
void Intr2ISR(void)
{
	Timer1();
	duty1 = 20000;
	duty2 = 20000;
	duty3 = 20000;
	set_pwm_duty(1,duty1);
	set_pwm_duty(2,duty2);
	set_pwm_duty(3,duty3);
	
}

#INT_TIMER1
void Tmr1ISR(void)
{
	output_toggle(LED3);
}


/****************************************************************************/

/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/