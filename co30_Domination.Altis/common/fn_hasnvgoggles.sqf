// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hasnvgoggles.sqf"
#include "..\x_setup.sqf"

(getText(configFile>>"CfgWeapons">>(hmd _this)>>"simulation") == "NVGoggles")