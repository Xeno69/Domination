// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createmarkerglobal.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

// create a global marker, returns created marker
// parameters: marker name, marker pos/object), marker shape, marker color, marker size;(optional) marker text, marker dir, marker type, marker brush
// example: ["my marker",  position player, "hd_dot", "ColorBlue", [0.5,0.5]] call d_fnc_CreateMarkerGlobal;
params ["_m_name","_m_pos","_m_shape","_m_col","_m_size"];

private _ma = createMarker [_m_name, _m_pos];
if (_m_shape != "") then {_ma setMarkerShape _m_shape};
if (_m_col != "") then {_ma setMarkerColor _m_col};
if !(_m_size isEqualTo []) then {_ma setMarkerSize _m_size};
private _co = count _this;
if (_co > 5) then {
	if (_this select 5 != "") then {
		_ma setMarkerText (_this select 5);
	};
	if (_co > 6) then {
		_ma setMarkerDir (_this select 6);
		if (_co > 7) then {
			if (_this select 7 != "") then {
				_ma setMarkerType (_this select 7);
			};
			if (_co > 8) then {
				if (_this select 8 != "") then {
					_ma setMarkerBrush (_this select 8);
				};
				if (_co > 9) then {_ma setMarkerAlpha (_this select 9)};
			};
		};
	};
};
_ma