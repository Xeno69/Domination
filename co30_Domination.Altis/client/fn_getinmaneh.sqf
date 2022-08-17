// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_player_in_base = false;
d_vec_role_pl = assignedVehicleRole player;
if (d_player_canu) then {
	d_player_in_vec = true;
	if (d_vec_role_pl isNotEqualTo [] && {d_vec_role_pl # 0 != "cargo"}) then {
		if (d_isvdreduced) then {
			d_isvdreduced = false;
		};
		private _vp = _this # 2;
		if (_vp isKindOf "Car" || {_vp isKindOf "Tank" || {_vp isKindOf "Motorcycle" || {_vp isKindOf "Ship"}}}) then {
			if (d_ViewDistanceVec != viewDistance) then {
				setViewDistance d_ViewDistanceVec;
				setObjectViewDistance d_ViewDistanceVec + 100;
			};
		} else {
			if (_vp isKindOf "Helicopter" || {_vp isKindOf "Plane"}) then {
				if (d_ViewDistanceAir != viewDistance) then {
					setViewDistance d_ViewDistanceAir;
					setObjectViewDistance d_ViewDistanceAir + 100;
				};
			};
		};
	};
	call d_fnc_vehicleScripts;
} else {
	d_player_in_vec = false;
};

