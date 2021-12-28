// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

params ["_dragger"];

while {player getVariable ["xr_dragged", false]} do {
	if (isNull _dragger) exitWith {
		if ((alive player && {player getVariable "xr_pluncon"}) || {!alive player}) then {
			[player, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[player, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
	};
	sleep 0.5;
};

//__TRACE("stopped")