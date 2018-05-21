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

----------------------------
Version      : 2
Date         : 3/11/2017
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
#define Pulse_Per_Rev 12*4*64
#define Distance_Per_Rev 78.5 //mm
#define K_P1 25
#define K_I1 0
#define K_D1 0


/****************************************************************************/
/**                                                                        **/
/**                        TYPEDEFS AND STRUCTURES                         **/
/**                                                                        **/
/****************************************************************************/

typedef enum
{
	None,
	X,
	Y,
	Z
} AXIS;

/****************************************************************************/
/**                                                                        **/
/**                      PROTOTYPES OF LOCAL FUNCTIONS                     **/
/**                                                                        **/
/****************************************************************************/

void DisableIntr (void);
void EnableIntr (void);
static void HardwareInit (void);
static void GlobalVarInit (void);
void control_PID(AXIS Axis, int32u y, int32u r, float K_P, float K_I, float K_D);
void motor_drive(AXIS Axis, ROTATION Rotate, int32s u);
int16u Position_control(AXIS Axis, int32u target);

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

static int32u SamplingCounterAX0, SamplingCounterAX1, SamplingCounterAX2, SamplingCounterAX3;
static int16u ReadPortA, ReadPortB;
static int16u AX0_Old, AX1_Old, AX2_Old, AX3_Old, AX0_New_Actual, AX1_New_Actual, 
				 AX2_New_Actual, AX3_New_Actual;
static int16u AX0_New[REPEAT_SAMPLING];
static int16u AX1_New[REPEAT_SAMPLING];
static int16u AX2_New[REPEAT_SAMPLING];
static int16u AX3_New[REPEAT_SAMPLING];
static ROTATION Rotate, RotateX, RotateY;
static AXIS Axis;
static int16u Tmr3IntrCounter = 0;
static int16u Sampling; 
static int32s PulseCounterOld1, PulseCounterNew1, PulseCounterInterval1,
				PulseCounter1;
static int32s PulseCounterOld2, PulseCounterNew2, PulseCounterInterval2,
				PulseCounter2;
static int32s u_X, e_X, delta_u_X, pu1_X, pe2_X, pe1_X,
				u_Y, e_Y, delta_u_Y, pu1_Y, pe2_Y, pe1_Y;
static int32u r; //desire position
static int16u duty_X, duty_Y;
static int8u state=0;

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
		switch(state)
		{
			case 0: Position_control(X,100); break;//Position_control(Y,100); break;
			case 1: Position_control(X,0); break;//Position_control(Y,100); break;
			//case 2: Position_control(X,50); Position_control(Y,0); break;
			//case 3: Position_control(X,0); Position_control(Y,0); break;
		}		
		if(abs(e_X)<5 && abs(e_Y)<5 )	{state++; state%=2;}
	}
}

int16u Position_control(AXIS Axis, int32u target ) //target (mm)
{	
	int32s PulseCounter;
	r = target*Pulse_Per_Rev/Distance_Per_Rev;
	switch(Axis){
		case X:
			PulseCounter = PulseCounter1;
			break;
		case Y:
			PulseCounter = PulseCounter2 ;
			break;
	}
	control_PID(Axis, PulseCounter, r, K_P1, K_I1, K_D1);
	return 0;
}

void control_PID(AXIS Axis, int32u y, int32u r, float K_P, float K_I, float K_D)
{
	switch(Axis){
		case X:
			e_X = r-y;
			delta_u_X = (K_P+K_I+K_D)*e_X-(K_P+2*K_D)*pe1_X+(K_D)*pe2_X;
			u_X = pu1_X+delta_u_X;
			
			if ( u_X >= 0 ) motor_drive(Axis, CW, u_X);
			else 			motor_drive(Axis, CCW, abs(u_X));
			pu1_X = u_X;
			pe2_X = pe1_X;
			pe1_X = e_X;			
			break;
		case Y:
			e_Y = r-y;
			delta_u_Y = (K_P+K_I+K_D)*e_Y-(K_P+2*K_D)*pe1_Y+(K_D)*pe2_Y;
			u_Y = pu1_Y+delta_u_Y;
		
			if ( u_Y >= 0 ) motor_drive(Axis, CW, u_Y);
			else 			motor_drive(Axis, CCW, abs(u_Y));
			pu1_X = u_Y;
			pe2_X = pe1_Y;
			pe1_X = e_Y;
			break;
	}

}
			
void motor_drive(AXIS Axis, ROTATION Rotate, int32s u)
{
	if( u < 0) 		u=0;
	if( u > 1000 )  u=1000;
	switch(Axis){ 
		case X: 
			duty_X = u;
			switch(Rotate){ 
				case CCW: 
					output_high(INA_X);
					output_low(INB_X);
					break; 
				case CW: 
					output_low(INA_X);
					output_high(INB_X);
					break; 
				case STOP:
					duty_X = 0;
					break;
			}
			set_pwm_duty(1, duty_X);			
			break;
		case Y:
			duty_Y = u;
			switch(Rotate){				
				case CCW:
					output_high(INA_Y);
					output_low(INB_Y);
					break;
				case CW:
					output_low(INA_Y);
					output_high(INB_Y);
					break;
				case STOP:
					duty_Y = 0;
					break;
			}
			set_pwm_duty(2, duty_Y);
			break;
		case Z:
			switch(Rotate){
				case CCW:
					break;
				case CW:
					break;
			}
			break;
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
	//interface
	Sampling = 0;
	Tmr3IntrCounter = 0;
	//encoder
	SamplingCounterAX0 = 0;
	SamplingCounterAX1 = 0;
	SamplingCounterAX2 = 0;
	SamplingCounterAX3 = 0;
	RotateX = STOP;
	RotateY = STOP;
	PulseCounter1 = 0;
	PulseCounterOld1 = 0;
	PulseCounter2 = 0;
	PulseCounterOld2 = 0;
	//PID
	Axis = None;
	pu1_X = 0;
	pe1_X = 0;
	pe2_X = 0;
	pu1_Y = 0;
	pe1_Y = 0;
	pe2_Y = 0;
	//motor drive
	duty_X = 0;
	duty_Y = 0;
	return;
}

static void HardwareInit(void)
{
	setup_adc_ports(NO_ANALOGS);
	set_tris_a(get_tris_a() & 0xff17); // 1111 1111 0010 0011
	set_tris_b(get_tris_b() & 0xff0f); // 1111 1111 0000 1111
	ReadPortA = input_a() & 0x0014;
	ReadPortB = input_b() & 0x000C;
	AX0_Old = (ReadPortA & 0x0004) >> 2;
	AX1_Old = (ReadPortA & 0x0010) >> 4;
	AX2_Old = (ReadPortB & 0x0004) >> 2;
	AX3_Old = (ReadPortB & 0x0008) >> 3;
	//Timer4
	set_timer4(0);
	setup_timer4(TMR_INTERNAL | TMR_DIV_BY_1, 499); //sampling xxx us for X
	clear_interrupt(INT_TIMER4);
	enable_interrupts(INT_TIMER4);
	//Timer5
	set_timer5(0);
	setup_timer5(TMR_INTERNAL | TMR_DIV_BY_1, 499); //sampling xxx us for Y
	clear_interrupt(INT_TIMER5);
	enable_interrupts(INT_TIMER5);
	//Timer3
	set_timer3(0);
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_256, 31249); //0.5 sec
	clear_interrupt(INT_TIMER3);
	enable_interrupts(INT_TIMER3);	
	//OC1 with timer 2
	set_compare_time(1, duty_X, duty_X);
	setup_compare(1, COMPARE_PWM | COMPARE_TIMER2);
	//OC2 with timer 2
	set_compare_time(2, duty_Y, duty_Y);
	setup_compare(2, COMPARE_PWM | COMPARE_TIMER2);
	//set_timer2
	set_timer2(0);
	setup_timer2(TMR_INTERNAL | TMR_DIV_BY_1, 999);	
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
	ReadPortA = input_a() & 0x0014;
	//AX0
	AX0_New[SamplingCounterAX0] = (ReadPortA & 0x0004) >> 2;
	if((AX0_New[0] == AX0_New[1]) && (AX0_New[1] == AX0_New[2]))
	{
		AX0_New_Actual = AX0_New[SamplingCounterAX0];
		if(AX0_New_Actual != AX0_Old)
		{
			AX0_Old = AX0_New_Actual;
			Sampling = 1;
			if((AX0_Old ^ AX1_Old) == 0)
			{
				PulseCounter1++;
				RotateX = CW;
			}
			else
			{
				PulseCounter1--;
				RotateX = CCW;
			}
		}
	}
	SamplingCounterAX0++;
	if(SamplingCounterAX0 == REPEAT_SAMPLING)
	{
		SamplingCounterAX0 = 0;
	}
	//AX1
	AX1_New[SamplingCounterAX1] = (ReadPortA & 0x0010) >> 4;
	if((AX1_New[0] == AX1_New[1]) && (AX1_New[1] == AX1_New[2]))
	{
		AX1_New_Actual = AX1_New[SamplingCounterAX1];
		if(AX1_New_Actual != AX1_Old)
		{
			AX1_Old = AX1_New_Actual;
			Sampling = 1;
			if((AX0_Old ^ AX1_Old) == 0)
			{
				PulseCounter1--;
				RotateX = CCW;
			}
			else
			{
				PulseCounter1++;
				RotateX = CW;
			}
		}
	}
	SamplingCounterAX1++;
	if(SamplingCounterAX1 == REPEAT_SAMPLING)
	{
		SamplingCounterAX1 = 0;
	}
}

#INT_TIMER5
static void Timer5ISR(void)
{
	ReadPortB = input_b() & 0x000C;
	//AX2
	AX2_New[SamplingCounterAX2] = (ReadPortB & 0x0004) >> 2;
	if((AX2_New[0] == AX2_New[1]) && (AX2_New[1] == AX2_New[2]))
	{
		AX2_New_Actual = AX2_New[SamplingCounterAX0];
		if(AX2_New_Actual != AX2_Old)
		{
			AX2_Old = AX2_New_Actual;
			Sampling = 1;
			if((AX2_Old ^ AX3_Old) == 0)
			{
				PulseCounter2++;
				RotateY = CW;
			}
			else
			{
				PulseCounter2--;
				RotateY = CCW;
			}
		}
	}
	SamplingCounterAX2++;
	if(SamplingCounterAX2 == REPEAT_SAMPLING)
	{
		SamplingCounterAX2 = 0;
	}
	//AX3
	AX3_New[SamplingCounterAX3] = (ReadPortB & 0x0008) >> 3;
	if((AX3_New[0] == AX3_New[1]) && (AX3_New[1] == AX3_New[2]))
	{
		AX3_New_Actual = AX3_New[SamplingCounterAX3];
		if(AX3_New_Actual != AX3_Old)
		{
			AX3_Old = AX3_New_Actual;
			Sampling = 1;
			if((AX2_Old ^ AX3_Old) == 0)
			{
				PulseCounter2--;
				RotateY = CCW;
			}
			else
			{
				PulseCounter2++;
				RotateY = CW;
			}
		}
	}
	SamplingCounterAX3++;
	if(SamplingCounterAX3 == REPEAT_SAMPLING)
	{
		SamplingCounterAX3 = 0;
	}
}

#INT_Timer3
static void Timer3ISR(void)
{
	Tmr3IntrCounter++;
	//Axis1
	PulseCounterNew1 = PulseCounter1;
	PulseCounterInterval1 = PulseCounterNew1 - PulseCounterOld1;
	PulseCounterOld1 = PulseCounterNew1;
	//Axis2000200
	PulseCounterNew2 = PulseCounter2;
	PulseCounterInterval2 = PulseCounterNew2 - PulseCounterOld2;
	PulseCounterOld2 = PulseCounterNew2;
	printf("e: %d, u: %d ,Pulse: %d\r\n",e_X,u_X,PulseCounter1);
	return;
}
/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/