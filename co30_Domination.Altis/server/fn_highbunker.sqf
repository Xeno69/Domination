// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _newv = [];

private _check_fnc = {
	if (_this isKindOf "HMG_01_high_base_F" || {_this isKindOf "GMG_01_high_base_F" || {_this isKindOf "HMG_02_high_base_F"}}) exitWith {
		false
	};
	if (getText((configOf _this) >> "Turrets" >> "MainTurret" >> "gunnerAction") find "low" != -1) exitWith {
		true
	};
	if (d_cup && {_this isKindOf "CUP_SPG9_base" || {_this isKindOf "CUP_Metis_Base" || {_this isKindOf "CUP_AGS_base" || {_this isKindOf "CUP_DSHKM_MiniTripod_base" || {_this isKindOf "CUP_KORD_MiniTripod_Base" || {_this isKindOf "CUP_Igla_AA_pod_Base"}}}}}}) exitWith {
		true
	};
	if (d_pracs && {_this isKindOf "PRACS_SLA_DSHk_Mini" || {_this isKindOf "PRACS_SLA_AGS30_tripod" || {_this isKindOf "PRACS_SLA_SPG9_tripod" || {_this isKindOf "CUP_DSHKM_MiniTripod_base" || {_this isKindOf "PRACS_SLA_SPG9M_tripod" || {_this isKindOf "PRACS_SLA_9k115"}}}}}}) exitWith {
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
