/* Include files */

#include "modelInterface.h"
#include "m_mv8cGpVyckrumJZio0klhD.h"

/* Type Definitions */

/* Named Constants */
#define WhichServo                     ('0')

/* Variable Declarations */

/* Variable Definitions */
static const mxArray *eml_mx;
static const mxArray *b_eml_mx;
static emlrtRSInfo emlrtRSI = { 1,     /* lineNo */
  "Servo",                             /* fcnName */
  "C:\\ProgramData\\MATLAB\\SupportPackages\\R2017a\\toolbox\\target\\supportpackages\\freedomboard\\+freedomboard\\Servo.p"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 1,   /* lineNo */
  "System",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\System.p"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 1,   /* lineNo */
  "SystemProp",                        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemProp.p"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 1,   /* lineNo */
  "SystemCore",                        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemCore.p"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 12,  /* lineNo */
  "toLogicalCheck",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\toLogicalCheck.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 43,  /* lineNo */
  "ExternalDependency",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\coder\\coder\\+coder\\ExternalDependency.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 9,   /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 15,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 16,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 21,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 23,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 30,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 33,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 36,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 25,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 26,  /* lineNo */
  "",                                  /* fcnName */
  ""                                   /* pathName */
};

static emlrtMCInfo emlrtMCI = { 17,    /* lineNo */
  9,                                   /* colNo */
  "error",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\error.m"/* pName */
};

static emlrtMCInfo b_emlrtMCI = { 314, /* lineNo */
  28,                                  /* colNo */
  "validateattributes",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pName */
};

static emlrtMCInfo c_emlrtMCI = { 280, /* lineNo */
  28,                                  /* colNo */
  "validateattributes",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pName */
};

static emlrtMCInfo d_emlrtMCI = { 27,  /* lineNo */
  5,                                   /* colNo */
  "error",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\error.m"/* pName */
};

static emlrtMCInfo e_emlrtMCI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "SystemCore",                        /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+coder\\SystemCore.p"/* pName */
};

static emlrtRSInfo q_emlrtRSI = { 280, /* lineNo */
  "validateattributes",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 314, /* lineNo */
  "validateattributes",                /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\lang\\validateattributes.m"/* pathName */
};

/* Function Declarations */
static void Servo_set_minAngle(const emlrtStack *sp, freedomboard_Servo *obj,
  real_T val);
static boolean_T isequal(real_T varargin_1, real_T varargin_2);
static void cgxe_mdl_start(InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance);
static void cgxe_mdl_initialize(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance);
static void cgxe_mdl_outputs(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance);
static void cgxe_mdl_update(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance);
static void cgxe_mdl_terminate(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance);
static const mxArray *cgxe_mdl_get_sim_state
  (InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance);
static freedomboard_Servo emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *b_sysobj, const char_T *identifier);
static freedomboard_Servo b_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *u, const emlrtMsgIdentifier *parentId);
static int32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId);
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static boolean_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *b_sysobj_not_empty, const char_T *identifier);
static void cgxe_mdl_set_sim_state(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance, const mxArray *st);
static const mxArray *message(const emlrtStack *sp, const mxArray *b,
  emlrtMCInfo *location);
static void error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void b_error(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                    emlrtMCInfo *location);
static const mxArray *b_message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location);
static int32_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static boolean_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void init_simulink_io_address(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance);

/* Function Definitions */
static void Servo_set_minAngle(const emlrtStack *sp, freedomboard_Servo *obj,
  real_T val)
{
  emlrtStack st;
  emlrtStack b_st;
  boolean_T p;
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 1, 22 };

  static char_T u[22] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't', 'G',
    'r', 'e', 'a', 't', 'e', 'r', 'E', 'q', 'u', 'a', 'l' };

  const mxArray *b_y;
  static const int32_T iv1[2] = { 1, 63 };

  static const int32_T iv2[2] = { 1, 19 };

  static char_T b_u[63] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'i', 'n', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '>', '=', ' ', '-', '9', '0', '.' };

  static char_T c_u[19] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't',
    'L', 'e', 's', 's', 'E', 'q', 'u', 'a', 'l' };

  static const int32_T iv3[2] = { 1, 62 };

  static char_T d_u[62] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'i', 'n', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '<', '=', ' ', '9', '0', '.' };

  st.prev = sp;
  st.tls = sp->tls;
  st.site = &emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  p = true;
  if (!(val >= -90.0)) {
    p = false;
  }

  if (!p) {
    y = NULL;
    m0 = emlrtCreateCharArray(2, iv0);
    emlrtInitCharArrayR2013a(&st, 22, m0, &u[0]);
    emlrtAssign(&y, m0);
    b_y = NULL;
    m0 = emlrtCreateCharArray(2, iv1);
    emlrtInitCharArrayR2013a(&st, 63, m0, &b_u[0]);
    emlrtAssign(&b_y, m0);
    b_st.site = &r_emlrtRSI;
    b_error(&b_st, y, b_y, &b_emlrtMCI);
  }

  p = true;
  if (!(val <= 90.0)) {
    p = false;
  }

  if (!p) {
    y = NULL;
    m0 = emlrtCreateCharArray(2, iv2);
    emlrtInitCharArrayR2013a(&st, 19, m0, &c_u[0]);
    emlrtAssign(&y, m0);
    b_y = NULL;
    m0 = emlrtCreateCharArray(2, iv3);
    emlrtInitCharArrayR2013a(&st, 62, m0, &d_u[0]);
    emlrtAssign(&b_y, m0);
    b_st.site = &q_emlrtRSI;
    b_error(&b_st, y, b_y, &c_emlrtMCI);
  }

  obj->minAngle = val;
}

static boolean_T isequal(real_T varargin_1, real_T varargin_2)
{
  boolean_T p;
  boolean_T b_p;
  p = false;
  b_p = true;
  if (!(varargin_1 == varargin_2)) {
    b_p = false;
  }

  if (b_p) {
    p = true;
  }

  return p;
}

static void cgxe_mdl_start(InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  emlrtStack c_st;
  const mxArray *m1;
  static const int32_T iv4[2] = { 0, 0 };

  static const int32_T iv5[2] = { 0, 0 };

  freedomboard_Servo *obj;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  static const int32_T iv6[2] = { 1, 51 };

  static char_T u[51] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'L', 'o', 'c', 'k', 'e', 'd', 'R', 'e', 'l', 'e', 'a',
    's', 'e', 'd', 'C', 'o', 'd', 'e', 'g', 'e', 'n' };

  const mxArray *b_y;
  static const int32_T iv7[2] = { 1, 44 };

  static const int32_T iv8[2] = { 1, 5 };

  static char_T b_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static char_T c_u[5] = { 's', 'e', 't', 'u', 'p' };

  boolean_T flag;
  real_T minVal;
  static const int32_T iv9[2] = { 1, 19 };

  static char_T d_u[19] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't',
    'L', 'e', 's', 's', 'E', 'q', 'u', 'a', 'l' };

  static const int32_T iv10[2] = { 1, 22 };

  static char_T varargin_1[22] = { 'M', 'a', 'x', ' ', 'A', 'n', 'g', 'l', 'e',
    ' ', '<', '=', ' ', 'M', 'i', 'n', ' ', 'A', 'n', 'g', 'l', 'e' };

  static const int32_T iv11[2] = { 1, 62 };

  static char_T e_u[62] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'a', 'x', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '<', '=', ' ', '9', '0', '.' };

  real_T *b_minAngle;
  real_T *b_maxAngle;
  init_simulink_io_address(moduleInstance);
  b_maxAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 1);
  b_minAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  cgxertSetGcb(moduleInstance->S, -1, -1);
  m1 = emlrtCreateNumericArray(2, iv4, mxDOUBLE_CLASS, mxREAL);
  emlrtAssignP(&b_eml_mx, m1);
  m1 = emlrtCreateCharArray(2, iv5);
  emlrtAssignP(&eml_mx, m1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &g_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &f_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &h_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &h_emlrtRSI;
    Servo_set_minAngle(&b_st, &moduleInstance->sysobj, *b_minAngle);
    b_st.site = &i_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    minVal = moduleInstance->sysobj.minAngle;
    c_st.site = &emlrtRSI;
    flag = true;
    if (!(*b_maxAngle <= 90.0)) {
      flag = false;
    }

    if (!flag) {
      y = NULL;
      m1 = emlrtCreateCharArray(2, iv9);
      emlrtInitCharArrayR2013a(&c_st, 19, m1, &d_u[0]);
      emlrtAssign(&y, m1);
      b_y = NULL;
      m1 = emlrtCreateCharArray(2, iv11);
      emlrtInitCharArrayR2013a(&c_st, 62, m1, &e_u[0]);
      emlrtAssign(&b_y, m1);
      b_error(&c_st, y, b_y, &c_emlrtMCI);
    }

    if (*b_maxAngle < minVal) {
      c_st.site = &emlrtRSI;
      y = NULL;
      m1 = emlrtCreateCharArray(2, iv10);
      emlrtInitCharArrayR2013a(&c_st, 22, m1, &varargin_1[0]);
      emlrtAssign(&y, m1);
      error(&c_st, y, &d_emlrtMCI);
    }

    obj->maxAngle = *b_maxAngle;
  }

  b_st.site = &j_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized != 0) {
    y = NULL;
    m1 = emlrtCreateCharArray(2, iv6);
    emlrtInitCharArrayR2013a(&b_st, 51, m1, &u[0]);
    emlrtAssign(&y, m1);
    b_y = NULL;
    m1 = emlrtCreateCharArray(2, iv8);
    emlrtInitCharArrayR2013a(&b_st, 5, m1, &c_u[0]);
    emlrtAssign(&b_y, m1);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  obj->isInitialized = 1;
  c_st.site = &d_emlrtRSI;
  if (obj->TunablePropsChanged) {
    y = NULL;
    m1 = emlrtCreateCharArray(2, iv7);
    emlrtInitCharArrayR2013a(&c_st, 44, m1, &b_u[0]);
    emlrtAssign(&y, m1);
    error(&c_st, message(&c_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  obj->TunablePropsChanged = false;
  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_initialize(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  emlrtStack c_st;
  freedomboard_Servo *obj;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  boolean_T tunablePropChangedBeforeResetImpl;
  const mxArray *m2;
  static const int32_T iv12[2] = { 1, 45 };

  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv13[2] = { 1, 44 };

  const mxArray *b_y;
  static char_T b_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv14[2] = { 1, 5 };

  static char_T c_u[5] = { 'r', 'e', 's', 'e', 't' };

  real_T minVal;
  static const int32_T iv15[2] = { 1, 19 };

  static char_T d_u[19] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't',
    'L', 'e', 's', 's', 'E', 'q', 'u', 'a', 'l' };

  static const int32_T iv16[2] = { 1, 22 };

  static char_T varargin_1[22] = { 'M', 'a', 'x', ' ', 'A', 'n', 'g', 'l', 'e',
    ' ', '<', '=', ' ', 'M', 'i', 'n', ' ', 'A', 'n', 'g', 'l', 'e' };

  static const int32_T iv17[2] = { 1, 62 };

  static char_T e_u[62] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'a', 'x', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '<', '=', ' ', '9', '0', '.' };

  real_T *b_minAngle;
  real_T *b_maxAngle;
  b_maxAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 1);
  b_minAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  cgxertSetGcb(moduleInstance->S, -1, -1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &g_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &f_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &h_emlrtRSI;
    tunablePropChangedBeforeResetImpl = (moduleInstance->sysobj.isInitialized ==
      1);
    if (tunablePropChangedBeforeResetImpl) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &h_emlrtRSI;
    Servo_set_minAngle(&b_st, &moduleInstance->sysobj, *b_minAngle);
    b_st.site = &i_emlrtRSI;
    tunablePropChangedBeforeResetImpl = (moduleInstance->sysobj.isInitialized ==
      1);
    if (tunablePropChangedBeforeResetImpl) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    minVal = moduleInstance->sysobj.minAngle;
    c_st.site = &emlrtRSI;
    tunablePropChangedBeforeResetImpl = true;
    if (!(*b_maxAngle <= 90.0)) {
      tunablePropChangedBeforeResetImpl = false;
    }

    if (!tunablePropChangedBeforeResetImpl) {
      y = NULL;
      m2 = emlrtCreateCharArray(2, iv15);
      emlrtInitCharArrayR2013a(&c_st, 19, m2, &d_u[0]);
      emlrtAssign(&y, m2);
      b_y = NULL;
      m2 = emlrtCreateCharArray(2, iv17);
      emlrtInitCharArrayR2013a(&c_st, 62, m2, &e_u[0]);
      emlrtAssign(&b_y, m2);
      b_error(&c_st, y, b_y, &c_emlrtMCI);
    }

    if (*b_maxAngle < minVal) {
      c_st.site = &emlrtRSI;
      y = NULL;
      m2 = emlrtCreateCharArray(2, iv16);
      emlrtInitCharArrayR2013a(&c_st, 22, m2, &varargin_1[0]);
      emlrtAssign(&y, m2);
      error(&c_st, y, &d_emlrtMCI);
    }

    obj->maxAngle = *b_maxAngle;
  }

  b_st.site = &k_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m2 = emlrtCreateCharArray(2, iv12);
    emlrtInitCharArrayR2013a(&b_st, 45, m2, &u[0]);
    emlrtAssign(&y, m2);
    b_y = NULL;
    m2 = emlrtCreateCharArray(2, iv14);
    emlrtInitCharArrayR2013a(&b_st, 5, m2, &c_u[0]);
    emlrtAssign(&b_y, m2);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  tunablePropChangedBeforeResetImpl = obj->TunablePropsChanged;
  if ((int32_T)tunablePropChangedBeforeResetImpl != (int32_T)
      obj->TunablePropsChanged) {
    y = NULL;
    m2 = emlrtCreateCharArray(2, iv13);
    emlrtInitCharArrayR2013a(&b_st, 44, m2, &b_u[0]);
    emlrtAssign(&y, m2);
    error(&b_st, message(&b_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_outputs(InstanceStruct_mv8cGpVyckrumJZio0klhD
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
  freedomboard_Servo *obj;
  boolean_T flag;
  const mxArray *y;
  const mxArray *m3;
  static const int32_T iv18[2] = { 1, 45 };

  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  real_T minVal;
  const mxArray *b_y;
  static const int32_T iv19[2] = { 1, 4 };

  static const int32_T iv20[2] = { 1, 51 };

  static char_T b_u[4] = { 's', 't', 'e', 'p' };

  static char_T c_u[51] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e',
    'd', 'W', 'h', 'e', 'n', 'L', 'o', 'c', 'k', 'e', 'd', 'R', 'e', 'l', 'e',
    'a', 's', 'e', 'd', 'C', 'o', 'd', 'e', 'g', 'e', 'n' };

  static const int32_T iv21[2] = { 1, 44 };

  static const int32_T iv22[2] = { 1, 19 };

  static char_T d_u[44] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's',
    't', 'e', 'm', ':', 'i', 'n', 'v', 'a', 'l', 'i', 'd', 'T', 'u', 'n', 'a',
    'b', 'l', 'e', 'M', 'o', 'd', 'A', 'c', 'c', 'e', 's', 's', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  static const int32_T iv23[2] = { 1, 44 };

  static const int32_T iv24[2] = { 1, 5 };

  static char_T e_u[19] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't',
    'L', 'e', 's', 's', 'E', 'q', 'u', 'a', 'l' };

  static char_T f_u[5] = { 's', 'e', 't', 'u', 'p' };

  static const int32_T iv25[2] = { 1, 22 };

  static char_T varargin_1[22] = { 'M', 'a', 'x', ' ', 'A', 'n', 'g', 'l', 'e',
    ' ', '<', '=', ' ', 'M', 'i', 'n', ' ', 'A', 'n', 'g', 'l', 'e' };

  static const int32_T iv26[2] = { 1, 62 };

  static char_T g_u[62] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'a', 'x', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '<', '=', ' ', '9', '0', '.' };

  static const int32_T iv27[2] = { 1, 19 };

  static const int32_T iv28[2] = { 1, 22 };

  static const int32_T iv29[2] = { 1, 62 };

  real_T *b_maxAngle;
  real_T *b_minAngle;
  b_minAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  b_maxAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 1);
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
    b_st.site = &g_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &f_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &h_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &h_emlrtRSI;
    Servo_set_minAngle(&b_st, &moduleInstance->sysobj, *b_minAngle);
    b_st.site = &i_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    minVal = moduleInstance->sysobj.minAngle;
    c_st.site = &emlrtRSI;
    flag = true;
    if (!(*b_maxAngle <= 90.0)) {
      flag = false;
    }

    if (!flag) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv27);
      emlrtInitCharArrayR2013a(&c_st, 19, m3, &e_u[0]);
      emlrtAssign(&y, m3);
      b_y = NULL;
      m3 = emlrtCreateCharArray(2, iv29);
      emlrtInitCharArrayR2013a(&c_st, 62, m3, &g_u[0]);
      emlrtAssign(&b_y, m3);
      b_error(&c_st, y, b_y, &c_emlrtMCI);
    }

    if (*b_maxAngle < minVal) {
      c_st.site = &emlrtRSI;
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv28);
      emlrtInitCharArrayR2013a(&c_st, 22, m3, &varargin_1[0]);
      emlrtAssign(&y, m3);
      error(&c_st, y, &d_emlrtMCI);
    }

    obj->maxAngle = *b_maxAngle;
  }

  if (!isequal(moduleInstance->sysobj.minAngle, *b_minAngle)) {
    b_st.site = &l_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &l_emlrtRSI;
    Servo_set_minAngle(&b_st, &moduleInstance->sysobj, *b_minAngle);
  }

  if (!isequal(moduleInstance->sysobj.maxAngle, *b_maxAngle)) {
    b_st.site = &m_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &m_emlrtRSI;
    obj = &moduleInstance->sysobj;
    minVal = moduleInstance->sysobj.minAngle;
    c_st.site = &emlrtRSI;
    flag = true;
    if (!(*b_maxAngle <= 90.0)) {
      flag = false;
    }

    if (!flag) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv22);
      emlrtInitCharArrayR2013a(&c_st, 19, m3, &e_u[0]);
      emlrtAssign(&y, m3);
      b_y = NULL;
      m3 = emlrtCreateCharArray(2, iv26);
      emlrtInitCharArrayR2013a(&c_st, 62, m3, &g_u[0]);
      emlrtAssign(&b_y, m3);
      b_error(&c_st, y, b_y, &c_emlrtMCI);
    }

    if (*b_maxAngle < minVal) {
      c_st.site = &emlrtRSI;
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv25);
      emlrtInitCharArrayR2013a(&c_st, 22, m3, &varargin_1[0]);
      emlrtAssign(&y, m3);
      error(&c_st, y, &d_emlrtMCI);
    }

    obj->maxAngle = *b_maxAngle;
  }

  b_st.site = &n_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m3 = emlrtCreateCharArray(2, iv18);
    emlrtInitCharArrayR2013a(&b_st, 45, m3, &u[0]);
    emlrtAssign(&y, m3);
    b_y = NULL;
    m3 = emlrtCreateCharArray(2, iv19);
    emlrtInitCharArrayR2013a(&b_st, 4, m3, &b_u[0]);
    emlrtAssign(&b_y, m3);
    error(&b_st, b_message(&b_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
  }

  if (obj->isInitialized != 1) {
    c_st.site = &d_emlrtRSI;
    d_st.site = &d_emlrtRSI;
    if (obj->isInitialized != 0) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv20);
      emlrtInitCharArrayR2013a(&d_st, 51, m3, &c_u[0]);
      emlrtAssign(&y, m3);
      b_y = NULL;
      m3 = emlrtCreateCharArray(2, iv24);
      emlrtInitCharArrayR2013a(&d_st, 5, m3, &f_u[0]);
      emlrtAssign(&b_y, m3);
      error(&d_st, b_message(&d_st, y, b_y, &e_emlrtMCI), &e_emlrtMCI);
    }

    obj->isInitialized = 1;
    e_st.site = &d_emlrtRSI;
    if (obj->TunablePropsChanged) {
      y = NULL;
      m3 = emlrtCreateCharArray(2, iv23);
      emlrtInitCharArrayR2013a(&e_st, 44, m3, &d_u[0]);
      emlrtAssign(&y, m3);
      error(&e_st, message(&e_st, y, &e_emlrtMCI), &e_emlrtMCI);
    }

    obj->TunablePropsChanged = false;
  }

  c_st.site = &d_emlrtRSI;
  if (obj->TunablePropsChanged) {
    obj->TunablePropsChanged = false;
  }

  c_st.site = &d_emlrtRSI;
  if (obj->TunablePropsChanged) {
    y = NULL;
    m3 = emlrtCreateCharArray(2, iv21);
    emlrtInitCharArrayR2013a(&c_st, 44, m3, &d_u[0]);
    emlrtAssign(&y, m3);
    error(&c_st, message(&c_st, y, &e_emlrtMCI), &e_emlrtMCI);
  }

  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_update(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance)
{
  cgxertSetGcb(moduleInstance->S, -1, -1);
  cgxertRestoreGcb(moduleInstance->S, -1, -1);
}

static void cgxe_mdl_terminate(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emlrtStack b_st;
  emlrtStack c_st;
  freedomboard_Servo *obj;
  emlrtStack d_st;
  const mxArray *y;
  emlrtStack e_st;
  boolean_T flag;
  const mxArray *m4;
  static const int32_T iv30[2] = { 1, 45 };

  static char_T u[45] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'y', 's', 't',
    'e', 'm', ':', 'm', 'e', 't', 'h', 'o', 'd', 'C', 'a', 'l', 'l', 'e', 'd',
    'W', 'h', 'e', 'n', 'R', 'e', 'l', 'e', 'a', 's', 'e', 'd', 'C', 'o', 'd',
    'e', 'g', 'e', 'n' };

  const mxArray *b_y;
  static const int32_T iv31[2] = { 1, 8 };

  static char_T b_u[8] = { 'i', 's', 'L', 'o', 'c', 'k', 'e', 'd' };

  static const int32_T iv32[2] = { 1, 45 };

  static const int32_T iv33[2] = { 1, 7 };

  static char_T c_u[7] = { 'r', 'e', 'l', 'e', 'a', 's', 'e' };

  real_T minVal;
  static const int32_T iv34[2] = { 1, 19 };

  static char_T d_u[19] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'n', 'o', 't',
    'L', 'e', 's', 's', 'E', 'q', 'u', 'a', 'l' };

  static const int32_T iv35[2] = { 1, 22 };

  static char_T varargin_1[22] = { 'M', 'a', 'x', ' ', 'A', 'n', 'g', 'l', 'e',
    ' ', '<', '=', ' ', 'M', 'i', 'n', ' ', 'A', 'n', 'g', 'l', 'e' };

  static const int32_T iv36[2] = { 1, 62 };

  static char_T e_u[62] = { 'E', 'x', 'p', 'e', 'c', 't', 'e', 'd', ' ', 'm',
    'a', 'x', 'A', 'n', 'g', 'l', 'e', ' ', 't', 'o', ' ', 'b', 'e', ' ', 'a',
    'n', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'w', 'i', 't', 'h', ' ', 'a', 'l',
    'l', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'v', 'a', 'l', 'u', 'e', 's',
    ' ', '<', '=', ' ', '9', '0', '.' };

  real_T *b_minAngle;
  real_T *b_maxAngle;
  b_maxAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 1);
  b_minAngle = (real_T *)cgxertGetRunTimeParamInfoData(moduleInstance->S, 0);
  st.tls = moduleInstance->emlrtRootTLSGlobal;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  emlrtDestroyArray(&b_eml_mx);
  emlrtDestroyArray(&eml_mx);
  cgxertSetGcb(moduleInstance->S, -1, -1);
  if (!moduleInstance->sysobj_not_empty) {
    b_st.site = &g_emlrtRSI;
    obj = &moduleInstance->sysobj;
    c_st.site = &emlrtRSI;
    d_st.site = &b_emlrtRSI;
    e_st.site = &c_emlrtRSI;
    d_st.site = &b_emlrtRSI;
    obj->isInitialized = 0;
    obj->TunablePropsChanged = false;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    c_st.site = &emlrtRSI;
    d_st.site = &f_emlrtRSI;
    moduleInstance->sysobj_not_empty = true;
    b_st.site = &h_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &h_emlrtRSI;
    Servo_set_minAngle(&b_st, &moduleInstance->sysobj, *b_minAngle);
    b_st.site = &i_emlrtRSI;
    flag = (moduleInstance->sysobj.isInitialized == 1);
    if (flag) {
      moduleInstance->sysobj.TunablePropsChanged = true;
    }

    b_st.site = &i_emlrtRSI;
    obj = &moduleInstance->sysobj;
    minVal = moduleInstance->sysobj.minAngle;
    c_st.site = &emlrtRSI;
    flag = true;
    if (!(*b_maxAngle <= 90.0)) {
      flag = false;
    }

    if (!flag) {
      y = NULL;
      m4 = emlrtCreateCharArray(2, iv34);
      emlrtInitCharArrayR2013a(&c_st, 19, m4, &d_u[0]);
      emlrtAssign(&y, m4);
      b_y = NULL;
      m4 = emlrtCreateCharArray(2, iv36);
      emlrtInitCharArrayR2013a(&c_st, 62, m4, &e_u[0]);
      emlrtAssign(&b_y, m4);
      b_error(&c_st, y, b_y, &c_emlrtMCI);
    }

    if (*b_maxAngle < minVal) {
      c_st.site = &emlrtRSI;
      y = NULL;
      m4 = emlrtCreateCharArray(2, iv35);
      emlrtInitCharArrayR2013a(&c_st, 22, m4, &varargin_1[0]);
      emlrtAssign(&y, m4);
      error(&c_st, y, &d_emlrtMCI);
    }

    obj->maxAngle = *b_maxAngle;
  }

  b_st.site = &o_emlrtRSI;
  obj = &moduleInstance->sysobj;
  if (moduleInstance->sysobj.isInitialized == 2) {
    y = NULL;
    m4 = emlrtCreateCharArray(2, iv30);
    emlrtInitCharArrayR2013a(&b_st, 45, m4, &u[0]);
    emlrtAssign(&y, m4);
    b_y = NULL;
    m4 = emlrtCreateCharArray(2, iv31);
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
      m4 = emlrtCreateCharArray(2, iv32);
      emlrtInitCharArrayR2013a(&b_st, 45, m4, &u[0]);
      emlrtAssign(&y, m4);
      b_y = NULL;
      m4 = emlrtCreateCharArray(2, iv33);
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
  (InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance)
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
  m5 = emlrtCreateDoubleScalar(moduleInstance->sysobj.minAngle);
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "minAngle", 0);
  c_y = NULL;
  m5 = emlrtCreateDoubleScalar(moduleInstance->sysobj.maxAngle);
  emlrtAssign(&c_y, m5);
  emlrtAddField(b_y, c_y, "maxAngle", 0);
  emlrtSetCell(y, 0, b_y);
  b_y = NULL;
  m5 = emlrtCreateLogicalScalar(moduleInstance->sysobj_not_empty);
  emlrtAssign(&b_y, m5);
  emlrtSetCell(y, 1, b_y);
  emlrtAssign(&st, y);
  return st;
}

static freedomboard_Servo emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *b_sysobj, const char_T *identifier)
{
  freedomboard_Servo y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(b_sysobj), &thisId);
  emlrtDestroyArray(&b_sysobj);
  return y;
}

static freedomboard_Servo b_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *u, const emlrtMsgIdentifier *parentId)
{
  freedomboard_Servo y;
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[4] = { "isInitialized", "TunablePropsChanged",
    "minAngle", "maxAngle" };

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
  thisId.fIdentifier = "minAngle";
  y.minAngle = e_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0,
    "minAngle")), &thisId);
  thisId.fIdentifier = "maxAngle";
  y.maxAngle = e_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0,
    "maxAngle")), &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static int32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  int32_T y;
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static boolean_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray
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

static void cgxe_mdl_set_sim_state(InstanceStruct_mv8cGpVyckrumJZio0klhD
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
  moduleInstance->sysobj_not_empty = f_emlrt_marshallIn(&b_st, emlrtAlias
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

static int32_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  int32_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "int32", false, 0U, &dims);
  ret = *(int32_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static boolean_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  boolean_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "logical", false, 0U, &dims);
  ret = *mxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void init_simulink_io_address(InstanceStruct_mv8cGpVyckrumJZio0klhD
  *moduleInstance)
{
  moduleInstance->emlrtRootTLSGlobal = (void *)cgxertGetEMLRTCtx
    (moduleInstance->S);
  moduleInstance->u0 = (real32_T *)cgxertGetInputPortSignal(moduleInstance->S, 0);
}

/* CGXE Glue Code */
static void mdlOutputs_mv8cGpVyckrumJZio0klhD(SimStruct *S, int_T tid)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_outputs(moduleInstance);
}

static void mdlInitialize_mv8cGpVyckrumJZio0klhD(SimStruct *S)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_initialize(moduleInstance);
}

static void mdlUpdate_mv8cGpVyckrumJZio0klhD(SimStruct *S, int_T tid)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_update(moduleInstance);
}

static mxArray* getSimState_mv8cGpVyckrumJZio0klhD(SimStruct *S)
{
  mxArray* mxSS;
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  mxSS = (mxArray *) cgxe_mdl_get_sim_state(moduleInstance);
  return mxSS;
}

static void setSimState_mv8cGpVyckrumJZio0klhD(SimStruct *S, const mxArray *ss)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_set_sim_state(moduleInstance, emlrtAlias(ss));
}

static void mdlTerminate_mv8cGpVyckrumJZio0klhD(SimStruct *S)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_terminate(moduleInstance);
  free((void *)moduleInstance);
}

static void mdlStart_mv8cGpVyckrumJZio0klhD(SimStruct *S)
{
  InstanceStruct_mv8cGpVyckrumJZio0klhD *moduleInstance =
    (InstanceStruct_mv8cGpVyckrumJZio0klhD *)calloc(1, sizeof
    (InstanceStruct_mv8cGpVyckrumJZio0klhD));
  moduleInstance->S = S;
  cgxertSetRuntimeInstance(S, (void *)moduleInstance);
  ssSetmdlOutputs(S, mdlOutputs_mv8cGpVyckrumJZio0klhD);
  ssSetmdlInitializeConditions(S, mdlInitialize_mv8cGpVyckrumJZio0klhD);
  ssSetmdlUpdate(S, mdlUpdate_mv8cGpVyckrumJZio0klhD);
  ssSetmdlTerminate(S, mdlTerminate_mv8cGpVyckrumJZio0klhD);
  cgxe_mdl_start(moduleInstance);

  {
    uint_T options = ssGetOptions(S);
    options |= SS_OPTION_RUNTIME_EXCEPTION_FREE_CODE;
    ssSetOptions(S, options);
  }
}

static void mdlProcessParameters_mv8cGpVyckrumJZio0klhD(SimStruct *S)
{
}

void method_dispatcher_mv8cGpVyckrumJZio0klhD(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_mv8cGpVyckrumJZio0klhD(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_mv8cGpVyckrumJZio0klhD(S);
    break;

   case SS_CALL_MDL_GET_SIM_STATE:
    *((mxArray**) data) = getSimState_mv8cGpVyckrumJZio0klhD(S);
    break;

   case SS_CALL_MDL_SET_SIM_STATE:
    setSimState_mv8cGpVyckrumJZio0klhD(S, (const mxArray *) data);
    break;

   default:
    /* Unhandled method */
    /*
       sf_mex_error_message("Stateflow Internal Error:\n"
       "Error calling method dispatcher for module: mv8cGpVyckrumJZio0klhD.\n"
       "Can't handle method %d.\n", method);
     */
    break;
  }
}

mxArray *cgxe_mv8cGpVyckrumJZio0klhD_BuildInfoUpdate(void)
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
  elem_9 = mxCreateString("freedomboard.Servo");
  mxSetCell(elem_8,0,elem_9);
  mxSetCell(mxBIArgs,1,elem_8);
  elem_10 = mxCreateCellMatrix(1,0);
  mxSetCell(mxBIArgs,2,elem_10);
  return mxBIArgs;
}

mxArray *cgxe_mv8cGpVyckrumJZio0klhD_fallback_info(void)
{
  const char* fallbackInfoFields[] = { "fallbackType", "incompatiableSymbol" };

  mxArray* fallbackInfoStruct = mxCreateStructMatrix(1, 1, 2, fallbackInfoFields);
  mxArray* fallbackType = mxCreateString("thirdPartyLibs");
  mxArray* incompatibleSymbol = mxCreateString("freedomboard.Servo");
  mxSetFieldByNumber(fallbackInfoStruct, 0, 0, fallbackType);
  mxSetFieldByNumber(fallbackInfoStruct, 0, 1, incompatibleSymbol);
  return fallbackInfoStruct;
}
