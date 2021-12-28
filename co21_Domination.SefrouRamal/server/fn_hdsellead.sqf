// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep 2;
if (!isNil "_this" && {!isNull _this}) then {
	remoteExecCall ["xr_fnc_changeleader", _this];
};