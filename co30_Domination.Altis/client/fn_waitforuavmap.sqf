// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_waitforuavmap.sqf"
#include "..\x_setup.sqf"

while {true} do {
	waitUntil {sleep 0.3;!isNull ((findDisplay 160) displayCtrl 51)};
	disableSerialization;
	private _ctrl = (findDisplay 160) displayCtrl 51;
	if (!isNull _ctrl) then {
		_ctrl ctrlAddEventHandler ["Draw", {[[(findDisplay 160) displayCtrl 51, 0], 0] call d_fnc_mapondraw}];
	};
	waitUntil {sleep 0.3;!isNull ((findDisplay 160) displayCtrl 51)};
};