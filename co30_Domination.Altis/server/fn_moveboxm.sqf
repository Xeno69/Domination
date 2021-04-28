// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_box", "_mname"];

private _opos = getPosASL _box;

while {alive _box} do {
	sleep 3;
	if (_opos distance2D _box > 2) then {
#ifndef __TT__
		_mname setMarkerPos _box;
#else
		_mname setMarkerPosLocal _box;
		
		private _bside = _box getVariable "d_box_params";
		if (!isNil "_bside") then {
			_bside = _bside # 3;
			[_mname, _box] remoteExecCall ["setMarkerPosLocal", _bside];
		};
#endif
		_opos = getPosASL _box;
	};
};
