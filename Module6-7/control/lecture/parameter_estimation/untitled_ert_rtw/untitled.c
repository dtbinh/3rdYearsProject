/*
 * Trial License - for use to evaluate programs for possible purchase as
 * an end-user only.
 *
 * File: untitled.c
 *
 * Code generated for Simulink model 'untitled'.
 *
 * Model version                  : 1.0
 * Simulink Coder version         : 8.12 (R2017a) 16-Feb-2017
 * C/C++ source code generated on : Wed Sep 20 21:06:24 2017
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "untitled.h"
#include "untitled_private.h"

/* Block states (auto storage) */
DW_untitled_T untitled_DW;

/* Real-time model */
RT_MODEL_untitled_T untitled_M_;
RT_MODEL_untitled_T *const untitled_M = &untitled_M_;
real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

/* Model step function */
void untitled_step(void)
{
  real_T tmp;
  real_T tmp_0;
  real_T tmp_1;
  uint8_T tmp_2;
  uint8_T tmp_3;
  uint8_T tmp_4;

  /* Start for MATLABSystem: '<Root>/RGB LED' incorporates:
   *  Constant: '<Root>/Constant'
   *  Constant: '<Root>/Constant1'
   *  Constant: '<Root>/Constant2'
   *  MATLABSystem: '<Root>/RGB LED'
   */
  tmp = rt_roundd_snf(untitled_P.Constant2_Value);
  tmp_0 = rt_roundd_snf(untitled_P.Constant_Value);
  tmp_1 = rt_roundd_snf(untitled_P.Constant1_Value);
  if (tmp < 256.0) {
    if (tmp >= 0.0) {
      tmp_2 = (uint8_T)tmp;
    } else {
      tmp_2 = 0U;
    }
  } else {
    tmp_2 = MAX_uint8_T;
  }

  if (tmp_0 < 256.0) {
    if (tmp_0 >= 0.0) {
      tmp_3 = (uint8_T)tmp_0;
    } else {
      tmp_3 = 0U;
    }
  } else {
    tmp_3 = MAX_uint8_T;
  }

  if (tmp_1 < 256.0) {
    if (tmp_1 >= 0.0) {
      tmp_4 = (uint8_T)tmp_1;
    } else {
      tmp_4 = 0U;
    }
  } else {
    tmp_4 = MAX_uint8_T;
  }

  MW_RGBLED_Write(tmp_2, tmp_3, tmp_4);

  /* End of Start for MATLABSystem: '<Root>/RGB LED' */
}

/* Model initialize function */
void untitled_initialize(void)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus(untitled_M, (NULL));

  /* states (dwork) */
  (void) memset((void *)&untitled_DW, 0,
                sizeof(DW_untitled_T));

  /* Start for MATLABSystem: '<Root>/RGB LED' */
  untitled_DW.obj.isInitialized = 0;
  untitled_DW.obj.isInitialized = 1;
  MW_RGBLED_Init();
}

/* Model terminate function */
void untitled_terminate(void)
{
  /* Start for MATLABSystem: '<Root>/RGB LED' incorporates:
   *  Terminate for MATLABSystem: '<Root>/RGB LED'
   */
  if (untitled_DW.obj.isInitialized == 1) {
    untitled_DW.obj.isInitialized = 2;
  }

  /* End of Start for MATLABSystem: '<Root>/RGB LED' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
