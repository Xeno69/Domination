// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_vec", "_type"]; // type 0 = barracks, 1 = vehicles

call {
	if (_type == 0) exitWith {
		_vec addEventHandler ["killed", {call d_fnc_mtrestkilled0}];
	};
	if (_type == 1) exitWith {
		_vec addEventHandler ["killed", {call d_fnc_mtrestkilled1}];
	};
};
if (d_MTTowerSatchelsOnly == 0) then {
	_vec addEventHandler ["handleDamage", {call d_fnc_CheckMTShotHD}];
};