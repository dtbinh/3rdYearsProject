#ifndef __X0MJCmMFbkIaTP5xyiIxaB_h__
#define __X0MJCmMFbkIaTP5xyiIxaB_h__

/* Include files */
#include "simstruc.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "slexec_vm_zc_functions.h"

/* Type Definitions */
#ifndef typedef_freedomboard_serialReceive
#define typedef_freedomboard_serialReceive

typedef struct {
  int32_T isInitialized;
  boolean_T TunablePropsChanged;
  real_T SampleTime;
  uint16_T UartDataTypeWidth;
} freedomboard_serialReceive;

#endif                                 /*typedef_freedomboard_serialReceive*/

#ifndef typedef_struct_T
#define typedef_struct_T

typedef struct {
  char_T f1[7];
} struct_T;

#endif                                 /*typedef_struct_T*/

#ifndef typedef_b_struct_T
#define typedef_b_struct_T

typedef struct {
  char_T f1[6];
  char_T f2[6];
} b_struct_T;

#endif                                 /*typedef_b_struct_T*/

#ifndef typedef_InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
#define typedef_InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB

typedef struct {
  SimStruct *S;
  freedomboard_serialReceive sysobj;
  boolean_T sysobj_not_empty;
  void *emlrtRootTLSGlobal;
  int16_T *b_y0;
  uint8_T *b_y1;
} InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB;

#endif                                 /*typedef_InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
extern void method_dispatcher_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S, int_T method,
  void* data);

#endif
