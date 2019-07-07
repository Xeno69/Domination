// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_announcenear.sqf"
#include "..\x_macros.sqf"

__TRACE_1("","_this")

if (!hasInterface) exitWith {};

if (!alive player || {player getVariable ["xr_pluncon", false]}) exitWith {
	hintSilent "";
	xr_announce_ar = [];
	xr_announce_unit_ar = [];
};

private _reldir = player getRelDir _this;

private _where = call {
	if (_reldir >= 315 || {_reldir <= 45}) exitWith {
		localize "STR_DOM_MISSIONSTRING_1720";
	};
	if (_reldir > 45 && {_reldir <= 135}) exitWith {
		localize "STR_DOM_MISSIONSTRING_1721";
	};
	if (_reldir > 135 && {_reldir <= 225}) exitWith {
		localize "STR_DOM_MISSIONSTRING_1722";
	};
	localize "STR_DOM_MISSIONSTRING_1723";
};

__TRACE_1("","_reldir")

xr_announce_ar pushBack [time + 15, format [localize "STR_DOM_MISSIONSTRING_1719", _this call d_fnc_getplayername, _where]];
xr_announce_unit_ar pushBack _this;

private _hintar = [];
{
	if (time > _x # 0 || {!((xr_announce_unit_ar # _forEachIndex) getVariable ["xr_pluncon", false])}) then {
		xr_announce_ar set [_forEachIndex, -1];
		xr_announce_unit_ar set [_forEachIndex, -1];
	} else {
		_hintar pushBack (_x # 1);
	};
} forEach xr_announce_ar;

xr_announce_ar = xr_announce_ar - [-1];
xr_announce_unit_ar = xr_announce_unit_ar - [-1];

hintSilent parseText ("<t color='#FFFFFF' size='1'>" + (_hintar joinString "<br/>"));
