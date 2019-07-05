// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_uav_check.sqf"
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
			sleep 1;
		};
		if (!isNull _uav) then {
			_uav setVariable ["d_vec", nil, true];
			_uav setVariable ["d_ublocked", nil, true];
			_uav remoteExecCall ["d_fnc_rem_uav"];
			_uav setVariable ["d_vcheck", nil, true];
		};
	};
	sleep 1;
};
