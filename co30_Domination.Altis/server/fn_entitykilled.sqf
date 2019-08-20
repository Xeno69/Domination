// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_entitykilled.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

private _ar = _obj getVariable "d_hkx";
if (isNil "_ar") exitWith {
	__TRACE_1("does not have d_hkx","_obj")
	true
};

__TRACE_2("","_obj","_ar")

#ifdef __TT__
if (!d_with_ace || {d_with_ace && {local _obj}}) then {
	private _val =  _ar # 0;
	if (_val > 0) then {
		__TRACE_1("","_val")
		call {
			if (_val == 1) exitWith {
				[[15, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_val == 2) exitWith {
				[[20, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_val == 3) exitWith {
				[[30, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
		};
	};
	
	if (_ar # 1 == 1) then {
		_this call d_fnc_checkveckillblufor;
	};

	if (_ar # 2 == 1) then {
		_this call d_fnc_checkveckillopfor;
	};
};
if (!isNil "d_is_hc") exitWith {true};
#endif

if (_ar # 3 == 1) then {
	_obj setVariable ["d_dead", true];
	_obj call d_fnc_onerespukilled;
};

private _val = _ar # 4;
if (_val > 0) then {
	__TRACE_1("","_val")
	call {
		if (_val == 1) exitWith {
			[8, _this # 1] call d_fnc_addkillsai
		};
		if (_val == 2) exitWith {
			[5, _this # 1] call d_fnc_addkillsai
		};
		if (_val == 3) exitWith {
			[8, _this # 1] call d_fnc_addkillsai
		};
	};
};

if (_ar # 5 == 1) then {
	_obj call d_fnc_handleDeadVec
};

if (_ar # 6 == 1) then {
	addToRemainsCollector [_obj];
};

if (_ar # 7 == 1) then {
	{_obj deleteVehicleCrew _x} forEach (crew _obj);
};

if (_ar # 8 == 1) then {
	_obj call d_fnc_chopperkilled;
};

if (_ar # 9 == 1) then {
	_obj call d_fnc_fuelCheck;
};

if (_ar # 10 == 1) then {
	_obj call d_fnc_mhqmsg;
};

if (_ar # 11 == 1) then {
	[_obj, 0] remoteExecCall ["setFuel", _obj];
	_obj call d_fnc_bonusvecfnc;
};

if (_ar # 12 == 1) then {
	_obj call d_fnc_aboxkilled;
};

if (_ar # 13 == 1) then {
	_obj call d_fnc_PlacedObjKilled;
};

if (_ar # 14 == 1) then {
	[_obj, 1] call d_fnc_removeMHQEnemyTeleTrig;
};

if (_ar # 15 == 1) then {
	d_sm_flag_failed = true;
};

if (_ar # 16 == 1) then {
	d_sm_arrest_mp_unit = nil;
	d_sm_arrest_not_failed = false;
};

_obj setVariable ["d_hkx", nil];

true