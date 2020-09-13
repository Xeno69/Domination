// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_glselchanged.sqf"
#include "..\x_setup.sqf"

disableSerialization;

private _selIdx = (_this select 0) select 1;
if (_selIdx == -1) exitWith {};

if (d_graslayer_index != _selIdx) then {
	d_graslayer_index = _selIdx;
	private _tg = [50, 25, 12.5, 6.25, 3.125] select d_graslayer_index;
	setTerrainGrid _tg;
	profileNamespace setVariable ["dom_terraingrid", _tg];

	systemChat format [localize "STR_DOM_MISSIONSTRING_686", [localize "STR_DOM_MISSIONSTRING_359", localize "STR_DOM_MISSIONSTRING_360", localize "STR_DOM_MISSIONSTRING_361", localize "STR_DOM_MISSIONSTRING_400", localize "STR_DOM_MISSIONSTRING_400_VERYHIGH"] select d_graslayer_index];
};