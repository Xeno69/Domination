// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

private _pos = getPosASL _this;
_pos set [2, _this distance (getPos _this)];
if (d_vn) then {
	_pos = _pos vectorAdd [0, 0, 0.1];
};
__TRACE_2("","_this","_pos")
xr_death_pos = [_pos, getDir _this];