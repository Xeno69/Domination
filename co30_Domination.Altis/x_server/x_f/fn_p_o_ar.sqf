// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_p_o_ar.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

switch (_this select 0) do {
	case "a": {
		private _ar = d_placed_objs_store getVariable (_this select 1);
		__TRACE_1("a","_ar")
		if (!isNil "_ar") then {
			_ar pushBack (_this select 2);
		} else {
			d_placed_objs_store setVariable [_this select 1, [_this select 2]];
		};
		_ar = _this select 2;
		__TRACE_1("","_ar")
		(_ar # 0) addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_PlacedObjKilled}}];
		if ((_ar # 0) isKindOf d_mash) then {
			[_ar # 1, _ar # 0, "ICON", "ColorBlue", [0.5, 0.5], format ["Mash %1", _ar # 2], 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
			(_ar # 1) remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (_ar # 4 == blufor)];
#endif
		} else {
			if ((_ar # 0) isKindOf (d_farp_classes # 0)) then {
				[_ar # 1, _ar # 0, "ICON", "ColorBlue", [0.5, 0.5], format ["FARP %1", _ar # 2], 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
				(_ar # 1) remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (_ar # 4 == blufor)];
#endif
				if (isDedicated) then {
					private _farpc = (_ar # 0) getVariable ["d_objcont", []];
					if !(_farpc isEqualTo []) then {
						_farpc params ["_trig"];
						_trig setTriggerActivation ["ANY", "PRESENT", true];
						_trig setTriggerStatements ["thislist call d_fnc_tallservice", "0 = [thislist] spawn d_fnc_reload", ""];
					};
				};
			};
		};
	};
	case "a2": {
		private _ar = d_placed_objs_store2 getVariable (_this select 1);
		__TRACE_1("a2","_ar")
		if (isNil "_ar") then {
			d_placed_objs_store2 setVariable [_this select 1, [_this select 2]];
		} else {
			if !(_ar isEqualTo []) then {_ar = _ar - [objNull]};
			_ar pushBack (_this select 2);
		};
		(_this select 2) addMPEventhandler ["MPKilled", {if (isServer) then {{_this deleteVehicleCrew _x} forEach (crew (_this select 0))}}];
	};
	case "r": {
		private _ar = d_placed_objs_store getVariable (_this select 1);
		__TRACE_1("r","_ar")
		if (!isNil "_ar") then {
			private _fidx = _ar findIf {_x # 1 == (_this select 2)};
			if (_fidx > -1) then {
				_ar deleteAt _fidx;
			};
		};
		deleteMarker (_this select 2);
	};
	case "a2r": {
		private _ar = d_placed_objs_store2 getVariable (_this select 1);
		__TRACE_1("a2r","_ar")
		if (!isNil "_ar") then {
			_ar = _ar - [_this select 2, objNull];
		};
	};
	case "aw": {
		private _ar = d_placed_objs_store3 getVariable (_this select 1);
		__TRACE_1("aw","_ar")
		if (!isNil "_ar") then {
			if !(_ar isEqualTo []) then {
				private ["_t"];
				{
					_t = _x getVariable ["d_time_aw", -1];
					if (_t != -1 && {time > _t}) then {
						deleteVehicle _x;
					};
				} forEach (_ar select {!isNull _x});
				_ar = _ar - [objNull];
			};
			_ar pushBack (_this select 2);
		} else {
			d_placed_objs_store3 setVariable [_this select 1, [_this select 2]];
		};
		(_this select 2) setVariable ["d_time_aw", time + 1800];
	};
};