// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draghelper.sqf"
#include "..\x_macros.sqf"

params ["_dragger"];

while {player getVariable ["xr_dragged", false]} do {
	if (isNull _dragger) exitWith {
		if ((alive player && {player getVariable ["xr_pluncon", false]}) || {!alive player}) then {
			[player, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[player, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
	};
	sleep 0.5;
};

__TRACE("stopped")