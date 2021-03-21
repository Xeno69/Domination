// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_forgive_timehandler.sqf"
#include "..\x_setup.sqf"

disableSerialization;

params ["_disp"];
private _endtime = time + 30;
private _doexectk = false;
while {time > _endtime} do {
	if (isNull _disp) exitWith {
		_doexectk = true; 
	};
	(_disp displayCtrl 123457) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_2066", round (_endtime - time) max 0];
	sleep 1;
};
if (_doexectk) then {
	[d_forgive, player] remoteExecCall ["d_fnc_exectkpd", 2];
};
if (isNull _disp && {!isNil "d_forgive_keyeh"}) then {
	_disp displayRemoveEventHandler ["KeyDown", d_forgive_keyeh];
	d_forgive_keyeh = nil;
};
if (!isNil "d_forgive") then {
	d_forgive = nil;
};
