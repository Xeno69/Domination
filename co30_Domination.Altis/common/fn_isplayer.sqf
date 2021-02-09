// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isplayer.sqf"
#include "..\x_setup.sqf"

private _isp = _this getVariable "d_isp";
if (isNil "_isp") then {
	_isp = isPlayer _this || {_this in allPlayers};
	_this setVariable ["d_isp", _isp];
};
_isp
