// by Xeno
#define THIS_FILE "fn_uav_check.sqf"
#include "..\..\x_setup.sqf"

while {true} do {
	if (!isNull (getConnectedUAV player)) then {
		private _uav = getConnectedUAV player;
		if (isNil {_uav getVariable "d_ublocked"}) then {
			_uav setVariable ["d_ublocked", true, true];
			_uav setVariable ["d_vec", ["", "UAV " + d_name_pl, "ColorBlue", d_player_side], true];
			_uav remoteExecCall ["d_fnc_initvec"];
		};
		while {!isNull (getConnectedUAV player)} do {
			sleep 1;
		};
		if (!isNull _uav) then {
			_uav setVariable ["d_vec", nil, true];
			_uav setVariable ["d_ublocked", nil, true];
			_uav remoteExecCall ["d_fnc_rem_uav"];
		};
	};
	sleep 1;
};
