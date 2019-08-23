// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ispilotcheck.sqf"
#include "..\x_setup.sqf"

(toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) find "pilot" > -1})