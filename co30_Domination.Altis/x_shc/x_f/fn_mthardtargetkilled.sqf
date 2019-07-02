// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mthardtargetkilled.sqf"
#include "..\..\x_setup.sqf"

d_mt_spotted = false;
d_mt_radio_down = true;
deleteMarker "d_main_target_radiotower";
#ifndef __TT__
[37] call d_fnc_DoKBMsg;
#else
[38] call d_fnc_DoKBMsg;
private _killer = _this select 2;
if (isNull _killer) then {
	if (!d_with_ace) then {
		_killer = (_this select 0) getVariable ["d_last_damager", _killer];
	} else {
		_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", _killer];
	};
};
if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
	[d_tt_points # 2, _killer] call d_fnc_AddPoints;
	switch (side (group _killer)) do {
		case blufor: {[39, "WEST"] call d_fnc_DoKBMsg};
		case opfor: {[39, "EAST"] call d_fnc_DoKBMsg};
	};
};
#endif
(_this select 0) spawn {
	scriptName "spawn checkmthardtarget";
	sleep (60 + random 60);
	_this setDamage 0;
	deleteVehicle _this;
};
if (d_database_found) then {
#ifndef __TT__
	private _killer = _this select 2;
	if (isNull _killer) then {
		if (!d_with_ace) then {
			_killer = (_this select 0) getVariable ["d_last_damager", _killer];
		} else {
			_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};
#endif
	if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
		[_killer, 1] call d_fnc_addppoints;
	};
};
(_this select 0) removeAllEventHandlers "killed";