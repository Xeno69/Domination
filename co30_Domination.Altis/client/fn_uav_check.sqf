// by Xeno	
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	private _has_pylon_action = false;
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
			if (d_pylon_lodout == 0 && {isClass ((configOf _uav)>>"Components">>"TransportPylonsComponent")}) then {
				if (isNil {_uav getVariable "d_plyonloadoutaction"}) then {
					_uav call d_fnc_addpylon_action;
				};
			};
		};
		while {!isNull (getConnectedUAV player)} do {
			if (typeOf _uav == d_UAV_CAS) then {
				// special case for combat UAV, different from MHQ based UAV
				// UAV terminal may remain connected while player is not using turret or driver
				private _ar = UAVControl _uav;
				private _is_player_driver_or_gunner = false; 
				if (count _ar == 4) then {
					// UAV may have two different players controlling driver/gunner
					// example from wiki:
					// [player1, "DRIVER", player2, "GUNNER"] - player1 is controlling the UAV and is the pilot, player2 is controlling UAV and is the gunner
					if (
						(_ar # 0 == player && { _ar # 1 isEqualTo "GUNNER" || _ar # 1 isEqualTo "DRIVER" })
							|| (_ar # 2 == player && { _ar # 3 isEqualTo "GUNNER" || _ar # 3 isEqualTo "DRIVER" })
					) then {
						_is_player_driver_or_gunner = true;
					};
				} else {
					if (_ar # 0 == player && { _ar # 1 isEqualTo "GUNNER"
						|| _ar # 1 isEqualTo "DRIVER" }
					) then {
						_is_player_driver_or_gunner = true;
					};
				};

				if (!d_isinuavmode && { _is_player_driver_or_gunner }) then {
					d_isinuavmode = true;
					setViewDistance d_ViewDistanceAir;
					setObjectViewDistance d_ViewDistanceAir + 100;
				};
				
				if (d_isinuavmode && {! _is_player_driver_or_gunner }) then {
					d_isinuavmode = false;
					setViewDistance d_curviewdistance;
					setObjectViewDistance d_curviewdistance + 100;
				};
			} else {
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
			};
			sleep 1;
		};
		if (!isNull _uav) then {
			_uav setVariable ["d_vec", nil, true];
			_uav setVariable ["d_ublocked", nil, true];
			_uav remoteExecCall ["d_fnc_rem_uav"];
			_uav setVariable ["d_vcheck", nil, true];
		};
		setViewDistance d_curviewdistance;
		setObjectViewDistance d_curviewdistance + 100;
		d_isinuavmode = false;
	};
	sleep 1;
};
