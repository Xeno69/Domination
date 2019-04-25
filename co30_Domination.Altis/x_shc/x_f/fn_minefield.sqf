// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_minefield.sqf"
#include "..\..\x_setup.sqf"

params ["_radius", "_center"];

private _num_mines = (floor (random 20)) max 10;

private _ran_start_pos = [_center, _radius, 0] call d_fnc_GetRanPointCircle;
private _m_pos_ar = [];

for "_i" from 1 to _num_mines do {
	_m_pos_ar pushBack ([_ran_start_pos, 100, 0] call d_fnc_GetRanPointCircle);
};

d_mines_created = [];
private _mtype = selectRandom ["APERSMine", "APERSBoundingMine", "SLAMDirectionalMine", "APERSTripMine"];

for "_i" from 0 to (_num_mines - 1) do {
	private _mine = createMine [_mtype, _m_pos_ar # _i, [], 0];
	_mine setDir random 360;
	d_side_enemy revealMine _mine;
	d_mines_created pushBack _mine;
#ifdef __GROUPDEBUG__
	[str _mine, _m_pos_ar # _i, "ICON", "ColorBlack", [0.5, 0.5], "Mine: " + (typeOf _mine), 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
	sleep 0.2;
};
