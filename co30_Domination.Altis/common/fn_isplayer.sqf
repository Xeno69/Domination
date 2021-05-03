// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _ip = _this getVariable "d_isp";
if (isNil "_ip") then {
	_ip = isPlayer _this || {_this in allPlayers};
	_this setVariable ["d_isp", _ip];
};
_ip
