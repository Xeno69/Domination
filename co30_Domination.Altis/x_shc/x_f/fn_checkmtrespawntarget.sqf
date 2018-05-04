// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmtrespawntarget.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_vec", "_type"]; // type 0 = barracks, 1 = vehicles

if (_type == 0) then {
	_vec addEventHandler ["killed", {
		d_mt_barracks_down = true;
		[missionNamespace, ["d_mt_barracks_down", true]] remoteExecCall ["setVariable", 2];
		[51] remoteExecCall ["d_fnc_DoKBMsg", 2];
		(param [0]) spawn {
			sleep (10 + random 10);
			_this setDamage 0;
			deleteVehicle _this;
		};
		(param [0]) removeAllEventHandlers "killed";
		if (d_database_found) then {
			private _killer = param [2];
			if (isNull _killer) then {
				if (!d_with_ace) then {
					_killer = (param [0]) getVariable ["d_last_damager", _killer];
				} else {
					_killer = (param [0]) getVariable ["ace_medical_lastDamageSource", _killer];
				};
			};
			if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
				[_killer, 5] remoteExecCall ["addScore", 2];
			};
		};
	}];
} else {
	_vec addEventHandler ["killed", {
		d_mt_mobile_hq_down = true;
		[missionNamespace, ["d_mt_mobile_hq_down", true]] remoteExecCall ["setVariable", 2];
		[53] remoteExecCall ["d_fnc_DoKBMsg", 2];
		(param [0]) spawn {
			sleep (60 + random 60);
			_this setDamage 0;
			deleteVehicle _this;
		};
		(param [0]) removeAllEventHandlers "killed";
		if (d_database_found) then {
			private _killer = param [2];
			if (isNull _killer) then {
				if (!d_with_ace) then {
					_killer = (param [0]) getVariable ["d_last_damager", _killer];
				} else {
					_killer = (param [0]) getVariable ["ace_medical_lastDamageSource", _killer];
				};
			};
			if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
				[_killer, 5] remoteExecCall ["addScore", 2];
			};
		};
	}];
};
_vec addEventHandler ["handleDamage", {_this call d_fnc_CheckMTShotHD}];