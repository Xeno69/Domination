// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

if (d_database_found) then {
	if (_obj isKindOf "CAManBase" && {_obj getHitIndex 2 == 1 || {_obj getHitIndex 0 == 1}}) then {
		private _insti = _this # 2;
		if (!isNull _insti && {isNull objectParent _insti && {isPlayer _insti}}) then {
			_insti call d_fnc_addheadshot;
		};
	};
};

private _ar = _obj getVariable "d_hkx";
if (isNil "_ar") exitWith {
	__TRACE_1("does not have d_hkx","_obj")
	true
};

__TRACE_2("","_obj","_ar")

#ifndef __TT__
if (_ar # 18 == 1) exitWith {
	call d_fnc_plcheckkill;
	true
};
#else
if (!d_with_ace || {d_with_ace && {local _obj}}) then {
	if (_ar # 0 > 0) then {
		call {
			if (_ar # 0 == 1) exitWith {
				[[15, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_ar # 0 == 2) exitWith {
				[[20, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_ar # 0 == 3) exitWith {
				[[30, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
		};
	};
	
	if (_ar # 1 == 1) then {
		call d_fnc_checkveckillblufor;
	};

	if (_ar # 2 == 1) then {
		call d_fnc_checkveckillopfor;
	};
};
if (!isNil "d_is_hc") exitWith {true};
#endif

if !(_obj isKindOf "CAManBase") then {
#ifndef __TT__
	if (isPlayer (_this # 2) && {vehicle (_this # 2) inArea d_base_array && {_obj inArea d_base_array}}) then {
		call d_fnc_bv_check;
	};
#else
	if (isPlayer (_this # 2) && {vehicle (_this # 2) inArea (d_base_array # 0) && {_obj inArea (d_base_array # 0) || {vehicle (_this # 2) inArea (d_base_array # 1) && _obj inArea (d_base_array # 1)}}}}) then {
		call d_fnc_bv_check;
	};
#endif
};

if (_ar # 3 == 1) then {
	_obj setVariable ["d_dead", true];
	_obj call d_fnc_onerespukilled;
};

if (_ar # 4 > 0) then {
	call {
		if (_ar # 4 == 1) exitWith {
			[8, _this # 1, _this # 2] spawn d_fnc_addkillsai
		};
		if (_ar # 4 == 2) exitWith {
			[5, _this # 1, _this # 2] spawn d_fnc_addkillsai
		};
		if (_ar # 4 == 3) exitWith {
			[8, _this # 1, _this # 2] spawn d_fnc_addkillsai
		};
	};
};

if (_ar # 15 == 1) then {
	d_sm_flag_failed = true;
};

if (_ar # 16 == 1) then {
	d_sm_arrest_mp_unit = nil;
	d_sm_arrest_not_failed = false;
};

if (_ar # 5 == 1) then {
	_obj call d_fnc_handleDeadVec;
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

if (_ar # 17 == 1) then {
	[_obj, 0] remoteExec ["setFeatureType", [0, -2] select isDedicated];
	_obj setFuel 0.05;
};

_obj setVariable ["d_hkx", nil];

true
