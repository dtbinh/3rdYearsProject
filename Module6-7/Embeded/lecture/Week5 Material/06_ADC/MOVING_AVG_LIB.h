/*
*************************** C HEADER FILE ************************************

project   :
filename  : CTEMPLATE.H
version   : 2
date      :

******************************************************************************

Copyright (c) 20xx ,
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

#ifndef  MOVING_AVG_LIB_INCLUDED
#define  MOVING_AVG_LIB_INCLUDED

/****************************************************************************/
/**                                                                        **/
/**                              MODULES USED                              **/
/**                                                                        **/
/****************************************************************************/

//#include <stdlib.h>  // depend on application requirements.
//#include "cdat68k.h"  // define data types
#include "CONFIG_PIC24.h"
#include "CDATPIC24.h"


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
typedef int16u APP_DAT_TYPE;

typedef struct 
{
	APP_DAT_TYPE sum;
	APP_DAT_TYPE avg;
	int8u put;
	int8u buffLength;
	APP_DAT_TYPE * buffPtr;
} MOVING_AVG_STRUCT;

/****************************************************************************/
/**                                                                        **/
/**                         EXPORTED VARIABLES                             **/
/**                                                                        **/
/****************************************************************************/

#ifndef MOVING_AVG_LIB_C_SRC
#endif

/****************************************************************************/
/**                                                                        **/
/**                       EXPORTED FUNCTIONS                               **/
/**                                                                        **/
/****************************************************************************/

void InitMvgAvg (MOVING_AVG_STRUCT * mvgPtr, APP_DAT_TYPE * arrayPtr,
					APP_DAT_TYPE arrayLng);
void MovingAvg (MOVING_AVG_STRUCT * mvgPtr, APP_DAT_TYPE newDat, 
					APP_DAT_TYPE * resultPtr);

/****************************************************************************/
#endif

/****************************************************************************/
/**                                                                        **/
/**                              EOF                                       **/
/**                                                                        **/
/****************************************************************************/