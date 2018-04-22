// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankstring.sqf"
#include "..\..\x_setup.sqf"

getText(configFile>>"CfgRanks">>str(_this call d_fnc_getrankindex)>>"displayName")
