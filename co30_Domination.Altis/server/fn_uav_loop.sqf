// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"


while {true} do {
	{
		private _m = magazinesAmmo _x;
		private _missile_maginfo = _m select { _x # 0 == "6Rnd_LG_scalpel" };
		if (_missile_maginfo isEqualTo []) then {
			diag_log [format["no more missiles, time to despawn this vehicle _vecu: %1", _x]];
			sleep 17;
			d_cur_uav_combat deleteAt (d_cur_uav_combat find _x);
			deleteVehicle _x;
		};
	} forEach d_cur_uav_combat;
	sleep 7;	
};