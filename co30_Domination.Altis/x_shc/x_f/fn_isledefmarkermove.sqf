// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isledefmarkermove.sqf"
#include "..\..\x_setup.sqf"

private _grp = _this;
sleep 30;
if (!isNull _grp && {(units _grp) findIf {alive _x} > -1}) then {
	private _ma = format ["%1i_d_f_m%2", _grp, d_IsleDefMarkerMove];
	d_IsleDefMarkerMove = d_IsleDefMarkerMove + 1;
	if (d_IsleDefMarkerMove > 1000000) then {
		d_IsleDefMarkerMove = 0;
	};
	[_ma, [0,0,0], "ICON", d_e_marker_color, [0.5,0.5], localize "STR_DOM_MISSIONSTRING_964", 0, d_isle_defense_marker] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];
	while {!isNull _grp && {(units _grp) findIf {alive _x} > -1}} do {
		private _lead = leader _grp;
		if (!isNull _lead) then {
			[_ma, getPosWorld _lead] remoteExecCall ["setMarkerPos", 2];
		};
		sleep (10 + random 10);
	};
	_ma remoteExecCall ["deleteMarker", 2];
};