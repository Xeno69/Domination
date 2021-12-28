// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

//__TRACE_1("","_this")

params ["_disp"];
private _endtime = time + 30;
//__TRACE_1("","_endtime")
private _doexectk = false;
while {_endtime > time} do {
	if (isNull _disp) exitWith {
		_doexectk = true; 
	};
	if (isNil "d_forgive") exitWith {};
	(_disp displayCtrl 123457) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_2066", round (_endtime - time) max 0];
	uiSleep 1;
};
//__TRACE_1("","_doexectk")
if (!isNil "d_forgive" && {_doexectk}) then {
	[d_forgive, player] remoteExecCall ["d_fnc_exectkpd", 2];
};
if (isNull _disp && {!isNil "d_forgive_keyeh"}) then {
	_disp displayRemoveEventHandler ["KeyDown", d_forgive_keyeh];
	d_forgive_keyeh = nil;
};
if (!isNil "d_forgive") then {
	d_forgive = nil;
};
(_disp displayCtrl 123456) ctrlShow false;
(_disp displayCtrl 123457) ctrlShow false;
