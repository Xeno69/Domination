// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_highbunker.sqf"
#include "..\x_setup.sqf"

private _newv = [];

{
	if (_x isKindOf "HMG_01_high_base_F" || {_x isKindOf "GMG_01_high_base_F" || {_x isKindOf "HMG_02_high_base_F" || {getText((configOf _x) >> "Turrets" >> "MainTurret" >> "gunnerAction") find "low" == -1}}}) then {
		if (!(_x isKindOf "CUP_O_Metis_RU") && {!(_x isKindOf "US85_M2l") && {!(_x isKindOf "US85_TOW_Stat")}}) then {
			private _veh = createVehicle [d_b_small_static_high, _x, [], 0, "CAN_COLLIDE"];
			private _pos = getPos _x;
			_pos set [2, (_pos # 2) - 0.1];
			_veh setDir ((getDir _x) - 180);
			_veh setPos _pos;
			_newv pushBack _veh;
		};
	};
} forEach _this;

_newv