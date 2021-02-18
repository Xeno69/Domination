// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cmakemtgmarker.sqf"
#include "..\x_setup.sqf"

__TRACE("Start")

if (isNil "d_cur_tgt_pos" || {d_cur_tgt_pos isEqualTo []}) exitWith {
	diag_log "Attention!!!!! cmakemtgmarker d_cur_tgt_pos is empty!!!!!!";
};

if (isNil "d_mttarget_radius_patrol" || {d_mttarget_radius_patrol isEqualTo []}) exitWith {
	diag_log "Attention!!!!! cmakemtgmarker d_mttarget_radius_patrol is empty!!!!!!";
};

__TRACE_1("","d_cur_tgt_pos")

private _tile_size = (d_mttarget_radius_patrol * 2) / 7;

private _tilesfull_half = (_tile_size * 7) / 2;
private _tilehalf = _tile_size / 2;

private _xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf;
private _ypos1 = (d_cur_tgt_pos # 1);

private _marcounter = 0;

private _fnc_sevena = {
	if (_this == 1 || {_this == 7}) exitWith {
		(d_e_marker_color_alpha - 0.3) max 0.5
	};
	if (_this == 2 || {_this == 6}) exitWith {
		(d_e_marker_color_alpha - 0.2) max 0.6
	};
	if (_this == 3 || {_this == 5}) exitWith {
		(d_e_marker_color_alpha - 0.1) max 0.7
	};
	d_e_marker_color_alpha
};
private _fnc_fivea = {
	if (_this == 1 || {_this == 5}) exitWith {
		(d_e_marker_color_alpha - 0.3) max 0.5
	};
	if (_this == 2 || {_this == 4}) exitWith {
		(d_e_marker_color_alpha - 0.2) max 0.6
	};
	d_e_marker_color_alpha
};

private _fnc_threea = {
	(d_e_marker_color_alpha - 0.3) max 0.5
};

d_mt_marker_triggers = [];

private _fnc_make_trig_mar = {
	params ["_num"];
	private _fnc_2_use = call {
		if (_num == 7) exitWith {
			_fnc_sevena;
		};
		if (_num == 5) exitWith {
			_fnc_fivea;
		};
		_fnc_threea
	};
	for "_i" from 1 to _num do {
		private _alpha = _i call _fnc_2_use;
		private _marname = format ["d_dommtmxe_%1", _marcounter];
		__TRACE_1("","_marname")
		if (getMarkerType _marname != "") then {
			__TRACE_1("Marker exists already","_marname")
			deleteMarkerLocal _marname;
		};
		[_marname, [_xpos1, _ypos1], "RECTANGLE", "ColorGreen", [_tilehalf, _tilehalf], "", 0, "", "", _alpha] call d_fnc_CreateMarkerLocal;
		
		private _trigger = [
			[_xpos1, _ypos1],
			[_tilehalf, _tilehalf, 0, true],
			[d_enemy_side, "PRESENT", true],
			["this",
				"0 = [thistrigger, true] call d_fnc_trigsetmarker",
				"0 = [thistrigger, false] call d_fnc_trigsetmarker"
			],
			1
		] call d_fnc_createtriggerlocal;
		__TRACE_1("","_trigger")
		
		_trigger setVariable ["d_trigmarker", _marname];
		
		d_mt_marker_triggers pushBack _trigger;
		
		_xpos1 = _xpos1 + _tile_size;
		_marcounter = _marcounter + 1;
		__TRACE_1("","_marcounter")
	};
};

[7] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf;
_ypos1 = _ypos1 + _tile_size;

[7] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf + _tile_size;
_ypos1 = _ypos1 + _tile_size;

[5] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf + (_tile_size * 2);
_ypos1 = _ypos1 + _tile_size;

[3] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf;
_ypos1 = (d_cur_tgt_pos # 1) - _tile_size;

[7] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf + _tile_size;
_ypos1 = _ypos1 - _tile_size;

[5] call _fnc_make_trig_mar;

_xpos1 = (d_cur_tgt_pos # 0) - _tilesfull_half + _tilehalf + (_tile_size * 2);
_ypos1 = _ypos1 - _tile_size;

[3] call _fnc_make_trig_mar;

/*
#ifndef __TT__
private _circlep3d = call {
	if (d_player_side == blufor) exitWith {
		"a3\Modules_F_Curator\Multiplayer\surfacesectoreast500m.p3d"
	};
	if (d_player_side == opfor) exitWith {
		"a3\Modules_F_Curator\Multiplayer\surfacesectorwest500m.p3d"
	};
	"a3\Modules_F_Curator\Multiplayer\surfaceSectorEast500m.p3d"
};
d_dircle_obj = createSimpleObject [_circlep3d, d_cur_tgt_pos, true];
#else
d_dircle_obj = createSimpleObject ["a3\Modules_F_Curator\Multiplayer\surfacesectorguer500m.p3d", d_cur_tgt_pos, true];
#endif
*/

__TRACE("End")