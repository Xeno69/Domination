// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tjetservice.sqf"
#include "..\x_setup.sqf"

params ["_list", "_trig"];

__TRACE_1("","_this")

if (_list isEqualTo []) then {
	_list = _trig nearEntities ["UAV", 16];
};

if ("Plane" countType _list == 0) exitWith {false};

_list params ["_plane"];

if (!isTouchingGround _plane) exitWith {false};

if (speed _plane >= 10) exitWith {false};

_trig setVariable ["d_list", _list];

true
