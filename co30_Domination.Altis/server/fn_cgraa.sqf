// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_side", "_type", "_mname", ["_remdriver", true]];

private _mlen = count _mname;

{
	private _grp = [_side] call d_fnc_creategroup;
	([1, markerPos _x, _type, _grp, markerDir _x, false, true] call d_fnc_makevgroup) params ["_av"];
	{
		_x lock 2;
		if (_remdriver && {!isNull (driver _x)}) then {
			_x deleteVehicleCrew (driver _x);
			_x lock 2;
		};
		
		_x addEventhandler ["getIn", {
			if (!local (_this # 2) || {(_this # 2) call d_fnc_isplayer}) then {
				(_this # 2) action ["getOut", _this # 0];
				if ((_this # 2) call d_fnc_isplayer) then {
					diag_log format ["Attention!!!! %1 is trying to get into an AA vehicle at base, UID: %2", name (_this # 2), getPlayerUID (_this # 2)];
				};
			};
		}];
	} forEach _av;
	_grp call d_fnc_addgrp2hc;
} forEach (allMapMarkers select {_x select [0, _mlen] == _mname});
