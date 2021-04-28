// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	while {true} do {
		sleep 0.3;
		if (!isNull ((findDisplay 160) displayCtrl 51)) exitWith {};
	};
	disableSerialization;
	private _ctrl = (findDisplay 160) displayCtrl 51;
	if (!isNull _ctrl) then {
		_ctrl ctrlAddEventHandler ["Draw", {[[(findDisplay 160) displayCtrl 51, 0], 0] call d_fnc_mapondraw}];
	};
	while {true} do {
		sleep 0.3;
		if (!isNull ((findDisplay 160) displayCtrl 51)) exitWith {};
	};
};