// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")
playSound "d_Notebook";
if (d_with_ranked || {d_database_found}) then {
	d_sm_running = false
};
_this spawn d_fnc_sidemissionwinner;