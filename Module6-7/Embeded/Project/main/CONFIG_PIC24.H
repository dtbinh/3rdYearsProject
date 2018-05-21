/*
*************************** C HEADER FILE ************************************

project   :
filename  : CONFIG_PIC24.H
version   : 
date      :

******************************************************************************
*/

#ifndef  CONFIG_PIC24_INCLUDED
#define  CONFIG_PIC24_INCLUDED

/****************************************************************************/
/**                                                                        **/
/**                              MODULES USED                              **/
/**                                                                        **/
/****************************************************************************/
#include <24FJ48GA002.H>
//#include <24FJ16GA002.H>
/****************************************************************************/
/**                                                                        **/
/**                        DEFINITIONS AND MACROS                          **/
/**                                                                        **/
/****************************************************************************/

#DEVICE ADC=10
#fuses NOIOL1WAY, NODEBUG, NOWRT, NOPROTECT, NOJTAG, NOWDT
#fuses OSCIO
#fuses FRC_PLL
#case
#type signed
#use delay(internal=8 MHz, clock = 32000000) 
#use fast_io(ALL)
#pin_select U1TX = PIN_B13
#pin_select U1RX = PIN_B12
#use RS232 (UART1, BAUD = 115200, XMIT = PIN_B13, RCV = PIN_B12, STREAM = COM_A)
#BIT TX1IF = 0x0084.12  // Tx1 Interrupt flag  IFS0.12

//////////////////////////////////////////////////
// EXT INT pins
#if 0
// INT0 is RB7
#pin_select INT1 = PIN_B6
#pin_select INT2 = PIN_B5

#endif
//////////////////////////////////////////////////
#if 0

#pin_select U2TX = PIN_B10
#pin_select U2RX = PIN_B11

//#use RS232 (UART2, BAUD = 9600, XMIT = PIN_B9, RCV = PIN_B8, STREAM = COM_B)
//#use RS232 (BAUD = 9600, XMIT = PIN_B10, RCV = PIN_B11, STREAM = COM_B)

#endif
//////////////////////////////////////////////////
// REMAP i/o pins
#if 1

#pin_select OC1 = PIN_B0  // RP0  AX2
#pin_select OC2 = PIN_B1  // RP1  AX3

#endif
//////////////////////////////////////////////////

#include <stdlib.h>  
#include <stdio.h>
#include <stdlibm.h>
#include <string.h>
#include <stdint.h>
#include "BL_support.h"
/****************************************************************************/
// o/p pins  
#define  INA_X  PIN_B4 //DI0
#define  INB_X  PIN_B5 //DI1
#define  INA_Y  PIN_B6 //DI2
#define  INB_Y  PIN_B7 //DI3

// i/p pins  
#define  ENA_X  PIN_A2 //DO0
#define  ENB_X  PIN_A4 //DO1
#define  ENA_Y  PIN_B2 //DO2
#define  ENB_Y  PIN_B3 //DO3
#define  SW_X1  PIN_A0 //AX0
#define  SW_X2  PIN_B10 
#define  SW_Y1  PIN_A1 //AX1
#define  SW_Y2  PIN_B11

/****************************************************************************/

#endif
/****************************************************************************/
/**                                                                        **/
/**                              EOF                                       **/
/**                                                                        **/
/****************************************************************************/


