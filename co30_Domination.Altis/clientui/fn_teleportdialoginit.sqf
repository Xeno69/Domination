// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_teleportdialoginit.sqf"
#include "..\x_setup.sqf"

disableSerialization;

#define __CTRL(A) (_display displayCtrl A)

__TRACE_1("","_this")

params ["_display", "_dtype"];

if (_dtype == 0) then {
	if (d_tele_dialog > 0) then {
		__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_586");
		__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_533");
	} else {
		__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_299");
		__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_298");
	};
} else {
	if (!xr_respawn_available) then {
		__CTRL(100102) ctrlEnable false;
		__TRACE("enable false")
	};
	if (!xr_spectating) then {
		__CTRL(1212) ctrlEnable false;
		__CTRL(1212) ctrlShow false;
		__CTRL(1003) ctrlEnable false;
		__CTRL(1003) ctrlShow false;
		__CTRL(1000) ctrlEnable false;
		__CTRL(1000) ctrlShow false;
		__CTRL(3000) ctrlShow false;
	} else {
		__CTRL(3000) ctrlShow false;
		__CTRL(1000) ctrlShow false;
	};
};

__CTRL(11003) ctrlShow false;
__CTRL(11004) ctrlShow false;

private _addbase = true;
if (d_WithTeleToBase == 1 && {d_tele_dialog > 0 && {_dtype == 0}}) then {
	_addbase = false;
};

private _listctrl = __CTRL(1500);
lbClear _listctrl;

private _cidx = -1;
private _selidx = 0;

d_tele_prev_sel = -1;

d_respawn_anim_markers = [];
d_respawn_posis = [];
d_respawn_ismhq = [];

if (_addbase) then {
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1251");
	_listctrl lbSetData [_cidx, "D_BASE_D"];
	_selidx = _cidx;
	d_beam_target = "D_BASE_D";
	private _text = if (_dtype == 1 || {d_tele_dialog == 0}) then {
		format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1251"]
	} else {
		format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1251"]
	};
	__CTRL(100110) ctrlSetText _text;
	["D_BASE_D", getPosASL d_FLAG_BASE, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack "D_BASE_D";
	d_respawn_mar_str = "D_BASE_D";
	d_respawn_posis pushBack (getPosASL d_FLAG_BASE);
	d_respawn_ismhq pushBack false;
} else {
	d_respawn_mar_str = "";
};

__TRACE_1("","d_mob_respawns")

#define __COLRED [1,0,0,0.7]
private _logtxt = "";

{
	private _mrs = missionNamespace getVariable [_x # 0, objNull];
	__TRACE_2("","_mrs","_x")
	if (!isNull _mrs) then {
		private _lbcolor = call {
			if (_mrs getVariable ["d_in_air", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_592", _x # 1, _logtxt]; __COLRED};
			if (speed _mrs > 4) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_593", _x # 1] + _logtxt + "\n"; __COLRED};
			if (!(_mrs isKindOf "Ship") && {surfaceIsWater (getPosWorld _mrs)}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_594", _x # 1, _logtxt]; __COLRED};
			if (!alive _mrs) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_595", _x # 1, _logtxt]; __COLRED};
			if !(_mrs getVariable ["d_MHQ_Deployed", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_596", _x # 1, _logtxt]; __COLRED};
			if (_mrs getVariable ["d_enemy_near", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_597", _x # 1, _logtxt]; __COLRED};
			if (_mrs isKindOf "Ship" && {_mrs emptyPositions "cargo" == 0}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_2023", _x # 1, _logtxt]; __COLRED};
			[1,1,1,1];
		};
		_cidx = _listctrl lbAdd (_x # 1);
		_listctrl lbSetData [_cidx, _x # 0];
		_listctrl lbSetColor [_cidx, _lbcolor];
		if (d_last_beam_target == _x # 0 && {_lbcolor isEqualTo [1,1,1,1]}) then {
			_selidx = _cidx;
			d_respawn_mar_str = _x # 0;
			d_beam_target = _x # 0;
			private _text = if (_dtype == 1 || {d_tele_dialog == 0}) then {
				format [localize "STR_DOM_MISSIONSTRING_607", _x # 2]
			} else {
				format [localize "STR_DOM_MISSIONSTRING_605", _x # 2]
			};
			__CTRL(100110) ctrlSetText _text;
		};
		[_x # 0, visiblePositionASL _mrs, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
		d_respawn_anim_markers pushBack (_x # 0);
		d_respawn_posis pushBack (visiblePositionASL _mrs);
		d_respawn_ismhq pushBack true;
	};
} forEach d_mob_respawns;

{
	__TRACE_1("","_x")
	_cidx = _listctrl lbAdd (_x # 2);
	_listctrl lbSetData [_cidx, _x # 0];
	_listctrl lbSetColor [_cidx, [1,1,1,1]];
	if (d_last_beam_target == _x # 0) then {
		_selidx = _cidx;
		d_respawn_mar_str = _x # 0;
		d_beam_target = _x # 0;
		private _text = if (_dtype == 1 || {d_tele_dialog == 0}) then {
			format [localize "STR_DOM_MISSIONSTRING_607", _x # 2]
		} else {
			format [localize "STR_DOM_MISSIONSTRING_605", _x # 2]
		};
		__CTRL(100110) ctrlSetText _text;
	};
	[_x # 0, _x # 1, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack (_x # 0);
	d_respawn_posis pushBack (_x # 1);
	d_respawn_ismhq pushBack false;
} forEach d_additional_respawn_points;

private _has_sql = 0;
d_resp_lead_idx = -1;

if (d_respawnatsql == 0 && {!(player getVariable ["xr_isleader", false]) && {count units (group player) > 1 && {player != leader (group player)}}}) then {
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1705a");
	_listctrl lbSetData [_cidx, "D_SQL_D"];
	_has_sql = 1;
	private _leader = leader (group player);
	private _emptycargo = [0, (vehicle _leader) emptyPositions "cargo"] select (!isNull objectParent _leader);
	private _lbcolor = if (alive _leader && {!(_leader getVariable ["xr_pluncon", false])} && {!(_leader getVariable ["ace_isunconscious", false])} && {_emptycargo > 0 || {(getPos _leader) # 2 < 10}} && {!(_leader call d_fnc_isswimming)} && {!underwater _leader}) then {
		[1,1,1,1.0]
	} else {
		_logtxt = localize "STR_DOM_MISSIONSTRING_1706";
		__COLRED
	};
	_listctrl lbSetColor [_cidx, _lbcolor];
	if (d_last_beam_target == "D_SQL_D" && {_lbcolor isEqualTo [1,1,1,1.0]}) then {
		_selidx = _cidx;
		d_respawn_mar_str = "D_SQL_D";
		d_beam_target = "D_SQL_D";
		private _text = if (_dtype == 1 || {d_tele_dialog == 0}) then {
			format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1705a"]
		} else {
			format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1705a"]
		};
		__CTRL(100110) ctrlSetText _text;
	};
	["D_SQL_D", visiblePositionASL _leader, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack "D_SQL_D";
	d_resp_lead_idx = d_respawn_posis pushBack (visiblePositionASL _leader);
	d_respawn_ismhq pushBack false;
};

__TRACE_1("","_logtxt")

if (_logtxt != "") then {
	__CTRL(11002) ctrlSetText _logtxt;
};

private _can_add_mapclick = true;
if (!isNil "xr_pl_no_lifes" && {xr_pl_no_lifes}) then {
	__CTRL(100102) ctrlEnable false;
	_can_add_mapclick = false;
};
if (!xr_respawn_available) then {
	__CTRL(100102) ctrlEnable false;
};

if (_can_add_mapclick) then {
	["d_exactpos_radius_mar", [0, 0, 0], "ELLIPSE", "ColorBlack", [40, 40], "", 0, "", "BDiagonal", 1] call d_fnc_CreateMarkerLocal;
	["d_exactpos_sel_mar", [0, 0, 0], "ICON", "ColorWhite", [1,1], "", 0, "waypoint"] call d_fnc_CreateMarkerLocal;
	"d_exactpos_radius_mar" setMarkerAlphaLocal 0;
	"d_exactpos_sel_mar" setMarkerAlphaLocal 0;
	d_rmapclick_type = _dtype;
	d_resp_map_click_eh = addMissionEventHandler ["MapSingleClick", {
		_this call d_fnc_rmapclick
	}];
};

d_lb_tele_first = true;

if (_cidx > -1) then {
	_listctrl lbSetCurSel _selidx;
};

[_display] call xr_fnc_spectdlginit;

_has_sql spawn d_fnc_respawn_mar_anim;
