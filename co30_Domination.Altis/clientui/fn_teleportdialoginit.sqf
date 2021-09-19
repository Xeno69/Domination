// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

//__TRACE_1("","_this")

params ["_display", "_dtype"];

if (_dtype == 0) then {
	if (d_tele_dialog > 0) then {
		(_display displayCtrl 100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_586");
		(_display displayCtrl 100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_533");
	} else {
		(_display displayCtrl 100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_299");
		(_display displayCtrl 100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_298");
	};
} else {
	if (!xr_respawn_available) then {
		(_display displayCtrl 100102) ctrlEnable false;
		//__TRACE("enable false")
	};
	if (!xr_spectating) then {
		(_display displayCtrl 1212) ctrlEnable false;
		(_display displayCtrl 1212) ctrlShow false;
		(_display displayCtrl 1003) ctrlEnable false;
		(_display displayCtrl 1003) ctrlShow false;
		(_display displayCtrl 1000) ctrlEnable false;
		(_display displayCtrl 1000) ctrlShow false;
		(_display displayCtrl 3000) ctrlShow false;
	} else {
		(_display displayCtrl 3000) ctrlShow false;
		(_display displayCtrl 1000) ctrlShow false;
	};
	//__TRACE_1("","d_tk_forgive")
	if (d_tk_forgive == 1 || {d_no_teamkill == 0}) then {
		(_display displayCtrl 123456) ctrlShow false;
		(_display displayCtrl 123457) ctrlShow false;
	} else {
		if (d_no_teamkill == 1 && {d_tk_forgive == 0}) then {
			(_display displayCtrl 123456) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_2064", name d_forgive];
			d_forgive_keyeh = _display displayAddEventHandler ["KeyDown", {call d_fnc_forgive_keh}];
			//__TRACE_1("","d_forgive_keyeh")
			_display spawn d_fnc_forgive_timehandler;
		};
	};
};

(_display displayCtrl 11003) ctrlShow false;
(_display displayCtrl 11004) ctrlShow false;

private _addbase = true;
if (d_WithTeleToBase == 1 && {d_tele_dialog > 0 && {_dtype == 0}}) then {
	_addbase = false;
};

private _listctrl = _display displayCtrl 1500;
lbClear _listctrl;

private _cidx = -1;
private _selidx = 0;

d_tele_prev_sel = -1;

d_respawn_anim_markers = [];
d_respawn_posis = [];
d_respawn_ismhq = [];

if (_addbase) then {
	//__TRACE_1("","_addbase")
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1251");
	_listctrl lbSetData [_cidx, "D_BASE_D"];
	_selidx = _cidx;
	d_beam_target = "D_BASE_D";
	private _text = if (_dtype == 1 || {d_tele_dialog == 0}) then {
		format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1251"]
	} else {
		format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1251"]
	};
	(_display displayCtrl 100110) ctrlSetText _text;
	["D_BASE_D", getPosASL d_FLAG_BASE, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack "D_BASE_D";
	d_respawn_mar_str = "D_BASE_D";
	d_respawn_posis pushBack (getPosASL d_FLAG_BASE);
	d_respawn_ismhq pushBack false;
} else {
	d_respawn_mar_str = "";
};

//__TRACE_1("","d_mob_respawns")

#define __COLRED [1,0,0,0.7]
private _logtxt = "";

{
	private _mrs = missionNamespace getVariable [_x # 0, objNull];
	//__TRACE_2("","_mrs","_x")
	if (!isNull _mrs) then {
		private _lbcolor = call {
			if (_mrs getVariable ["d_in_air", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_592", _x # 1, _logtxt]; __COLRED};
			if (speed _mrs > 4) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_593", _x # 1] + _logtxt + "\n"; __COLRED};
			if (!(_mrs isKindOf "Ship") && {surfaceIsWater (getPosWorld _mrs)}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_594", _x # 1, _logtxt]; __COLRED};
			if (!alive _mrs) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_595", _x # 1, _logtxt]; __COLRED};
			if ( !(_mrs isKindOf "Ship") && {!(_mrs getVariable ["d_MHQ_Deployed", false])}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_596", _x # 1, _logtxt]; __COLRED};
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
			(_display displayCtrl 100110) ctrlSetText _text;
		};
		[_x # 0, visiblePositionASL _mrs, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
		d_respawn_anim_markers pushBack (_x # 0);
		d_respawn_posis pushBack (visiblePositionASL _mrs);
		d_respawn_ismhq pushBack true;
	};
} forEach d_mob_respawns;

{
	//__TRACE_1("","_x")
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
		(_display displayCtrl 100110) ctrlSetText _text;
	};
	[_x # 0, _x # 1, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack (_x # 0);
	d_respawn_posis pushBack (_x # 1);
	d_respawn_ismhq pushBack false;
} forEach d_additional_respawn_points;

private _has_sql = 0;
d_resp_lead_idx = -1;

private _show_respawnatsql = false;
if (d_respawnatsql == 2 || {!(player getVariable ["xr_isleader", false]) && {count units player > 1 && {player != leader (group player)}}}) then {
	// d_respawnatsql == 2 always show respawn button, determine color later
	_show_respawnatsql = true;
};

private _respawn_target = nil;
if (_show_respawnatsql) then {
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1705a");
	_listctrl lbSetData [_cidx, "D_SQL_D"];
	_has_sql = 1;
	if (leader (group player) != player && [leader (group player)] call d_fnc_iseligibletospawnnewunit) then {
		// the squad leader is eligible as a spawn target
		_respawn_target = leader (group player);
	};
	if (isNil "_respawn_target" && d_respawnatsql == 2) then {
		// d_respawnatsql == 2 allows respawn on squadmates
		// are any squadmates alive and eligible as a spawn target?
		{
			if (_x != player && [_x] call d_fnc_iseligibletospawnnewunit) exitWith {
				_respawn_target = _x;
			};
		} forEach (units player);
	};
	private _lbcolor = if (!isNil "_respawn_target") then {
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
		(_display displayCtrl 100110) ctrlSetText _text;
	};
	["D_SQL_D", visiblePositionASL _respawn_target, "ICON", "ColorWhite", [1.5,1.5], "", 0, "selector_selectedMission"] call d_fnc_CreateMarkerLocal;
	d_respawn_anim_markers pushBack "D_SQL_D";
	d_resp_lead_idx = d_respawn_posis pushBack (visiblePositionASL _respawn_target);
	d_respawn_ismhq pushBack false;
};

//__TRACE_1("","d_respawn_posis")
//__TRACE_1("","d_respawn_posis")

//__TRACE_1("","_logtxt")

if (_logtxt != "") then {
	(_display displayCtrl 11002) ctrlSetText _logtxt;
};

private _can_add_mapclick = true;

if (!isNil "xr_pl_no_lifes" && {xr_pl_no_lifes}) then {
	(_display displayCtrl 100102) ctrlEnable false;
	(_display displayCtrl 123321) ctrlEnable false;
	(_display displayCtrl 1500) ctrlEnable false;
	_can_add_mapclick = false;
};
if (!xr_respawn_available) then {
	(_display displayCtrl 100102) ctrlEnable false;
};

if (_can_add_mapclick) then {
	["d_exactpos_radius_mar", [0, 0, 0], "ELLIPSE", "ColorBlack", [40, 40], "", 0, "", "BDiagonal", 1] call d_fnc_CreateMarkerLocal;
	["d_exactpos_sel_mar", [0, 0, 0], "ICON", "ColorWhite", [1,1], "", 0, "waypoint"] call d_fnc_CreateMarkerLocal;
	"d_exactpos_radius_mar" setMarkerAlphaLocal 0;
	"d_exactpos_sel_mar" setMarkerAlphaLocal 0;
	d_rmapclick_type = _dtype;
	d_resp_map_click_eh = addMissionEventHandler ["MapSingleClick", {call d_fnc_rmapclick}];
};

d_lb_tele_first = true;

if (_cidx > -1) then {
	_listctrl lbSetCurSel _selidx;
};

[_display] call xr_fnc_spectdlginit;

_has_sql spawn d_fnc_respawn_mar_anim;
