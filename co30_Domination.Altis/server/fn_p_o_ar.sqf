// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

call {
	if (_this # 0 == "a") exitWith {
		private _ar = d_placed_objs_hash getOrDefault [_this # 1, []];
		__TRACE_1("a","_ar")
		if (_ar isNotEqualTo []) then {
			_ar pushBack (_this # 2);
		} else {
			d_placed_objs_hash set [_this # 1, [_this # 2]];
		};
		_ar = _this # 2;
		__TRACE_1("","_ar")
		[_ar # 0, 13] call d_fnc_setekmode;
		if ((_ar # 0) isKindOf d_mash) then {
			[_ar # 1, _ar # 0, "ICON", "ColorBlue", [0.5, 0.5], format ["Mash %1", _ar # 2], 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
			(_ar # 1) remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select ((_ar # 4) == blufor)];
#endif
		} else {
			if ((_ar # 0) isKindOf (d_farp_classes # 0)) then {
				[_ar # 1, _ar # 0, "ICON", "ColorBlue", [0.5, 0.5], format ["FARP %1", _ar # 2], 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
				(_ar # 1) remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select ((_ar # 4) == blufor)];
#endif
			};
		};
	};
	if (_this # 0 == "a2") exitWith {
		private _ar = d_placed_objs_hash2 getOrDefault [_this # 1, []];
		__TRACE_1("a2","_ar")
		if (_ar isEqualTo []) then {
			d_placed_objs_hash2 set [_this # 1, [_this # 2]];
		} else {
			_ar = _ar - [objNull];
			_ar pushBack (_this # 2);
		};
		(_this # 2) setVariable ["d_uav_crew", _this # 3];
		[_this # 2, 7] call d_fnc_setekmode;
	};
	if (_this # 0 == "ar") exitWith {
		private _ar = d_placed_objs_hash getOrDefault [_this # 1, []];
		__TRACE_1("ar","_ar")
		if (_ar isNotEqualTo []) then {
			private _fidx = _ar findIf {_x # 1 == (_this # 2)};
			if (_fidx > -1) then {
				_ar deleteAt _fidx;
			};
		};
		deleteMarker (_this # 2);
	};
	if (_this # 0 == "a2r") exitWith {
		private _ar = d_placed_objs_hash2 getOrDefault [_this # 1, []];
		__TRACE_1("a2r","_ar")
		if (_ar isNotEqualTo []) then {
			_ar = _ar - [_this # 2, objNull];
		};
	};
	if (_this # 0 == "aw") exitWith {
		private _ar = d_placed_objs_hash3 getOrDefault [_this # 1, []];
		__TRACE_1("aw","_ar")
		if (_ar isNotEqualTo []) then {
			private ["_t"];
			{
				_t = _x getVariable ["d_time_aw", -1];
				if (_t != -1 && {time > _t}) then {
					deleteVehicle _x;
				};
			} forEach (_ar select {!isNull _x});
			_ar = _ar - [objNull];
			_ar pushBack (_this # 2);
		} else {
			d_placed_objs_hash3 set [_this # 1, [_this # 2]];
		};
		(_this # 2) setVariable ["d_time_aw", time + 1800];
	};
	if (_this # 0 == "aj") exitWith {
		private _ar = d_placed_objs_hash4 getOrDefault [_this # 1, []];
		__TRACE_1("aj","_ar")
		if (_ar isNotEqualTo []) then {
			deleteVehicle _ar;
		};
		d_placed_objs_hash4 set [_this # 1, _this # 2];
	};
	if (_this # 0 == "ajr") exitWith {
		private _ar = d_placed_objs_hash4 getOrDefault [_this # 1, []];
		__TRACE_1("ajr","_ar")
		if (_ar isNotEqualTo []) then {
			deleteVehicle _ar;
		};
		d_placed_objs_hash4 deleteAt (_this # 1);
	};
};
