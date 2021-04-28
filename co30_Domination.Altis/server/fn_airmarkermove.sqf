// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _vec = _this;
sleep 30;
if (alive _vec && {canMove _vec}) then {
	private _markern = format ["%1_d_am_v", _vec call d_fnc_markername];
	[_markern, [0, 0, 0], "ICON", d_e_marker_color, [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_963", 0, "n_air"] call d_fnc_CreateMarkerGlobal;
	[_markern, "STR_DOM_MISSIONSTRING_963"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
	while {alive _vec && {canMove _vec}} do {
		_markern setMarkerPos (getPosWorld _vec);
		sleep (4 + random 2);
	};
	deleteMarker _markern;
};