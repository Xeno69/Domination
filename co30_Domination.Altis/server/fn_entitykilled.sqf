// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_entitykilled.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

if (isNil {_obj getVariable "d_hkx"}) exitWith {
	__TRACE_1("does not have d_hkx","_obj")
	true
};

#ifdef __TT__
if (!d_with_ace || {d_with_ace && {local _obj}}) then {
	private _ktypett =  _obj getVariable "d_ktypett";
	if (!isNil "_ktypett") then {
		__TRACE_1("","_ktypett")
		call {
			if (_ktypett == 1) exitWith {
				[[15, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_ktypett == 2) exitWith {
				[[20, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
			if (_ktypett == 3) exitWith {
				[[30, 3, 2, 1], _this # 1, _this # 0, _this # 2] call d_fnc_AddKills
			};
		};
		_obj setVariable ["d_ktypett", nil];
	};
	
	private _cvkblu = _obj getVariable "d_cvkblu";
	if (!isNil "_cvkblu") then {
		__TRACE_1("","_cvkblu")
		_this call d_fnc_checkveckillblufor;
		_obj setVariable ["d_cvkblu", nil];
	};

	private _cvkopf = _obj getVariable "d_cvkopf";
	if (!isNil "_cvkopf") then {
		__TRACE_1("","_cvkopf")
		_this call d_fnc_checkveckillopfor;
		_obj setVariable ["d_cvkopf", nil];
	};
};
if (!isNil "d_is_hc") exitWith {true};
#endif

private _onerespk = _obj getVariable "d_onerespk";
if (!isNil "_onerespk") then {
	__TRACE_1("","_onerespk")
	_obj call d_fnc_onerespukilled;
	_obj setVariable ["d_onerespk", nil];
};

private _ktypeai = _obj getVariable "d_ktypeai";
if (!isNil "_ktypeai") then {
	__TRACE_1("","_ktypeai")
	call {
		if (_ktypeai == 1) exitWith {
			[8, _this # 1] call d_fnc_addkillsai
		};
		if (_ktypeai == 2) exitWith {
			[5, _this # 1] call d_fnc_addkillsai
		};
		if (_ktypeai == 3) exitWith {
			[8, _this # 1] call d_fnc_addkillsai
		};
	};
	_obj setVariable ["d_ktypeai", nil];
};

private _ktype = _obj getVariable "d_ktype";
if (!isNil "_ktype") then {
	__TRACE_1("","_ktype")
	if (_ktype == 1) then {
		_obj call d_fnc_handleDeadVec
	};
	_obj setVariable ["d_ktype", nil];
};

private _sikill = _obj getVariable "d_sidekill";
if (!isNil "_sikill") then {
	__TRACE_1("","_ktype")
	addToRemainsCollector [_obj];
	_obj setVariable ["d_sidekill", nil];
};

private _delcrewk = _obj getVariable "d_delcrewk";
if (!isNil "_delcrewk") then {
	__TRACE_1("","_delcrewk")
	{_obj deleteVehicleCrew _x} forEach (crew _obj);
	_obj setVariable ["d_delcrewk", nil];
};

private _chkill = _obj getVariable "d_chkill";
if (!isNil "_chkill") then {
	__TRACE_1("","_chkill")
	_obj call d_fnc_chopperkilled;
	_obj setVariable ["_chkill", nil];
};

private _fuelc = _obj getVariable "d_fuelc";
if (!isNil "_fuelc") then {
	__TRACE_1("","_fuelc")
	_obj call d_fnc_fuelCheck;
	_obj setVariable ["d_fuelc", nil];
};

private _mhqmsg = _obj getVariable "d_mhqmsg";
if (!isNil "_mhqmsg") then {
	__TRACE_1("","_mhqmsg")
	_obj call d_fnc_mhqmsg;
	_obj setVariable ["d_mhqmsg", nil];
};

private _prebo = _obj getVariable "d_prebo";
if (!isNil "_prebo") then {
	__TRACE_1("","_prebo")
	[_obj, 0] remoteExecCall ["setFuel", _obj];
	_obj call d_fnc_bonusvecfnc;
	_obj setVariable ["d_prebo", nil];
};

private _boxk = _obj getVariable "d_boxk";
if (!isNil "_boxk") then {
	__TRACE_1("","_boxk")
	_obj call d_fnc_aboxkilled;
	_obj setVariable ["d_boxk", nil];
};

private _plok = _obj getVariable "d_plok";
if (!isNil "_plok") then {
	__TRACE_1("","_plok")
	_obj call d_fnc_PlacedObjKilled;
	_obj setVariable ["d_plok", nil];
};

private _mhqf = _obj getVariable "d_mhqf";
if (!isNil "_mhqf") then {
	__TRACE_1("","_mhqf")
	_obj call d_fnc_removeMHQEnemyTeleTrig;
	_obj setVariable ["d_mhqf", nil];
};

private _flago = _obj getVariable "d_flago";
if (!isNil "_flago") then {
	__TRACE_1("","_flago")
	d_sm_flag_failed = true;
	_obj setVariable ["d_flago", nil];
};

private _sarrest = _obj getVariable "d_sarrest";
if (!isNil "_sarrest") then {
	__TRACE_1("","_sarrest")
	d_sm_arrest_mp_unit = nil;
	d_sm_arrest_not_failed = false;
	_obj setVariable ["d_sarrest", nil];
};

_obj setVariable ["d_hkx", nil];

true