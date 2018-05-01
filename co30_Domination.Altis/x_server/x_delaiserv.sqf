// by Xeno
#define THIS_FILE "x_delaiserv.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

sleep 60;

while {true} do {
	call d_fnc_mpcheck;
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
					false
				} count _units;
				_remar pushBack _x;
			};
		};
		sleep 2;
	} forEach (allGroups select {side _x in d_own_sides_o && {isNil {_x getVariable "d_do_not_delete"}}});
	if !(_remar isEqualTo []) then {
		{
			_x remoteExec ["deleteGroup", groupOwner _x];
			false
		} count _remar;
	};
	sleep 20.321;
};