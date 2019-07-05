// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_entitykilled.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

#ifdef __TT__
if (!d_with_ace || {d_with_ace && {local _obj}}) then {
	private _ktypett =  _obj getVariable "d_ktypett";
	if (!isNil "_ktypett") then {
		__TRACE_1("","_ktypett")
		call {
			if (_ktypett == 1) exitWith {
				[[15, 3, 2, 1], _this # 1, _this # 0] call d_fnc_AddKills
			};
			if (_ktypett == 2) exitWith {
				[[20, 3, 2, 1], _this # 1, _this # 0] call d_fnc_AddKills
			};
			if (_ktypett == 3) exitWith {
				[[30, 3, 2, 1], _this # 1, _this # 0] call d_fnc_AddKills
			};
		};
		_obj setVariable ["d_ktypett", nil];
	};
};
if (!isNil "d_is_hc") exitWith {true};
#endif

private _onerespk = _obj getVariable "d_onerespk";
if (!isNil "_onerespk") then {
	__TRACE_1("","_onerespk")
	_this call d_fnc_onerespukilled;
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
		_this call d_fnc_handleDeadVec
	};
	_obj setVariable ["d_ktype", nil];
};

private _delcrewk = _obj getVariable "d_delcrewk";
if (!isNil "_delcrewk") then {
	__TRACE_1("","_delcrewk")
	{_this deleteVehicleCrew _x} forEach (crew (_this select 0));
	_obj setVariable ["d_delcrewk", nil];
};

private _plok = _obj getVariable "d_plok";
if (!isNil "_plok") then {
	__TRACE_1("","_plok")
	_this call d_fnc_PlacedObjKilled;
	_obj setVariable ["d_plok", nil];
};

true