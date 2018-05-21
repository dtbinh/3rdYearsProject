/*
 * Trial License - for use to evaluate programs for possible purchase as
 * an end-user only.
 *
 * File: ert_main.c
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
#include "rtwtypes.h"

volatile int IsrOverrun = 0;
static boolean_T OverrunFlag = 0;
void rt_OneStep(void)
{
  /* Check for overrun. Protect OverrunFlag against preemption */
  if (OverrunFlag++) {
    IsrOverrun = 1;
    OverrunFlag--;
    return;
  }

  __enable_irq();
  untitled_step();

  /* Get model outputs here */
  __disable_irq();
  OverrunFlag--;
}

int main(void)
{
  volatile boolean_T runModel = 1;
  float modelBaseRate = 0.2;
  float systemClock = 48;
  BoardInit();
  rtmSetErrorStatus(untitled_M, 0);
  untitled_initialize();
  ARMCM_SysTick_Config(modelBaseRate);
  runModel =
    rtmGetErrorStatus(untitled_M) == (NULL);
  __enable_irq();
  while (runModel) {
    runModel =
      rtmGetErrorStatus(untitled_M) == (NULL);
  }

  /* Disable rt_OneStep() here */

  /* Terminate model */
  untitled_terminate();

#ifdef EXT_MODE

  wait_ms(1000);

#endif

  (void) systemClock;
  return 0;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
