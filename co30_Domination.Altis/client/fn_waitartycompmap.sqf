// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_waitartycompmap.sqf"
#include "..\x_setup.sqf"

while {true} do {
	waitUntil {sleep 0.3;shownArtilleryComputer};
	disableSerialization;
	private _artycomputer_map = controlNull;
	(allDisplays + (uiNamespace getVariable "IGUI_Displays")) findIf {
		private _ret = !isNull (_x displayCtrl 500);
		if (_ret) then {
			_artycomputer_map = _x displayCtrl 500;
		};
		_ret
	};
	
	if (!isNull _artycomputer_map) then {
		uiNamespace setVariable ["d_artycomputer_map", _artycomputer_map];
		_artycomputer_map ctrlAddEventHandler ["Draw", {[[uiNamespace getVariable "d_artycomputer_map", 0], 0] call d_fnc_mapondraw}];
	};
	waitUntil {sleep 0.3;!shownArtilleryComputer};
};