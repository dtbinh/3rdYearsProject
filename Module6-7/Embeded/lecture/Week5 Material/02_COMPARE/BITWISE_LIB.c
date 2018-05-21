/*
*************************** C SOURCE FILE ************************************

project   :
filename  : BITWISE_LIB.C
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

#define BITWISE_LIB_C_SRC

/****************************************************************************/
/**                                                                        **/
/**                             MODULES USED                               **/
/**                                                                        **/
/****************************************************************************/

#include "BITWISE_LIB.h"

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


/****************************************************************************/
/**                                                                        **/
/**                           EXPORTED FUNCTIONS                           **/
/**                                                                        **/
/****************************************************************************/

int16u BitSet (int16u dat, int16u bitPos)
{
	bitPos = bitPos % 16;
	dat = dat | (1 << bitPos);
	return dat;
}

int16u BitClear (int16u dat, int16u bitPos)
{
	bitPos = bitPos % 16;
	dat = dat & (~(1 << bitPos));
	return dat;
}

int16u BitInvt (int16u dat, int16u bitPos)
{
	bitPos = bitPos % 16;
	dat = dat ^ (1 << bitPos);
	return dat;
}

int16u BitTest (int16u dat, int16u bitPos)
{
	bitPos = bitPos % 16;
	dat = (dat & (1 << bitPos)) >> bitPos;
	return dat;
}

/*****************************************************************************/

void bitSetP (int16u *datPtr, int16u bitPos)
{
	bitPos = bitPos % 16;
	*datPtr = *datPtr | (1 << bitPos);
	return;
}

void bitClearP (int16u *datPtr, int16u bitPos)
{
	bitPos = bitPos % 16;
	*datPtr = *datPtr & (~(1 << bitPos));
	return;
}

void bitInvtP (int16u *datPtr, int16u bitPos)
{
	bitPos = bitPos % 16;
	*datPtr = *datPtr ^ (1 << bitPos);
	return;
}

int16u bitTestP (int16u *datPtr, int16u bitPos)
{
	int16u result;
	bitPos = bitPos % 16;
	result = (*datPtr & (1 << bitPos)) >> bitPos;
	return result;
}

/****************************************************************************/
/**                                                                        **/
/**                             LOCAL FUNCTIONS                            **/
/**                                                                        **/
/****************************************************************************/


/****************************************************************************/

/****************************************************************************/
/**                                                                        **/
/**                                 EOF                                    **/
/**                                                                        **/
/****************************************************************************/