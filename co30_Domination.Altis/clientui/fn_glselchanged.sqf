// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _selIdx = (_this # 0) # 1;
__TRACE_1("","_selIdx")
if (_selIdx == -1) exitWith {};

if (d_graslayer_index != _selIdx) then {
	d_graslayer_index = _selIdx;
	private _tg = [50, 25, 12.5, 6.25, 3.125] select d_graslayer_index;
	__TRACE_1("","_tg")
	setTerrainGrid _tg;
	profileNamespace setVariable ["dom_terraingrid", _tg];

	systemChat format [localize "STR_DOM_MISSIONSTRING_686", [localize "STR_DOM_MISSIONSTRING_359", localize "STR_DOM_MISSIONSTRING_360", localize "STR_DOM_MISSIONSTRING_361", localize "STR_DOM_MISSIONSTRING_400", localize "STR_DOM_MISSIONSTRING_400_VERYHIGH"] select d_graslayer_index];
};