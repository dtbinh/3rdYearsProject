/* Include files */

#include "modelInterface.h"
#include "m_X0MJCmMFbkIaTP5xyiIxaB.h"
#include "mwmathutil.h"

/* Type Definitions */

/* Named Constants */
#define DataLength                     (1.0)

/* Variable Declarations */

/* Variable Definitions */
static const mxArray *eml_mx;
static const mxArray *b_eml_mx;
static emlrtRSInfo emlrtRSI = { 1,     /* lineNo */
  "serialReceive",                     /* fcnName */
  "C:\\ProgramData\\MATLAB\\SupportPackages\\R2017a\\toolbox\\target\\supportpackages\\freedomboard\\+freedomboard\\serialReceive.p"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 1,   /* lineNo */
  "freedomboardSampleTime",            /* fcnName */
  "C:\\ProgramData\\MATLAB\\SupportPackages\\R2017a\\toolbox\\target\\supportpackages\\freedomboard\\+freedomboard\\freedomboardSampleTime.p"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 1,   /* lineNo */
  "System",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\System.p"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 1,   /* lineNo */
  "SystemProp",                        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemProp.p"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 1,   /* lineNo */
  "SystemCore",                        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemCore.p"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 12,  /* lineNo */
  "toLogicalCheck",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\toLogicalCheck.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 1,   /* lineNo */
  "SampleTime",                        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+mixin\\+coder\\+internal\\SampleTime.p"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 43,  /* lineNo */
  "ExternalDependency",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\coder\\coder\\+coder\\ExternalDependency.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 10,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 18,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 23,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 25,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 32,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 35,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 27,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 28,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtMCInfo emlrtMCI = { 17,    /* lineNo */
  9,                                   /* colNo */
  "error",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\error.m"/* pName */
};

static emlrtMCInfo b_emlrtMCI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "freedomboardSampleTime",            /* fName */
  "C:\\ProgramData\\MATLAB\\SupportPackages\\R2017a\\toolbox\\target\\supportpackages\\freedomboard\\+freedomboard\\freedomboardSampleTime.p"/* pName */
};

static emlrtMCInfo c_emlrtMCI = { 163, /* lineNo */
  28,                                  /* colNo */
  "validateattributes",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pName */
};

static emlrtMCInfo d_emlrtMCI = { 154, /* lineNo */
  28,                                  /* colNo */
  "validateattributes",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pName */
};

static emlrtMCInfo e_emlrtMCI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "SystemCore",                        /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemCore.p"/* pName */
};

static emlrtRSInfo q_emlrtRSI = { 154, /* lineNo */
  "validateattributes",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 163, /* lineNo */
  "validateattributes",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pathName */
};

/* Function Declarations */
static void freedomboardSampleTime_set_SampleTime(const emlrtStack *sp,
  freedomboard_serialReceive *obj, real_T sampleTime);
static void cgxe_mdl_start(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance);
static void cgxe_mdl_initialize(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance);
static void cgxe_mdl_outputs(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance);
static void cgxe_mdl_update(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance);
static void cgxe_mdl_terminate(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance);
static const mxArray *cgxe_mdl_get_sim_state
  (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance);
static freedomboard_serialReceive emlrt_marshallIn(const emlrtStack *sp, const
  mxArray *b_sysobj, const char_T *identifier);
static freedomboard_serialReceive b_emlrt_marshallIn(const emlrtStack *sp, const
  mxArray *u, const emlrtMsgIdentifier *parentId);
static int32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId);
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static uint16_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static boolean_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *b_sysobj_not_empty, const char_T *identifier);
static void cgxe_mdl_set_sim_state(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance, const mxArray *st);
static const mxArray *message(const emlrtStack *sp, const mxArray *b,
  emlrtMCInfo *location);
static void error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void b_error(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                    emlrtMCInfo *location);
static const mxArray *b_message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location);
static int32_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static boolean_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static real_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static uint16_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static void init_simulink_io_address(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance);

/* Function Definitions */
static void freedomboardSampleTime_set_SampleTime(const emlrtStack *sp,
  freedomboard_serialReceive *obj, real_T sampleTime)
{
  emlrtStack st;
  emlrtStack b_st;
  boolean_T p;
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 1, 21 };

  static char_T u[21] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'e', 'x', 'p', 'e',
    'c', 't', 'e', 'd', 'N', 'o', 'n', 'N', 'a', 'N' };

  const mxArray *b_y;
  static const int32_T iv1[2] = { 1, 37 };

  static const int32_T iv2[2] = { 1, 21 };

  static char_T b_u[37] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', '\'',
    'S', 'a', 'm', 'p', 'l', 'e', ' ', 't', 'i', 'm', 'e', '\'', ' ', 't', 'o',
    ' ', 'b', 'e', ' ', 'n', 'o', 'n', '-', 'N', 'a', 'N', '.' };

  static char_T c_u[21] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'e', 'x', 'p',
    'e', 'c', 't', 'e', 'd', 'F', 'i', 'n', 'i', 't', 'e' };

  static const int32_T iv3[2] = { 1, 49 };

  static char_T d_u[49] = { 'f', 'r', 'e', 'e', 'd', 'o', 'm', 'b', 'o', 'a',
    'r', 'd', ':', 'b', 'l', 'o', 'c', 'k', 's', ':', 'I', 'n', 'v', 'a', 'l',
    'i', 'd', 'S', 'a', 'm', 'p', 'l', 'e', 'T', 'i', 'm', 'e', 'N', 'e', 'e',
    'd', 'P', 'o', 's', 'i', 't', 'i', 'v', 'e' };

  static const int32_T iv4[2] = { 1, 36 };

  static char_T e_u[36] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', '\'',
    'S', 'a', 'm', 'p', 'l', 'e', ' ', 't', 'i', 'm', 'e', '\'', ' ', 't', 'o',
    ' ', 'b', 'e', ' ', 'f', 'i', 'n', 'i', 't', 'e', '.' };

  st.prev = sp;
  st.tls = sp->tls;
  st.site = &b_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  p = true;
  if (muDoubleScalarIsNaN(sampleTime)) {
    p = false;
  }

  if (!p) {
    y = NULL;
    m0 = emlrtCreateCharArray(2, iv0);
    emlrtInitCharArrayR2013a(&st, 21, m0, &u[0]);
    emlrtAssign(&y, m0);
    b_y = NULL;
    m0 = emlrtCreateCharArray(2, iv1);
    emlrtInitCharArrayR2013a(&st, 37, m0, &b_u[0]);
    emlrtAssign(&b_y, m0);
    b_st.site = &r_emlrtRSI;
    b_error(&b_st, y, b_y, &c_emlrtMCI);
  }

  p = true;
  if (!((!muDoubleScalarIsInf(sampleTime)) && (!muDoubleScalarIsNaN(sampleTime))))
  {
    p = false;
  }

  if (!p) {
    y = NULL;
    m0 = emlrtCreateCharArray(2, iv2);
    emlrtInitCharArrayR2013a(&st, 21, m0, &c_u[0]);
    emlrtAssign(&y, m0);
    b_y = NULL;
    m0 = emlrtCreateCharArray(2, iv4);
    emlrtInitCharArrayR2013a(&st, 36, m0, &e_u[0]);
    emlrtAssign(&b_y, m0);
    b_st.site = &q_emlrtRSI;
    b_error(&b_st, y, b_y, &d_emlrtMCI);
  }

  if ((sampleTime < 0.0) && (sampleTime != -1.0)) {
    y = NULL;
    m0 = emlrtCreateCharArray(2, iv3);
    emlrtInitCharArrayR2013a(sp, 49, m0, &d_u[0]);
    emlrtAssign(&y, m0);
    st.site = &b_emlrtRSI;
    error(&st, message(&st, y, &b_emlrtMCI), &b_emlrtMCI);
  }

  obj->SampleTime = sampleTime;
}

static void cgxe_mdl_start(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  emlrtStack c_st;
  const mxArray *m1;
  static const int32_T iv5[2] = { 0, 0 };

  static const int32_T iv6[2] = { 0, 0 };

  freedomboard_serialReceive *obj;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  static const int32_T iv7[2] = { 1, 51 };

  emlrtStack f_st;
  static char_T u[51] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'L', 'o', 'c', 'k', 'e', 'd', 'R', 'e', 'l', 'e', 'a',
    's', 'e', 'd', 'C', 'o', 'd', 'e', 'g', 'e', 'n' };

  const mxArray *b_y;
  static const int32_T iv8[2] = { 1, 5 };

  static char_T b_u[5] = { 's', 'e', 't', 'u', 'p' };

  static const int32_T iv9[2] = { 1, 44 };

  static char_T c_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  boolean_T flag;
  real_T *b_SampleTime;
  init_simulink_io_address(moduleInstance);
  b_SampleTime = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  cgxertSetGcb(moduleInstance->S, -1, -1);
  m1 = emlrtCreateNumericArray(2, iv5, mxDOUBLE_CLASS, mxREAL);
  emlrtAssignP(&b_eml_mx, m1);
  m1 = emlrtCreateCharArray(2, iv6);
  emlrtAssignP(&eml_mx, m1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    f_st.site = &e_emlrtRSI;
    f_st.site = &e_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &g_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &h_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &j_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &j_emlrtRSI;
    freedomboardSampleTime_set_SampleTime(&b_st, &moduleInstance->sysobj,
      *b_SampleTime);
  }

  b_st.site = &k_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized != 0) {
    y = NULL;
    m1 = emlrtCreateCharArray(2, iv7);
    emlrtInitCharArrayR2013a(&b_st, 51, m1, &u[0]);
    emlrtAssign(&y, m1);
    b_y = NULL;
    m1 = emlrtCreateCharArray(2, iv8);
    emlrtInitCharArrayR2013a(&b_st, 5, m1, &b_u[0]);
    emlrtAssign(&b_y, m1);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  obj->isInitialized = 1;
  c_st.site = &e_emlrtRSI;
  obj->UartDataTypeWidth = 2U;
  c_st.site = &e_emlrtRSI;
  if (obj->TunablePropsChanged) {
    y = NULL;
    m1 = emlrtCreateCharArray(2, iv9);
    emlrtInitCharArrayR2013a(&c_st, 44, m1, &c_u[0]);
    emlrtAssign(&y, m1);
    error(&c_st, message(&c_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  obj->TunablePropsChanged = false;
  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_initialize(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  freedomboard_serialReceive *obj;
  emlrtStack c_st;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  boolean_T tunablePropChangedBeforeResetImpl;
  const mxArray *m2;
  static const int32_T iv10[2] = { 1, 45 };

  emlrtStack f_st;
  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv11[2] = { 1, 44 };

  const mxArray *b_y;
  static char_T b_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv12[2] = { 1, 5 };

  static char_T c_u[5] = { 'r', 'e', 's', 'e', 't' };

  real_T *b_SampleTime;
  b_SampleTime = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  cgxertSetGcb(moduleInstance->S, -1, -1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    f_st.site = &e_emlrtRSI;
    f_st.site = &e_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &g_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &h_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &j_emlrtRSI;
    tunablePropChangedBeforeResetImpl = (moduleInstance->sysobj.isInitialized ==
      1);
    if (tunablePropChangedBeforeResetImpl) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &j_emlrtRSI;
    freedomboardSampleTime_set_SampleTime(&b_st, &moduleInstance->sysobj,
      *b_SampleTime);
  }

  b_st.site = &l_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m2 = emlrtCreateCharArray(2, iv10);
    emlrtInitCharArrayR2013a(&b_st, 45, m2, &u[0]);
    emlrtAssign(&y, m2);
    b_y = NULL;
    m2 = emlrtCreateCharArray(2, iv12);
    emlrtInitCharArrayR2013a(&b_st, 5, m2, &c_u[0]);
    emlrtAssign(&b_y, m2);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  tunablePropChangedBeforeResetImpl = obj->TunablePropsChanged;
  if ((int32_T)tunablePropChangedBeforeResetImpl != (int32_T)
      obj->TunablePropsChanged) {
    y = NULL;
    m2 = emlrtCreateCharArray(2, iv11);
    emlrtInitCharArrayR2013a(&b_st, 44, m2, &b_u[0]);
    emlrtAssign(&y, m2);
    error(&b_st, message(&b_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_outputs(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  real_T hoistedGlobal_SampleTime;
  freedomboard_serialReceive *obj;
  boolean_T flag;
  boolean_T p;
  emlrtStack f_st;
  const mxArray *y;
  const mxArray *m3;
  static const int32_T iv13[2] = { 1, 45 };

  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  const mxArray *b_y;
  static const int32_T iv14[2] = { 1, 4 };

  static const int32_T iv15[2] = { 1, 51 };

  static char_T b_u[4] = { 's', 't', 'e', 'p' };

  static char_T c_u[51] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e',
    'd', 'W', 'h', 'e', 'n', 'L', 'o', 'c', 'k', 'e', 'd', 'R', 'e', 'l', 'e',
    'a', 's', 'e', 'd', 'C', 'o', 'd', 'e', 'g', 'e', 'n' };

  static const int32_T iv16[2] = { 1, 44 };

  static char_T d_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv17[2] = { 1, 5 };

  static char_T e_u[5] = { 's', 'e', 't', 'u', 'p' };

  static const int32_T iv18[2] = { 1, 44 };

  real_T *b_SampleTime;
  b_SampleTime = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  cgxertSetGcb(moduleInstance->S, -1, -1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    f_st.site = &e_emlrtRSI;
    f_st.site = &e_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &g_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &h_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &j_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &j_emlrtRSI;
    freedomboardSampleTime_set_SampleTime(&b_st, &moduleInstance->sysobj,
      *b_SampleTime);
  }

  hoistedGlobal_SampleTime = moduleInstance->sysobj.SampleTime;
  flag = false;
  p = true;
  if (!(hoistedGlobal_SampleTime == *b_SampleTime)) {
    p = false;
  }

  if (p) {
    flag = true;
  }

  if (!flag) {
    b_st.site = &m_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &m_emlrtRSI;
    freedomboardSampleTime_set_SampleTime(&b_st, &moduleInstance->sysobj,
      *b_SampleTime);
  }

  b_st.site = &n_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m3 = emlrtCreateCharArray(2, iv13);
    emlrtInitCharArrayR2013a(&b_st, 45, m3, &u[0]);
    emlrtAssign(&y, m3);
    b_y = NULL;
    m3 = emlrtCreateCharArray(2, iv14);
    emlrtInitCharArrayR2013a(&b_st, 4, m3, &b_u[0]);
    emlrtAssign(&b_y, m3);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  if (obj->isInitialized != 1) {
    c_st.site = &e_emlrtRSI;
    d_st.site = &e_emlrtRSI;
    if (obj->isInitialized != 0) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv15);
      emlrtInitCharArrayR2013a(&d_st, 51, m3, &c_u[0]);
      emlrtAssign(&y, m3);
      b_y = NULL;
      m3 = emlrtCreateCharArray(2, iv17);
      emlrtInitCharArrayR2013a(&d_st, 5, m3, &e_u[0]);
      emlrtAssign(&b_y, m3);
      error(&d_st, b_message(&d_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
    }

    obj->isInitialized = 1;
    e_st.site = &e_emlrtRSI;
    obj->UartDataTypeWidth = 2U;
    e_st.site = &e_emlrtRSI;
    if (obj->TunablePropsChanged) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv18);
      emlrtInitCharArrayR2013a(&e_st, 44, m3, &d_u[0]);
      emlrtAssign(&y, m3);
      error(&e_st, message(&e_st, y, &e_emlrtMCI), &e_emlrtMCI);
    }

    obj->TunablePropsChanged = false;
  }

  c_st.site = &e_emlrtRSI;
  if (obj->TunablePropsChanged) {
    obj->TunablePropsChanged = false;
  }

  c_st.site = &e_emlrtRSI;
  if (obj->TunablePropsChanged) {
    y = NULL;
    m3 = emlrtCreateCharArray(2, iv16);
    emlrtInitCharArrayR2013a(&c_st, 44, m3, &d_u[0]);
    emlrtAssign(&y, m3);
    error(&c_st, message(&c_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  *moduleInstance->b_y0 = 0;
  *moduleInstance->b_y1 = 0U;
  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_update(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance)
{
  cgxertSetGcb(moduleInstance->S, -1, -1);
  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_terminate(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  freedomboard_serialReceive *obj;
  emlrtStack c_st;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  boolean_T flag;
  const mxArray *m4;
  static const int32_T iv19[2] = { 1, 45 };

  emlrtStack f_st;
  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  const mxArray *b_y;
  static const int32_T iv20[2] = { 1, 8 };

  static char_T b_u[8] = { 'i', 's', 'L', 'o', 'c', 'k', 'e', 'd' };

  static const int32_T iv21[2] = { 1, 45 };

  static const int32_T iv22[2] = { 1, 7 };

  static char_T c_u[7] = { 'r', 'e', 'l', 'e', 'a', 's', 'e' };

  real_T *b_SampleTime;
  b_SampleTime = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtDestroyArray(&b_eml_mx);
  emlrtDestroyArray(&eml_mx);
  cgxertSetGcb(moduleInstance->S, -1, -1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    f_st.site = &e_emlrtRSI;
    f_st.site = &e_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &g_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &h_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &j_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &j_emlrtRSI;
    freedomboardSampleTime_set_SampleTime(&b_st, &moduleInstance->sysobj,
      *b_SampleTime);
  }

  b_st.site = &o_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m4 = emlrtCreateCharArray(2, iv19);
    emlrtInitCharArrayR2013a(&b_st, 45, m4, &u[0]);
    emlrtAssign(&y, m4);
    b_y = NULL;
    m4 = emlrtCreateCharArray(2, iv20);
    emlrtInitCharArrayR2013a(&b_st, 8, m4, &b_u[0]);
    emlrtAssign(&b_y, m4);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  flag = (obj->isInitialized == 1);
  if (flag) {
    b_st.site = &p_emlrtRSI;
    obj = &moduleInstance->sysobj;
    if (moduleInstance->sysobj.isInitialized == 2) {
      y = NULL;
      m4 = emlrtCreateCharArray(2, iv21);
      emlrtInitCharArrayR2013a(&b_st, 45, m4, &u[0]);
      emlrtAssign(&y, m4);
      b_y = NULL;
      m4 = emlrtCreateCharArray(2, iv22);
      emlrtInitCharArrayR2013a(&b_st, 7, m4, &c_u[0]);
      emlrtAssign(&b_y, m4);
      error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
    }

    if (obj->isInitialized == 1) {
      obj->isInitialized = 2;
    }
  }

  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static const mxArray *cgxe_mdl_get_sim_state
  (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance)
{
  const mxArray *st;
  const mxArray *y;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *m5;
  st = NULL;
  y = NULL;
  emlrtAssign(&y, emlrtCreateCellMatrix(2, 1));
  b_y = NULL;
  emlrtAssign(&b_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
  c_y = NULL;
  m5 = emlrtCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
  *(int32_T *)mxGetData(m5) = moduleInstance->sysobj.isInitialized;
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "isInitialized", 0);
  c_y = NULL;
  m5 = emlrtCreateLogicalScalar(moduleInstance->sysobj.TunablePropsChanged);
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "TunablePropsChanged", 0);
  c_y = NULL;
  m5 = emlrtCreateDoubleScalar(moduleInstance->sysobj.SampleTime);
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "SampleTime", 0);
  c_y = NULL;
  m5 = emlrtCreateNumericMatrix(1, 1, mxUINT16_CLASS, mxREAL);
  *(uint16_T *)mxGetData(m5) = moduleInstance->sysobj.UartDataTypeWidth;
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "UartDataTypeWidth", 0);
  emlrtSetCell(y, 0, b_y);
  b_y = NULL;
  m5 = emlrtCreateLogicalScalar(moduleInstance->sysobj_not_empty);
  emlrtAssign(&b_y, m5);
  emlrtSetCell(y, 1, b_y);
  emlrtAssign(&st, y);
  return st;
}

static freedomboard_serialReceive emlrt_marshallIn(const emlrtStack *sp, const
  mxArray *b_sysobj, const char_T *identifier)
{
  freedomboard_serialReceive y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(b_sysobj), &thisId);
  emlrtDestroyArray(&b_sysobj);
  return y;
}

static freedomboard_serialReceive b_emlrt_marshallIn(const emlrtStack *sp, const
  mxArray *u, const emlrtMsgIdentifier *parentId)
{
  freedomboard_serialReceive y;
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[4] = { "isInitialized", "TunablePropsChanged",
    "SampleTime", "UartDataTypeWidth" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 4, fieldNames, 0U, &dims);
  thisId.fIdentifier = "isInitialized";
  y.isInitialized = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u,
    0, "isInitialized")), &thisId);
  thisId.fIdentifier = "TunablePropsChanged";
  y.TunablePropsChanged = d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a
    (sp, u, 0, "TunablePropsChanged")), &thisId);
  thisId.fIdentifier = "SampleTime";
  y.SampleTime = e_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0,
    "SampleTime")), &thisId);
  thisId.fIdentifier = "UartDataTypeWidth";
  y.UartDataTypeWidth = f_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp,
    u, 0, "UartDataTypeWidth")), &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static int32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  int32_T y;
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = j_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static uint16_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  uint16_T y;
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static boolean_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *b_sysobj_not_empty, const char_T *identifier)
{
  boolean_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(b_sysobj_not_empty), &thisId);
  emlrtDestroyArray(&b_sysobj_not_empty);
  return y;
}

static void cgxe_mdl_set_sim_state(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance, const mxArray *st)
{
  emlrtStack b_st = { NULL,            /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *u;
  b_st.tls = moduleInstance->emlrtRootTLSGlobal;
  u = emlrtAlias(st);
  moduleInstance->sysobj = emlrt_marshallIn(&b_st, emlrtAlias(emlrtGetCell(&b_st,
    "sysobj", u, 0)), "sysobj");
  moduleInstance->sysobj_not_empty = g_emlrt_marshallIn(&b_st, emlrtAlias
    (emlrtGetCell(&b_st, "sysobj_not_empty", u, 1)), "sysobj_not_empty");
  emlrtDestroyArray(&u);
  emlrtDestroyArray(&st);
}

static const mxArray *message(const emlrtStack *sp, const mxArray *b,
  emlrtMCInfo *location)
{
  const mxArray *pArray;
  const mxArray *m6;
  pArray = b;
  return emlrtCallMATLABR2012b(sp, 1, &m6, 1, &pArray, "message", true, location);
}

static void error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "error", true, location);
}

static void b_error(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                    emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = b;
  pArrays[1] = c;
  emlrtCallMATLABR2012b(sp, 0, NULL, 2, pArrays, "error", true, location);
}

static const mxArray *b_message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m7;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(sp, 1, &m7, 2, pArrays, "message", true, location);
}

static int32_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  int32_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "int32", false, 0U, &dims);
  ret = *(int32_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static boolean_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  boolean_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "logical", false, 0U, &dims);
  ret = *mxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static uint16_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  uint16_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "uint16", false, 0U, &dims);
  ret = *(uint16_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void init_simulink_io_address(InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB
  *moduleInstance)
{
  moduleInstance->emlrtRootTLSGlobal = (void *)cgxertGetEMLRTCtx
    (moduleInstance->S);
  moduleInstance->b_y0 = (int16_T *)cgxertGetOutputPortSignal(moduleInstance->S,
    0);
  moduleInstance->b_y1 = (uint8_T *)cgxertGetOutputPortSignal(moduleInstance->S,
    1);
}

/* CGXE Glue Code */
static void mdlOutputs_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S, int_T tid)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_outputs(moduleInstance);
}

static void mdlInitialize_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_initialize(moduleInstance);
}

static void mdlUpdate_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S, int_T tid)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_update(moduleInstance);
}

static mxArray* getSimState_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S)
{
  mxArray* mxSS;
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  mxSS = (mxArray *) cgxe_mdl_get_sim_state(moduleInstance);
  return mxSS;
}

static void setSimState_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S, const mxArray *ss)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_set_sim_state(moduleInstance, emlrtAlias(ss));
}

static void mdlTerminate_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_terminate(moduleInstance);
  free((void *)moduleInstance);
}

static void mdlStart_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S)
{
  InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *moduleInstance =
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB *)calloc(1, sizeof
    (InstanceStruct_X0MJCmMFbkIaTP5xyiIxaB));
  moduleInstance->S = S;
  cgxertSetRuntimeInstance(S, (void *)moduleInstance);
  ssSetmdlOutputs(S, mdlOutputs_X0MJCmMFbkIaTP5xyiIxaB);
  ssSetmdlInitializeConditions(S, mdlInitialize_X0MJCmMFbkIaTP5xyiIxaB);
  ssSetmdlUpdate(S, mdlUpdate_X0MJCmMFbkIaTP5xyiIxaB);
  ssSetmdlTerminate(S, mdlTerminate_X0MJCmMFbkIaTP5xyiIxaB);
  cgxe_mdl_start(moduleInstance);

  {
    uint_T options = ssGetOptions(S);
    options |= SS_OPTION_RUNTIME_EXCEPTION_FREE_CODE;
    ssSetOptions(S, options);
  }
}

static void mdlProcessParameters_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S)
{
}

void method_dispatcher_X0MJCmMFbkIaTP5xyiIxaB(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_X0MJCmMFbkIaTP5xyiIxaB(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_X0MJCmMFbkIaTP5xyiIxaB(S);
    break;

   case SS_CALL_MDL_GET_SIM_STATE:
    *((mxArray**) data) = getSimState_X0MJCmMFbkIaTP5xyiIxaB(S);
    break;

   case SS_CALL_MDL_SET_SIM_STATE:
    setSimState_X0MJCmMFbkIaTP5xyiIxaB(S, (const mxArray *) data);
    break;

   default:
    /* Unhandled method */
    /*
       sf_mex_error_message("Stateflow Internal Error:\n"
       "Error calling method dispatcher for module: X0MJCmMFbkIaTP5xyiIxaB.\n"
       "Can't handle method %d.\n", method);
     */
    break;
  }
}

mxArray *cgxe_X0MJCmMFbkIaTP5xyiIxaB_BuildInfoUpdate(void)
{
  mxArray * mxBIArgs;
  mxArray * elem_1;
  mxArray * elem_2;
  mxArray * elem_3;
  mxArray * elem_4;
  mxArray * elem_5;
  mxArray * elem_6;
  mxArray * elem_7;
  mxArray * elem_8;
  mxArray * elem_9;
  mxArray * elem_10;
  mxBIArgs = mxCreateCellMatrix(1,3);
  elem_1 = mxCreateCellMatrix(1,6);
  elem_2 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,0,elem_2);
  elem_3 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,1,elem_3);
  elem_4 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,2,elem_4);
  elem_5 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,3,elem_5);
  elem_6 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,4,elem_6);
  elem_7 = mxCreateCellMatrix(0,0);
  mxSetCell(elem_1,5,elem_7);
  mxSetCell(mxBIArgs,0,elem_1);
  elem_8 = mxCreateCellMatrix(1,1);
  elem_9 = mxCreateString("freedomboard.serialReceive");
  mxSetCell(elem_8,0,elem_9);
  mxSetCell(mxBIArgs,1,elem_8);
  elem_10 = mxCreateCellMatrix(1,0);
  mxSetCell(mxBIArgs,2,elem_10);
  return mxBIArgs;
}

mxArray *cgxe_X0MJCmMFbkIaTP5xyiIxaB_fallback_info(void)
{
  const char* fallbackInfoFields[] = { "fallbackType", "incompatiableSymbol" };

  mxArray* fallbackInfoStruct = mxCreateStructMatrix(1, 1, 2, fallbackInfoFields);
  mxArray* fallbackType = mxCreateString("thirdPartyLibs");
  mxArray* incompatibleSymbol = mxCreateString("freedomboard.serialReceive");
  mxSetFieldByNumber(fallbackInfoStruct, 0, 0, fallbackType);
  mxSetFieldByNumber(fallbackInfoStruct, 0, 1, incompatibleSymbol);
  return fallbackInfoStruct;
}
