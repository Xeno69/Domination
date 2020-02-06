// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_moveboxm.sqf"
#include "..\x_setup.sqf"

params ["_box", "_mname"];

private _opos = getPosASL _box;

while {alive _box} do {
	sleep 3;
	if (_opos distance2D _box > 2) then {
		_mname setMarkerPos _box;
		_opos = getPosASL _box;
	};
};
