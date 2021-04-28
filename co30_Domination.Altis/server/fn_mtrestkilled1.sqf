// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_mt_mobile_hq_down = true;
private _mt_done = (_this # 0) getVariable ["d_mt_done", false];
__TRACE_1("","_mt_done")
if (!_mt_done) then {
#ifndef __TT__
	[53] call d_fnc_DoKBMsg;
#else
	[60] call d_fnc_DoKBMsg;
#endif
};
(_this # 0) spawn {
	scriptName "spawn checkmtrespawntarget2";
	sleep (60 + random 60);
	_this setDamage 0;
	deleteVehicle _this;
};
(_this # 0) removeAllEventHandlers "killed";
if (!_mt_done) then {
	private _killer = _this # 2;
	if (isNull _killer) then {
		if (!d_with_ace) then {
			_killer = (_this # 0) getVariable ["d_last_damager", _killer];
		} else {
			_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};
	if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
		[_killer, 2] call d_fnc_addScore;
	};
};
