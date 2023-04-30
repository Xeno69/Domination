// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_mt_spotted = false;
d_mt_radio_down = true;
if (d_ao_markers == 1) then {
	deleteMarker "d_m_t_rt";
};
#ifndef __TT__
if (d_force_isstreamfriendlyui == 1) then {
	[63] call d_fnc_DoKBMsg;
} else {
	[37] call d_fnc_DoKBMsg;
};
#else
[38] call d_fnc_DoKBMsg;
private _killer = _this # 2;
if (isNull _killer) then {
	if (!d_with_ace) then {
		_killer = (_this # 0) getVariable ["d_last_damager", _killer];
	} else {
		_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
	};
};
if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
	[d_tt_points # 2, _killer, false] call d_fnc_AddPoints;
	if (side (group _killer) == blufor) then {
		[39, "WEST"] call d_fnc_DoKBMsg;
	} else {
		if (side (group _killer) == opfor) then {
			[39, "EAST"] call d_fnc_DoKBMsg
		};
	};
};
#endif
(_this # 0) spawn {
	scriptName "spawn checkmthardtarget";
	if (isNil {_this getVariable "d_faster"}) then {
		sleep (60 + random 60);
	} else {
		sleep 1;
	};
	_this setDamage 0;
	deleteVehicle _this;
};
if (d_database_found) then {
#ifndef __TT__
	private _killer = _this # 2;
	if (isNull _killer) then {
		if (!d_with_ace) then {
			_killer = (_this # 0) getVariable ["d_last_damager", _killer];
		} else {
			_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};
#endif
	if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
		[_killer, 1] call d_fnc_addppoints;
	};
};
(_this # 0) removeAllEventHandlers "killed";
