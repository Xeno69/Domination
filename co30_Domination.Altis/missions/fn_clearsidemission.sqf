// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_clearsidemission.sqf"
#include "..\x_setup.sqf"

if (!isNil "d_sm_check_trigger") then {
	deleteVehicle d_sm_check_trigger;
	d_sm_check_trigger = nil;
};

private _waittime = 200 + random 10;
if (d_MissionType != 2) then {
	private _num_p = call d_fnc_PlayersNumber;
	if (_num_p > 0) then {
		private _fidx = d_time_until_next_sidemission findIf {_num_p <= _x # 0};
		if (_fidx > -1) then {
			_waittime = ((d_time_until_next_sidemission # _fidx # 1) max 20) + random 10;
		};
	};
};

sleep _waittime;

{
	if !(isNull _x) then {
		if (_x isKindOf "House") then {
			_x setDamage 0;
			deleteVehicle _x;
		} else {
			if (_x isKindOf "LandVehicle" && {!((crew _x) isEqualTo [])}) then {
				if ({(_x call d_fnc_isplayer) && {alive _x}} count (crew _x) == 0) then {
					_x call d_fnc_DelVecAndCrew;
				};
			} else {
				deleteVehicle _x;
			};
		};
	};
} forEach d_x_sm_vec_rem_ar;
d_x_sm_vec_rem_ar = [];
{deleteVehicle _x} forEach (d_x_sm_rem_ar select {!isNull _x});
d_x_sm_rem_ar = [];
d_sm_resolved = false;
0 spawn d_fnc_getsidemission;
