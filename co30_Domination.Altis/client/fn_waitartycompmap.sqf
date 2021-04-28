// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	while {true} do {
		sleep 0.3;
		if (shownArtilleryComputer) exitWith {};
	};
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
	while {true} do {
		sleep 0.3;
		if (!shownArtilleryComputer) exitWith {};
	};
};