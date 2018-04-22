// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerLocal.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")
if (hasInterface && {d_with_bis_dynamicgroups == 0}) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
};
player enableAttack false;

if (hasInterface) then {
	private _np = profileName splitString """'" joinString "";
	//  && {!(_np isEqualTo "Error: No unit")})
	if !(_np isEqualTo (player getVariable ["d_plname", ""])) then {
		player setVariable ["d_plname", _np, true];
	};
	d_name_pl = _np;
};

execVM "tasks.sqf";
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];