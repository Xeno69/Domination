// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

private _isman = false;

if (_obj isKindOf "CAManBase") then {
	_isman = true;
	if (_obj getHitIndex 2 == 1 || {_obj getHitIndex 0 == 1}) then {
		private _insti = _this # 2;
		if (!isNull _insti && {isNull objectParent _insti && {isPlayer _insti}}) then {
			[_insti, _insti distance2D _obj] spawn d_fnc_addheadshot;
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
	if (d_with_MainTargetEvents != 0) then {
		if (_ar # 19 == 1) then {
			d_priority_targets = [];
			publicVariable "d_priority_targets";
			[_obj, 19, 0] call d_fnc_setekmode;
		};
	};
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

if !(_isman) then {
	if (isPlayer (_this # 2)) then {
		_this spawn d_fnc_bv_check;
	};
};

private _quit = false;
if (_ar # 3 == 1) then {
	_obj setVariable ["d_dead", true];
	if (_isman) then {
		_quit = true;
	};
	[_obj, _quit] spawn d_fnc_onerespukilled;
};
if (_quit) exitWith {true};

if (d_ai_persistent_corpses != 0) then {
	if (_ar # 20 == 1) exitWith {
		if (!isNull (_this # 1) && {(_this # 1) distance2D _obj > 30}) then {
			_obj spawn d_fnc_delobju;
		};
		true;
	};
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
	call d_fnc_handleDeadVec;
};

if (_ar # 6 == 1) then {
	addToRemainsCollector [_obj];
};

if (_ar # 7 == 1) then {
	private _cr = _obj getVariable "d_uav_crew";
	deleteVehicleCrew _obj;
	if (!isNil "_cr") then {
		_cr = _cr - [objNull];
		if (_cr isNotEqualTo []) then {
			deleteVehicle _cr;
		};
	};
};

if (_ar # 8 == 1) then {
	call d_fnc_chopperkilled;
};

if (_ar # 9 == 1) then {
	call d_fnc_fuelCheck;
};

if (_ar # 10 == 1) then {
	call d_fnc_mhqmsg;
};

if (_ar # 11 == 1) then {
	[_obj, 0] remoteExecCall ["setFuel", _obj];
	call d_fnc_bonusvecfnc;
};

if (_ar # 12 == 1) then {
	call d_fnc_aboxkilled;
};

if (_ar # 13 == 1) then {
	call d_fnc_PlacedObjKilled;
};

if (_ar # 14 == 1) then {
	[_obj, 1] call d_fnc_removeMHQEnemyTeleTrig;
};

if (_ar # 17 == 1) then {
	[_obj, 0] remoteExec ["setFeatureType", [0, -2] select isDedicated];
	_obj setFuel 0.05;
};

if (d_with_MainTargetEvents != 0 && {_ar # 19 == 1}) then {
	if (_obj in d_priority_targets) then {
		d_priority_targets deleteAt (d_priority_targets find _obj);
		publicVariable "d_priority_targets";
		[_obj, 19, 0] call d_fnc_setekmode;
	};
};

_obj setVariable ["d_hkx", nil];

true
