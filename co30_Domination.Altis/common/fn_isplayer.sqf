// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isplayer.sqf"
#include "..\x_setup.sqf"

isPlayer _this

// isPlayer should be fixed in 2.02
// if that's really true the function will vanish, for now it stays this way so it can easily be reversed if there are still issues

/*private _isp = _this getVariable "d_isp";
if (isNil "_isp") then {
	_isp = (isPlayer _this || {_this in allPlayers});
	_this setVariable ["d_isp", _isp];
};
_isp*/
