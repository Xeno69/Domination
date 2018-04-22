// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_glselchanged.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

private _selIdx = (param [0]) param [1];
if (_selIdx == -1) exitWith {};

if (d_graslayer_index != _selIdx) then {
	d_graslayer_index = _selIdx;
	setTerrainGrid ([50, 25, 12.5] select d_graslayer_index);

	systemChat format [localize "STR_DOM_MISSIONSTRING_686", [localize "STR_DOM_MISSIONSTRING_359", localize "STR_DOM_MISSIONSTRING_360", localize "STR_DOM_MISSIONSTRING_361"] select d_graslayer_index];
};