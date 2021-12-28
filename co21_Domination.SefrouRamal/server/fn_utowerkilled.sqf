// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _tower = (_this # 0) getVariable "d_tower";
if (!isNil "_tower" && {!isNull _tower}) then {
	_tower setVariable ["d_faster", true];
	_tower setDamage 1;
} else {
	if (!isNull _tower) then {
		d_mt_spotted = false;
		d_mt_radio_down = true;
		if (d_ao_markers == 1) then {
			deleteMarker "d_m_t_rt";
		};
		[37] call d_fnc_DoKBMsg;
		deleteVehicle _tower;
	};
};