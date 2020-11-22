// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dohousepatrol.sqf"
#include "..\x_setup.sqf"

params ["_units"];

{
	private _building = nearestBuilding _x;
	if (alive _building) then {
		[_x, behaviour _x, 30, [], -1, "HIGH", false, _building] spawn d_fnc_housepatrol;
	} else {
		if (isNull _building) then {
			private _nobs = nearestObjects [_x, ["House", "Building"], 50];
			if (_nobs isNotEqualTo []) then {
				_building = _nobs # 0;
				if (alive _building) then {
					[_x, behaviour _x, 30, [], -1, "HIGH", false, _building] spawn d_fnc_housepatrol;
				};
			};
		};
	};
	sleep 0.2;
} forEach (_units select {alive _x && {isNil {_x getVariable "d_housepatrol"}}});
