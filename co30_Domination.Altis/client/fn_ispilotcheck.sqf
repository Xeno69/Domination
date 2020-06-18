// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ispilotcheck.sqf"
#include "..\x_setup.sqf"

#ifndef __GMCWGW__
(toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) find "pilot" > -1})
#else
(toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) == "gm_ge_headgear_sph4_oli"})
#endif