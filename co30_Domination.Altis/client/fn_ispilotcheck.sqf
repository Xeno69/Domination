// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ispilotcheck.sqf"
#include "..\x_setup.sqf"

if (d_gmcwg) exitWith {
	toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) == "gm_ge_headgear_sph4_oli"}
};
if (d_unsung) exitWith {
	toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) find "pilot" > -1 || {toLowerANSI (headgear player) find "jp_helmet" > -1} || {toLowerANSI (headgear player) find "hp_helmet" > -1}}
};

toLowerANSI (uniform player) find "pilot" > -1 && {toLowerANSI (headgear player) find "pilot" > -1}
