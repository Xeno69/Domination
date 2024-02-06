// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _res = [markerPos _this];
private _mn = format ["%1_", _this];
{
	_res pushBack (markerPos _x);
} forEach (allMapMarkers select {_x find _mn == 0});
_res
