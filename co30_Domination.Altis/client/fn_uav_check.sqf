// by Xeno	
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	if (!isNull (getConnectedUAV player)) then {
		private _uav = getConnectedUAV player;
		__TRACE_1("","_uav")
		if (isNil {_uav getVariable "d_ublocked"}) then {
			__TRACE("uav not blocked")
			_uav setVariable ["d_ublocked", true, true];
			if (!isNil {_uav getVariable "d_vcheck"}) then {
				_uav setVariable ["d_vcheck", nil, true];
			};
			_uav setVariable ["d_vec", ["", "UAV " + d_name_pl, "ColorBlue", d_player_side], true];
			_uav remoteExecCall ["d_fnc_initvec"];
		};
		while {!isNull (getConnectedUAV player)} do {
			private _ar = UAVControl _uav;
			if (!d_isinuavmode && {_ar # 0 == player && {_ar # 1 isNotEqualTo ""}}) then {
				d_isinuavmode = true;
				if (_uav isKindOf "Car" || {_uav isKindOf "Tank" || {_uav isKindOf "Motorcycle" || {_uav isKindOf "Ship"}}}) then {
					if (d_ViewDistanceVec != viewDistance) then {
						setViewDistance d_ViewDistanceVec;
						setObjectViewDistance d_ViewDistanceVec + 100;
					};
				} else {
					if (_uav isKindOf "Helicopter" || {_uav isKindOf "Plane"}) then {
						if (d_ViewDistanceAir != viewDistance) then {
							setViewDistance d_ViewDistanceAir;
							setObjectViewDistance d_ViewDistanceAir + 100;
						};
					};
				};
			} else {
				if (d_isinuavmode) then {
					d_isinuavmode = false;
				};
			};
			sleep 1;
		};
		if (!isNull _uav) then {
			_uav setVariable ["d_vec", nil, true];
			_uav setVariable ["d_ublocked", nil, true];
			_uav remoteExecCall ["d_fnc_rem_uav"];
			_uav setVariable ["d_vcheck", nil, true];
		};
		d_isinuavmode = false;
	};
	sleep 1;
};
