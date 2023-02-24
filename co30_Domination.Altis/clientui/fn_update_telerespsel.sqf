// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_cparams", "_wone"];
_cparams params ["_ctrl", "_sel"];

__TRACE_1("","_this")

if (_sel == -1) exitWith {};

disableSerialization;

if (_sel == d_tele_prev_sel) exitWith {};
d_tele_prev_sel = _sel;

private _data = _ctrl lbData _sel;

__TRACE_1("","_data")

#define __COLRED [1,0,0,0.7]
private _mravailable = false;
private _respawn_target = nil;
private _not_avail_array = [];
private _disp = [uiNamespace getVariable "XR_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);

private _uidx = d_add_resp_points_uni find _data;

__TRACE_1("","_uidx")

if (_uidx == -1) then {
	if (_data != "D_BASE_D" && {_data != "D_SQL_D"}) then {
		private _logtxt = ctrlText (_disp displayCtrl 11002);

		private _mrs = missionNamespace getVariable [_data, objNull];
		__TRACE_1("","_mrs")
		if (!isNull _mrs) then {
			private _curaridx = _not_avail_array pushBack _data;
			private _lbcolor = call {
				if (_mrs getVariable ["d_in_air", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_592",  _ctrl lbText _sel, _logtxt]; __COLRED};
				if (speed _mrs > 4) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_593", _ctrl lbText _sel, _logtxt]; __COLRED};
				if (!(_mrs isKindOf "Ship") && {surfaceIsWater (getPosWorld _mrs)}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_594", _ctrl lbText _sel, _logtxt]; __COLRED};
				if (!alive _mrs) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_595", _ctrl lbText _sel, _logtxt]; __COLRED};
				if (!(_mrs isKindOf "Ship") && {!(_mrs getVariable ["d_MHQ_Deployed", false])}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_596", _ctrl lbText _sel, _logtxt]; __COLRED};
				if (_mrs getVariable ["d_enemy_near", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_597", _ctrl lbText _sel, _logtxt]; __COLRED};
				if (_mrs isKindOf "Ship" && {_mrs emptyPositions "cargo" == 0}) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_2023", _ctrl lbText _sel, _logtxt]; __COLRED};
				_not_avail_array deleteAt _curaridx;
				_mravailable = true;
				[1,1,1,1.0];
			};
			_ctrl lbSetColor [_sel, _lbcolor];

			if (_logtxt != "" && {!d_lb_tele_first}) then {
				(_disp displayCtrl 11002) ctrlSetText _logtxt;
			};
		};
	} else {
		if (d_respawnatsql in [0,2] && {_data == "D_SQL_D"}) then {
			// d_respawnatsql == 2 always show button, otherwise only show if isleader == false (a squadmate)
			__TRACE("1","d_respawnatsql")
			if (d_respawnatsql == 2 || !(player getVariable ["xr_isleader", false])) then {
				__TRACE("is not leader")
				if (leader (group player) != player && [leader (group player)] call d_fnc_iseligibletospawnnewunit) then {
					// the squad leader is eligible as a spawn target
					_respawn_target = leader (group player);
					__TRACE("1","_respawn_target")
				};
				if (isNil "_respawn_target" && {d_respawnatsql == 2}) then {
					// d_respawnatsql == 2 allows respawn on squadmates
					// are any squadmates alive and eligible as a spawn target?
					{
						if (_x != player && [_x] call d_fnc_iseligibletospawnnewunit) exitWith {
							_respawn_target = _x;
							__TRACE("2","_respawn_target")
						};
					} forEach (units player);
				};
				private _lbcolor = if (!isNil "_respawn_target") then {
					[1,1,1,1.0]
				} else {
					_not_avail_array pushBack "D_SQL_D";
					(_disp displayCtrl 11002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1706");
					__COLRED
				};
				_ctrl lbSetColor [_sel, _lbcolor];
			};
		};
	};
};

d_lb_tele_first = false;

__TRACE_1("","d_additional_respawn_points")

__TRACE_1("","_uidx")

d_cur_map_endpos = nil;
d_alt_map_pos = nil;

private _end_pos = if (_uidx == -1) then {
	call {
		if (_data == "D_BASE_D") exitWith {
			getPosATL d_FLAG_BASE;
		};
		if (_data == "D_SQL_D") exitWith {
			if (!isNil "_respawn_target") then {
				visiblePosition _respawn_target;
			} else {
				getPosATL d_FLAG_BASE;
			};
		};
		private _rppp = visiblePosition (missionNamespace getVariable _data);
		if (_mravailable && {!((missionNamespace getVariable _data) isKindOf "Ship")}) then {
			d_cur_map_endpos = _rppp;
		};
		_rppp
	};
} else {
	(d_additional_respawn_points # _uidx) # 1;
};

__TRACE_1("","_end_pos")

d_respawn_mar_str = _data;

if (_wone == 1 && {!xr_respawn_available}) then {
	_mravailable = false;
	_data = "";
};

__TRACE_3("","_data","_mravailable","_uidx")
__TRACE_1("","xr_respawn_available")
__TRACE_1("","_not_avail_array")

if (_data != "" && {_mravailable || {_data == "D_BASE_D" || {!isNil "_respawn_target" || {_uidx != -1}}}}) then {
	d_beam_target = _data;
	private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
		format [localize "STR_DOM_MISSIONSTRING_607", _ctrl lbText _sel]
	} else {
		format [localize "STR_DOM_MISSIONSTRING_605", _ctrl lbText _sel]
	};
	(_disp displayCtrl 100110) ctrlSetText _text;
	(_disp displayCtrl 100102) ctrlEnable true;
	__TRACE("enable true")
} else {
	__TRACE_1("","d_beam_target")
	__TRACE_1("","d_last_beam_target")
	(_disp displayCtrl 100110) ctrlSetText "";
	(_disp displayCtrl 100102) ctrlEnable false;
	__TRACE("enable false 2")
	if (d_beam_target == "D_BASE_D" || {_uidx != -1}) exitWith {};
	if !(d_beam_target in _not_avail_array) exitWith {};
	d_beam_target = "";
};

if (!isNil "xr_pl_no_lifes" && {xr_pl_no_lifes && {ctrlEnabled (_disp displayCtrl 100102)}}) then {
	(_disp displayCtrl 100102) ctrlEnable false;
	(_disp displayCtrl 123321) ctrlEnable false;
	(_disp displayCtrl 1500) ctrlEnable false;
};
if (!xr_respawn_available && {ctrlEnabled (_disp displayCtrl 100102)}) then {
	(_disp displayCtrl 100102) ctrlEnable false;
};

__TRACE_1("","d_beam_target")

private _ctrlmap = _disp displayCtrl 900;
ctrlMapAnimClear _ctrlmap;

_ctrlmap ctrlMapAnimAdd [0, 1, getPosATL player];
_ctrlmap ctrlMapAnimAdd [1.2, 1, _end_pos];
if (!isNil "d_cur_map_endpos") then {
	_ctrlmap ctrlMapAnimAdd [0.8, (2 * 110 / d_island_x_max) / (safeZoneH * 0.717), _end_pos];
} else {
	_ctrlmap ctrlMapAnimAdd [0.8, 0.5, _end_pos];
};
ctrlMapAnimCommit _ctrlmap;

if (!isNil "d_cur_map_endpos") then {
	"d_exactpos_radius_mar" setMarkerPosLocal _end_pos;
	"d_exactpos_radius_mar" setMarkerAlphaLocal 1;
	"d_exactpos_sel_mar" setMarkerPosLocal _end_pos;
	"d_exactpos_sel_mar" setMarkerAlphaLocal 1;
	(_disp displayCtrl 11003) ctrlShow true;
	(_disp displayCtrl 11004) ctrlShow true;
} else {
	"d_exactpos_radius_mar" setMarkerPosLocal [0, 0, 0];
	"d_exactpos_radius_mar" setMarkerAlphaLocal 0;
	"d_exactpos_sel_mar" setMarkerPosLocal [0, 0, 0];
	"d_exactpos_sel_mar" setMarkerAlphaLocal 0;
	(_disp displayCtrl 11003) ctrlShow false;
	(_disp displayCtrl 11004) ctrlShow false;
};
