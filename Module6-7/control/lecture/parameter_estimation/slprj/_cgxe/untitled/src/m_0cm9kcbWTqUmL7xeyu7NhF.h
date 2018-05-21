#ifndef __0cm9kcbWTqUmL7xeyu7NhF_h__
#define __0cm9kcbWTqUmL7xeyu7NhF_h__

/* Include files */
#include "simstruc.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "slexec_vm_zc_functions.h"

/* Type Definitions */
#ifndef typedef_freedomboard_rgbled
#define typedef_freedomboard_rgbled

typedef struct {
  int32_T isInitialized;
} freedomboard_rgbled;

#endif                                 /*typedef_freedomboard_rgbled*/

#ifndef typedef_struct_T
#define typedef_struct_T

typedef struct {
  real_T f1[2];
  real_T f2[2];
  real_T f3[2];
} struct_T;

#endif                                 /*typedef_struct_T*/

#ifndef typedef_InstanceStruct_0cm9kcbWTqUmL7xeyu7NhF
#define typedef_InstanceStruct_0cm9kcbWTqUmL7xeyu7NhF

typedef struct {
  SimStruct *S;
  freedomboard_rgbled sysobj;
  boolean_T sysobj_not_empty;
  void *emlrtRootTLSGlobal;
  real_T *u0;
  real_T *u1;
  real_T *u2;
} InstanceStruct_0cm9kcbWTqUmL7xeyu7NhF;

#endif                                 /*typedef_InstanceStruct_0cm9kcbWTqUmL7xeyu7NhF*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
extern void method_dispatcher_0cm9kcbWTqUmL7xeyu7NhF(SimStruct *S, int_T method,
  void* data);

#endif
