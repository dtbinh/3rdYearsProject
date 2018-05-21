#ifndef __mv8cGpVyckrumJZio0klhD_h__
#define __mv8cGpVyckrumJZio0klhD_h__

/* Include files */
#include "simstruc.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "slexec_vm_zc_functions.h"

/* Type Definitions */
#ifndef typedef_freedomboard_Servo
#define typedef_freedomboard_Servo

typedef struct {
  int32_T isInitialized;
  boolean_T TunablePropsChanged;
  real_T minAngle;
  real_T maxAngle;
} freedomboard_Servo;

#endif                                 /*typedef_freedomboard_Servo*/

#ifndef typedef_struct_T
#define typedef_struct_T

typedef struct {
  real_T f1[2];
} struct_T;

#endif                                 /*typedef_struct_T*/

#ifndef typedef_b_struct_T
#define typedef_b_struct_T

typedef struct {
  char_T f1[6];
} b_struct_T;

#endif                                 /*typedef_b_struct_T*/

#ifndef typedef_c_struct_T
#define typedef_c_struct_T

typedef struct {
  char_T f1[6];
  char_T f2[2];
  real_T f3;
} c_struct_T;

#endif                                 /*typedef_c_struct_T*/

#ifndef typedef_InstanceStruct_mv8cGpVyckrumJZio0klhD
#define typedef_InstanceStruct_mv8cGpVyckrumJZio0klhD

typedef struct {
  SimStruct *S;
  freedomboard_Servo sysobj;
  boolean_T sysobj_not_empty;
  void *emlrtRootTLSGlobal;
  real32_T *u0;
} InstanceStruct_mv8cGpVyckrumJZio0klhD;

#endif                                 /*typedef_InstanceStruct_mv8cGpVyckrumJZio0klhD*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
extern void method_dispatcher_mv8cGpVyckrumJZio0klhD(SimStruct *S, int_T method,
  void* data);

#endif
