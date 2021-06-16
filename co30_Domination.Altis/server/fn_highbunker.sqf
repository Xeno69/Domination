// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _newv = [];

private _check_fnc = {
	if (_this isKindOf "HMG_01_high_base_F" || {_this isKindOf "GMG_01_high_base_F" || {_this isKindOf "HMG_02_high_base_F" || {getText((configOf _this) >> "Turrets" >> "MainTurret" >> "gunnerAction") find "low" == -1}}}) exitWith {
		false
	};
	if (d_cup && {_this isKindOf "CUP_SPG9_base" || {_this isKindOf "CUP_Metis_Base" || {_this isKindOf "CUP_AGS_base" || {_this isKindOf "CUP_DSHKM_MiniTripod_base" || {_this isKindOf "CUP_KORD_MiniTripod_Base" || {_this isKindOf "CUP_Igla_AA_pod_Base"}}}}}}) exitWith {
		true
	};
	if (d_csla && {_this isKindOf "US85_M2l" || {_this isKindOf "US85_TOW_Stat"}}) exitWith {
		true
	};
	
	false
};

{
	if !(_x call _check_fnc) then {
		private _veh = createVehicle [d_b_small_static_high, _x, [], 0, "CAN_COLLIDE"];
		private _pos = getPos _x;
		_pos set [2, (_pos # 2) - 0.1];
		_veh setDir ((getDir _x) - 180);
		_veh setPos _pos;
		_newv pushBack _veh;
	};
} forEach _this;

_newv
