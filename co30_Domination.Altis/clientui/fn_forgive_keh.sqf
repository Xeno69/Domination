// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

#include "..\defineDIKCodes.inc"

if ((_this # 1) == DIK_F11) then {
	__TRACE_1("F11","_this")
	(_this # 0) displayRemoveEventHandler ["KeyDown", d_forgive_keyeh];
	d_forgive_keyeh = nil;
	[d_forgive, player] remoteExecCall ["d_fnc_exectkpd", 2];
	d_forgive = nil;
} else {
	if ((_this # 1) == DIK_F9) then {
		__TRACE_1("F9","_this")
		(_this # 0) displayRemoveEventHandler ["KeyDown", d_forgive_keyeh];
		d_forgive_keyeh = nil;
		systemChat format [localize "STR_DOM_MISSIONSTRING_2065", name d_forgive];
		(name player) remoteExecCall ["d_fnc_aophfytk", d_forgive];
		d_forgive = nil;
	};
};

false