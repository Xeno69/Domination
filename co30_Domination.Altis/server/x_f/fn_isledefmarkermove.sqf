// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isledefmarkermove.sqf"
#include "..\..\x_setup.sqf"

private _grp = _this;
sleep 30;
if (!isNull _grp && {(units _grp) findIf {alive _x} > -1}) then {
	private _ma = format ["d_is_def_mm%1", _grp];
	[_ma, [0,0,0], "ICON", d_e_marker_color, [0.5,0.5], localize "STR_DOM_MISSIONSTRING_964", 0, d_isle_defense_marker] call d_fnc_CreateMarkerGlobal;
	while {!isNull _grp && {(units _grp) findIf {alive _x} > -1}} do {
		private _lead = leader _grp;
		if (!isNull _lead) then {
			_ma setMarkerPos (getPosWorld _lead);
		};
		sleep (10 + random 10);
	};
	deleteMarker _ma;
};