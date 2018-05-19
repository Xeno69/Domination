// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_xdelct.sqf"
#include "..\..\x_setup.sqf"

deleteVehicle d_current_trigger;
if (!isNil "d_f_check_triggers") then {
	{
		deleteVehicle _x;
	} forEach d_f_check_triggers;
};
