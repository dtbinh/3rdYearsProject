/* Include files */

#include "frdmslx_cgxe.h"
#include "m_mv8cGpVyckrumJZio0klhD.h"
#include "m_X0MJCmMFbkIaTP5xyiIxaB.h"

unsigned int cgxe_frdmslx_method_dispatcher(SimStruct* S, int_T method, void
  * data)
{
  if (ssGetChecksum0(S) == 1826749651 &&
      ssGetChecksum1(S) == 995254540 &&
      ssGetChecksum2(S) == 1287114377 &&
      ssGetChecksum3(S) == 601280611) {
    method_dispatcher_mv8cGpVyckrumJZio0klhD(S, method, data);
    return 1;
  }

  if (ssGetChecksum0(S) == 1874577086 &&
      ssGetChecksum1(S) == 3916249773 &&
      ssGetChecksum2(S) == 3546458581 &&
      ssGetChecksum3(S) == 3051527477) {
    method_dispatcher_X0MJCmMFbkIaTP5xyiIxaB(S, method, data);
    return 1;
  }

  return 0;
}
