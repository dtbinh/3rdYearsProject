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
#define Pulse_Per_Rev 12*4*66
#define Distance_Per_Rev 78.5 //mm
#define Average_NUM 3
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
void control_PID(AXIS Axis, int32u y, int32u r, struct PIDparameter *par);
void motor_drive(AXIS Axis, ROTATION Rotate, int32s u);
int16u Position_control(AXIS Axis, int32u target);
int32u Moving_Average(int32u u, int8u num, int8u scale);

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


static int16u ReadPortA, ReadPortB;

static ROTATION Rotate, RotateX, RotateY;
static AXIS Axis;
static int16u Tmr3IntrCounter = 0;
static int16u Sampling; 
static int32u r; //desire position
static int16u duty_X, duty_Y;
static int8u state,index = 0;
static int32u average_u;
static int32u Array_u[Average_NUM] = {0};

struct PIDparameter PIDparameter_X, PIDparameter_Y;
struct EncoderParameter EN_X, EN_Y;

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


		//Position_control(X,100);
	}
}

int16u Position_control(AXIS Axis, int32u target ) //target (mm)
{	
	int32s PulseCounter;
	r = target*Pulse_Per_Rev/Distance_Per_Rev;
	switch(Axis){
		case X:
			PulseCounter = EN_X.PulseCounter;
			control_PID(Axis, PulseCounter, r, &PIDparameter_X);
			break;
		case Y:
			PulseCounter = EN_Y.PulseCounter;
			control_PID(Axis, PulseCounter, r, &PIDparameter_Y);
			break;
	}
	return 0;
}

int32u Moving_Average(int32u u, int8u scale)
{
	Array_u[index] = u;
	index++;
	index = index%Average_NUM;
	for(int8u i=0;i<Average_NUM;i++)average_u += Array_u[i];	 

	return scale*average_u/Average_NUM;
}
void control_PID(AXIS Axis, int32u y, int32u r, struct PIDparameter *par)
{

	par->e = r-y;
	par->delta_u = (par->K_P+par->K_I+par->K_D)*par->e-(par->K_P+2*par->K_D)*par->pe1+(par->K_D)*par->pe2;
	par->u = par->pu1+par->delta_u;		
	if ( par->u >= 0 ) motor_drive(Axis, CW, par->u);
	else 			   motor_drive(Axis, CCW, abs(par->u));
	par->pu1 = par->u;
	par->pe2 = par->pe1;
	par->pe1 = par->e;

}
			
void motor_drive(AXIS Axis, ROTATION Rotate, int32s u)
{
	if( u < 0) 		u=0;
	if( u > 300 )  u=300;
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
	EN_X.SamplingCounter_A = 0;
	EN_X.SamplingCounter_B = 0;
	EN_Y.SamplingCounter_A = 0;
	EN_Y.SamplingCounter_B = 0;
	RotateX = STOP;
	RotateY = STOP;
	EN_X.PulseCounter = 0;
	EN_X.PulseCounterOld = 0;
	EN_Y.PulseCounter = 0;
	EN_Y.PulseCounterOld = 0;
	//PID
	Axis = None;
	PIDparameter_X.pu1 = 0;
	PIDparameter_X.pe1 = 0;
	PIDparameter_X.pe2 = 0;	
	PIDparameter_X.K_P = K_P1;
	PIDparameter_X.K_I = K_I1;
	PIDparameter_X.K_D = K_D1;
	/////////////////////////
	PIDparameter_Y.pu1 = 0;
	PIDparameter_Y.pe1 = 0;
	PIDparameter_Y.pe2 = 0;
	PIDparameter_Y.K_P = K_P1;
	PIDparameter_Y.K_I = K_I1;
	PIDparameter_Y.K_D = K_D1;
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
	EN_X.Old_A = (ReadPortA & 0x0004) >> 2;
	EN_X.Old_B = (ReadPortA & 0x0010) >> 4;
	EN_Y.Old_A = (ReadPortB & 0x0004) >> 2;
	EN_Y.Old_B = (ReadPortB & 0x0008) >> 3;
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
	setup_timer3(TMR_INTERNAL | TMR_DIV_BY_256, 62); //0.05 sec
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
	//EN_X_A
	EN_X.New_A[EN_X.SamplingCounter_A] = (ReadPortA & 0x0004) >> 2;
	if((EN_X.New_A[0] == EN_X.New_A[1]) && (EN_X.New_A[1] == EN_X.New_A[2]))
	{
		EN_X.New_Actual_A = EN_X.New_A[EN_X.SamplingCounter_A];
		if(EN_X.New_Actual_A != EN_X.Old_A)
		{
			EN_X.Old_A = EN_X.New_Actual_A;
			Sampling = 1;
			if((EN_X.Old_A ^ EN_X.Old_B) == 0)
			{
				EN_X.PulseCounter++;
				RotateX = CW;
			}
			else
			{
				EN_X.PulseCounter--;
				RotateX = CCW;
			}
		}
	}
	EN_X.SamplingCounter_A++;
	if(EN_X.SamplingCounter_A == REPEAT_SAMPLING)
	{
		EN_X.SamplingCounter_A = 0;
	}
	//EN_X_B
	EN_X.New_B[EN_X.SamplingCounter_B] = (ReadPortA & 0x0010) >> 4;
	if((EN_X.New_B[0] == EN_X.New_B[1]) && (EN_X.New_B[1] == EN_X.New_B[2]))
	{
		EN_X.New_Actual_B = EN_X.New_B[EN_X.SamplingCounter_B];
		if(EN_X.New_Actual_B != EN_X.Old_B)
		{
			EN_X.Old_B = EN_X.New_Actual_B;
			Sampling = 1;
			if((EN_X.Old_A ^ EN_X.Old_B) == 0)
			{
				EN_X.PulseCounter--;
				RotateX = CCW;
			}
			else
			{
				EN_X.PulseCounter++;
				RotateX = CW;
			}
		}
	}
	EN_X.SamplingCounter_B++;
	if(EN_X.SamplingCounter_B == REPEAT_SAMPLING)
	{
		EN_X.SamplingCounter_B = 0;
	}
}

#INT_TIMER5
static void Timer5ISR(void)
{
	ReadPortB = input_b() & 0x000C;
	//EN_Y_A
	EN_Y.New_A[EN_Y.SamplingCounter_A] = (ReadPortB & 0x0004) >> 2;
	if((EN_Y.New_A[0] == EN_Y.New_A[1]) && (EN_Y.New_A[1] == EN_Y.New_A[2]))
	{
		EN_Y.New_Actual_A = EN_Y.New_A[EN_Y.SamplingCounter_A];
		if(EN_Y.New_Actual_A != EN_Y.Old_A)
		{
			EN_Y.Old_A = EN_Y.New_Actual_A;
			Sampling = 1;
			if((EN_Y.Old_A ^ EN_Y.Old_B) == 0)
			{
				EN_Y.PulseCounter++;
				RotateY = CW;
			}
			else
			{
				EN_Y.PulseCounter--;
				RotateY = CCW;
			}
		}
	}
	EN_Y.SamplingCounter_A++;
	if(EN_Y.SamplingCounter_A == REPEAT_SAMPLING)
	{
		EN_Y.SamplingCounter_A = 0;
	}
	//EN_Y_B
	EN_Y.New_B[EN_Y.SamplingCounter_B] = (ReadPortB & 0x0008) >> 3;
	if((EN_Y.New_B[0] == EN_Y.New_B[1]) && (EN_Y.New_B[1] == EN_Y.New_B[2]))
	{
		EN_Y.New_Actual_B = EN_Y.New_B[EN_Y.SamplingCounter_B];
		if(EN_Y.New_Actual_B != EN_Y.Old_B)
		{
			EN_Y.Old_B = EN_Y.New_Actual_B;
			Sampling = 1;
			if((EN_Y.Old_A ^ EN_Y.Old_B) == 0)
			{
				EN_Y.PulseCounter--;
				RotateY = CCW;
			}
			else
			{
				EN_Y.PulseCounter++;
				RotateY = CW;
			}
		}
	}
	EN_Y.SamplingCounter_B++;
	if(EN_Y.SamplingCounter_B == REPEAT_SAMPLING)
	{
		EN_Y.SamplingCounter_B = 0;
	}
}

#INT_Timer3
static void Timer3ISR(void)
{
	//Tmr3IntrCounter++;
	//Axis1
	//EN_X.PulseCounterNew = EN_X.PulseCounter;
	//EN_X.PulseCounterInterval = EN_X.PulseCounterNew - EN_X.PulseCounterOld;
	//EN_X.PulseCounterOld = EN_X.PulseCounterNew;
	//Axis2
	//EN_Y.PulseCounterNew = EN_Y.PulseCounter;
	//EN_Y.PulseCounterInterval = EN_Y.PulseCounterNew - EN_Y.PulseCounterOld;
	//EN_Y.PulseCounterOld = EN_Y.PulseCounterNew;
	switch(state)
	{
		case 0: Position_control(X,100); Position_control(Y,100); break;
		case 1: Position_control(X,0); Position_control(Y,100); break;
		case 2: Position_control(X,50); Position_control(Y,0); break;
		case 3: Position_control(X,0); Position_control(Y,0); break;
	}	
	if(abs(PIDparameter_X.e)<5 && abs(PIDparameter_Y.e)<5 )	{state++; state%=4;}
			
	//printf("e: %d, u: %d ,Pulse: %d\r\n",PIDparameter_X.e,PIDparameter_X.u,EN_X.PulseCounter);
	return;
}
/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/