// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isNil "d_sm_check_trigger") then {
	deleteVehicle d_sm_check_trigger;
	d_sm_check_trigger = nil;
};

#ifndef __SMDEBUG__
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
#else
private _waittime = 10;
#endif

private _deltime = 180;
if (_waittime < 180) then {
	_deltime = _waittime / 2;
};

_waittime = _waittime - _deltime;

sleep _deltime;

{
	if !(isNull _x) then {
		if (_x isKindOf "House") then {
			_x setDamage 0;
			deleteVehicle _x;
		} else {
			if (_x isKindOf "LandVehicle" && {(crew _x) isNotEqualTo []}) then {
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

sleep _waittime;

d_sm_resolved = false;
0 spawn d_fnc_getsidemission;
