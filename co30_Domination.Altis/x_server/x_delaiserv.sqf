// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_delaiserv.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

#ifndef __DEBUG__
sleep 60;
#endif

{
	if (unitIsUAV _x) then {
		_cr = crew _x;
		if !(_cr isEqualTo []) then {
			(group (_cr # 0)) setVariable ["d_do_not_delete", true];
		};
	};
} forEach vehicles;

sleep 1;

while {true} do {
	private _remar = [];
	{
		private _units = units _x;
		if (_units findIf {_x call d_fnc_isplayer} == -1) then {
			private _units = _units select {!(_x call d_fnc_isplayer)};
			if !(_units isEqualTo []) then {
				{
					if (!isNull (objectParent _x)) then {
						(objectParent _x) deleteVehicleCrew _x;
					} else {
						deleteVehicle _x;
					};
				} forEach _units;
				_remar pushBack _x;
			};
		};
#ifndef __DEBUG__
		sleep 2;
#endif
	} forEach (allGroups select {side _x in d_own_sides_o && {isNil {_x getVariable "d_do_not_delete"}}});
	if !(_remar isEqualTo []) then {
		{
			_x remoteExec ["deleteGroup", groupOwner _x];
		} forEach _remar;
	};
#ifndef __DEBUG__
	sleep 20.321;
#else
	sleep 2;
#endif
};