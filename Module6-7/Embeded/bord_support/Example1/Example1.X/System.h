/* 
 * File:    System.h
 * Author:  Dr.Santi Nuratch
 *          Embedded Computing and Control Lab., INC-KMUTT
 * Created on 22 September 2016, 13:14
 */

#ifndef SYSTEM_H
#define	SYSTEM_H


#include <24FJ48GA002.h>
/******************************************************************************/
/*                           SYSTEM CONFIGURATION                             */
/******************************************************************************/

#fuses FRC_PLL, OSCIO
#fuses NOIOL1WAY, NOWDT, NODEBUG, NOWRT, NOPROTECT, NOJTAG
#device *=16 ADC=10
#use delay(clock=16000000)

/* UART1 connection (see in schematic diagram) */
#PIN_SELECT U1RX = PIN_B12
#PIN_SELECT U1TX = PIN_B13 

/* UART2 connection (see in schematic diagram) */
#PIN_SELECT U2RX = PIN_B14
#PIN_SELECT U2TX = PIN_B15 

/*
 * To map the standard io functions, e.g., printf(), kbhit() and others to 
 * the UART1 the UART1 must defined after UART2. The last defined UART will be
 * mapped to the standard io functions.
 */ 
#use rs232(baud=9600, UART2, stream=ESP)
#use rs232(baud=9600, UART1) // UART1 will be mapped to the standard io functions

/******************************************************************************/
/*                                  END                                       */
/******************************************************************************/

#endif	/* SYSTEM_H */

