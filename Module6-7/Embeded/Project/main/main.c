/*
*************************** C SOURCE FILE ************************************

project   :
filename  : QuadEncoder.C
version   : 1
date      :

******************************************************************************

Copyright (c) 20xx
All rights reserved.

******************************************************************************

VERSION HISTORY:
----------------------------
Version      : 1
Date         : 1/11/2017
Revised by   : 
Description  :

******************************************************************************
*/

#define QuadEncoder_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "QuadEncoder.h"

/****************************************************************************/
/**                                                                        **/
/**                        DEFINITIONS AND MACROS                          **/
/**                                                                        **/
/****************************************************************************/

#define TMR_CLCK_FREQ 16000000
#define Pulse_Per_Rev 12
#define Distance_Per_Rev 78.5

/****************************************************************************/
/**                                                                        **/
/**                        TYPEDEFS AND STRUCTURES                         **/
/**                                                                        **/
/****************************************************************************/

typedef enum
{
	STOP,
	CCW,
	CW
} ROTATION;

struct Axis Axis_X;
struct Axis Axis_Y;

/****************************************************************************/
/**                                                                        **/
/**                      PROTOTYPES OF LOCAL FUNCTIONS                     **/
/**                                                                        **/
/****************************************************************************/

void DisableIntr (void);
void EnableIntr (void);
static void HardwareInit (void);
static void GlobalVarInit (void);

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

static int16u ReadPortA;
static ROTATION Rotate_X, Rotate_Y;
static int16u Tmr3IntrCounter = 0;
static int16u PrintOn; 

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

void main(void)
{
	DisableIntr();
	GlobalVarInit();
	HardwareInit();
	EnableIntr();
	for(;;)
	{
		if(Tmr3IntrCounter != 0)
		{
			Tmr3IntrCounter--;
			if (PrintOn == 1)
			{
				PrintOn = 0;
			
				Axis_X.Rev = Axis_X.PulseCounterInterval/Pulse_Per_Rev;
				if (Rotate_X == CW)
				{
					Axis_X.Distance -= (Axis_X.Rev*Distance_Per_Rev);
				} 
				else 
				{
					Axis_X.Distance += (Axis_X.Rev*Distance_Per_Rev);
				}
				
				printf("AxisX %d \r\n",(int16s)Axis_X.Distance);
			
			}
		}
	}
}
			
void DisableIntr(void)
{
	disable_interrupts(INTR_GLOBAL);
}			

void EnableIntr(void)
{
	enable_interrupts(INTR_GLOBAL);
}

static void GlobalVarInit(void)
{
	PrintOn = 0;

	Axis_X.SamplingCounterENA = 0;
	Axis_X.SamplingCounterENB = 0;
	
	Rotate_X = STOP;

	Axis_X.Rev = 0;

	Axis_X.Distance = 0;

	Axis_X.PulseCounter = 0;
	Axis_X.PulseCounterOld = 0;

	Tmr3IntrCounter = 0;
	return;
}

static void HardwareInit(void)
{
	setup_adc_ports(NO_ANALOGS);
	set_tris_a(get_tris_a() & 0xffff);
	set_tris_b(get_tris_b() & 0xfff3);
	ReadPortA = input_a() & 0x000f;
	Axis_X.ENA_Old = ReadPortA & 0x0001;
	Axis_X.ENB_Old = (ReadPortA & 0x0002) >> 1;

	//Timer4
	set_timer4(0);
	setup_timer4(TMR_INTERNAL | TMR_DIV_BY_1, 1599); //sampling 100us
	clear_interrupt(INT_TIMER4);
	enable_interrupts(INT_TIMER4);
	//Timer5
	set_timer5(0);
	setup_timer5(TMR_INTERNAL | TMR_DIV_BY_1, 1599); //sampling 100us
	clear_interrupt(INT_TIMER5);
	enable_interrupts(INT_TIMER5);
	//Timer3
	set_timer3(0);
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_256, 62499); //1 sec
	clear_interrupt(INT_TIMER3);
	enable_interrupts(INT_TIMER3);	
	return;
}

/****************************************************************************/
/**                                                                        **/
/**                          Interupt FUNCTIONS                            **/
/**                                                                        **/
/****************************************************************************/

#INT_TIMER4
static void Timer4ISR(void)
{
	ReadPortA = input_a() & 0x000f;
	//ENA
	Axis_X.ENA_New[Axis_X.SamplingCounterENA] = ReadPortA & 0x0001;
	if((Axis_X.ENA_New[0] == Axis_X.ENA_New[1]) && (Axis_X.ENA_New[1] == Axis_X.ENA_New[2]))
	{
		Axis_X.ENA_New_Actual = Axis_X.ENA_New[Axis_X.SamplingCounterENA];
		if(Axis_X.ENA_New_Actual != Axis_X.ENA_Old)
		{
			Axis_X.PulseCounter++;
			Axis_X.ENA_Old = Axis_X.ENA_New_Actual;
			PrintOn = 1;
			if((Axis_X.ENA_Old ^ Axis_X.ENB_Old) == 0)
			{
				Rotate_X = CCW;
			}
			else
			{
				Rotate_X = CW;
			}
		}
	}
	Axis_X.SamplingCounterENA++;
	if(Axis_X.SamplingCounterENA == REPEAT_SAMPLING)
	{
		Axis_X.SamplingCounterENA = 0;
	}
	//ENB
	Axis_X.ENB_New[Axis_X.SamplingCounterENB] = ReadPortA & 0x0001;
	if((Axis_X.ENB_New[0] == Axis_X.ENB_New[1]) && (Axis_X.ENB_New[1] == Axis_X.ENB_New[2]))
	{
		Axis_X.ENB_New_Actual = Axis_X.ENB_New[Axis_X.SamplingCounterENB];
		if(Axis_X.ENB_New_Actual != Axis_X.ENB_Old)
		{
			Axis_X.PulseCounter++;
			Axis_X.ENB_Old = Axis_X.ENB_New_Actual;
			PrintOn = 1;
			if((Axis_X.ENA_Old ^ Axis_X.ENB_Old) == 0)
			{
				Rotate_X = CW;
			}
			else
			{
				Rotate_X = CCW;
			}
		}
	}
	Axis_X.SamplingCounterENB++;
	if(Axis_X.SamplingCounterENB == REPEAT_SAMPLING)
	{
		Axis_X.SamplingCounterENB = 0;
	}
}

/*#INT_TIMER5
static void Timer5ISR(void)
{
	ReadPortA = input_a() & 0x000f;
	//AX2
	AX2_New[SamplingCounterAX2] = (ReadPortA & 0x0004) >> 2;
	if((AX2_New[0] == AX2_New[1]) && (AX2_New[1] == AX2_New[2]))
	{
		AX2_New_Actual = AX2_New[SamplingCounterAX0];
		if(AX2_New_Actual != AX2_Old)
		{
			PulseCounter2++;
			AX2_Old = AX2_New_Actual;
			PrintOn = 1;
			if((AX2_Old ^ AX3_Old) == 0)
			{
				Rotate2 = CCW;
			}
			else
			{
				Rotate2 = CW;
			}
		}
	}
	SamplingCounterAX2++;
	if(SamplingCounterAX2 == REPEAT_SAMPLING)
	{
		SamplingCounterAX2 = 0;
	}
	//AX3
	AX3_New[SamplingCounterAX3] = (ReadPortA & 0x0008) >> 3;
	if((AX3_New[0] == AX3_New[1]) && (AX3_New[1] == AX3_New[2]))
	{
		AX3_New_Actual = AX3_New[SamplingCounterAX3];
		if(AX3_New_Actual != AX3_Old)
		{
			PulseCounter2++;
			AX3_Old = AX3_New_Actual;
			PrintOn = 1;
			if((AX2_Old ^ AX3_Old) == 0)
			{
				Rotate2 = CW;
			}
			else
			{
				Rotate2 = CCW;
			}
		}
	}
	SamplingCounterAX3++;
	if(SamplingCounterAX3 == REPEAT_SAMPLING)
	{
		SamplingCounterAX3 = 0;
	}
}*/

#INT_Timer3
static void Timer3ISR(void)
{
	Tmr3IntrCounter++;
	//Axis1
	Axis_X.PulseCounterNew = Axis_X.PulseCounter;
	Axis_X.PulseCounterInterval = Axis_X.PulseCounterNew - Axis_X.PulseCounterOld;
	Axis_X.PulseCounterOld = Axis_X.PulseCounterNew;
	/*//Axis2
	PulseCounterNew2 = PulseCounter2;
	PulseCounterInterval2 = PulseCounterNew2 - PulseCounterOld2;
	PulseCounterOld2 = PulseCounterNew2;*/
	return;
}
/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/
/*