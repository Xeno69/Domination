// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _res = [markerPos _this];
private _mn = format ["%1_", _this];
private _len = count _mn;
{
	_res pushBack (markerPos _x);
} forEach (allMapMarkers select {_x select [0, _len] == _mn});
_res
