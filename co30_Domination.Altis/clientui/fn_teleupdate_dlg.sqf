// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_teleupdate_dlg.sqf"
#include "..\x_setup.sqf"

if (d_x_loop_end) exitWith {};

disableSerialization;

#define __CTRL(A) (_disp displayCtrl A)

params ["_wone"];

__TRACE_1("","_wone")

private _disp = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);

if (isNil "_disp") exitWith {};

private _listctrl = __CTRL(1500);

#define __COLRED [1,0,0,0.7]

for "_i" from 0 to ((lbSize _listctrl) - 1) do {
	private _lbdata = _listctrl lbData _i;
	__TRACE_1("","_lbdata")
	private _uidx = d_add_resp_points_uni find _lbdata;
	__TRACE_1("","_uidx")
	if (_uidx == -1) then {
		if (_lbdata != "D_BASE_D") then {
			if (_lbdata != "D_SQL_D") then {
				private _mravailable = false;
				private _mrs = missionNamespace getVariable [_lbdata, objNull];
				if (!isNull _mrs) then {
					private _lbcolor = call {
						if (!xr_respawn_available) exitWith {__COLRED};
						if (_mrs getVariable ["d_in_air", false]) exitWith {__COLRED};
						if (speed _mrs > 4) exitWith {__COLRED};
						if (surfaceIsWater (getPosWorld _mrs)) exitWith {__COLRED};
						if (!alive _mrs) exitWith {__COLRED};
						if !(_mrs getVariable ["d_MHQ_Deployed", false]) exitWith {__COLRED};
						if (_mrs getVariable ["d_enemy_near", false]) exitWith {__COLRED};
						_mravailable = true;
						[1,1,1,1.0];
					};
					_listctrl lbSetColor [_i, _lbcolor];
				};
				__TRACE_1("","_mravailable")
				__TRACE_2("","lbCurSel _listctrl","_i")
				if (lbCurSel _listctrl == _i) then {
					if (_mravailable) then {
						private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
							format [localize "STR_DOM_MISSIONSTRING_607", _listctrl lbText _i]
						} else {
							format [localize "STR_DOM_MISSIONSTRING_605", _listctrl lbText _i]
						};
						__CTRL(100102) ctrlEnable true;
						__TRACE_1("MRR enable true","_lbdata")
						__CTRL(100110) ctrlSetText _text;
					} else {
						__CTRL(100102) ctrlEnable false;
						__TRACE_1("MRR enable false","_lbdata")
						__CTRL(100110) ctrlSetText "";
					};
				};
			} else {
				if (d_respawnatsql == 0 && {_lbdata == "D_SQL_D" && {!(player getVariable ["xr_isleader", false]) && {count units (group player) > 1 && {player != leader (group player)}}}}) then {
					private _leader = leader (group player);
					private _leadavail = false;
					private _emptycargo = [0, (vehicle _leader) emptyPositions "cargo"] select (!isNull objectParent _leader);
					private _lbcolor = if (xr_respawn_available && {alive _leader} && {!(_leader getVariable ["xr_pluncon", false])} && {!(_leader getVariable ["ace_isunconscious", false])} && {_emptycargo > 0 || {(getPos _leader) # 2 < 10}} && {!(_leader call d_fnc_isswimming)} && {!underwater _leader}) then {
						_leadavail = true;
						[1,1,1,1.0]
					} else {
						__COLRED
					};
					_listctrl lbSetColor [_i, _lbcolor];
					if (lbCurSel _listctrl == _i) then {
						if (_leadavail) then {
							private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
							format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1705a"]
							} else {
								format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1705a"]
							};
							__CTRL(100102) ctrlEnable true;
							__TRACE_1("SQL enable true","_lbdata")
							__CTRL(100110) ctrlSetText _text;
						} else {
							__CTRL(100102) ctrlEnable false;
							__TRACE_1("SQL enable false","_lbdata")
							__CTRL(100110) ctrlSetText "";
						};
					};
				};
			};
		} else {
			if (lbCurSel _listctrl == _i && {xr_respawn_available && {!ctrlEnabled __CTRL(100102)}}) then {
				__TRACE("xr_respawn_available 1111")
				__CTRL(100102) ctrlEnable true;
			};
		};
	} else {
		__TRACE_1("_listctrl lbText _i","_listctrl lbText _i")
		if (lbCurSel _listctrl == _i && {xr_respawn_available && {!ctrlEnabled __CTRL(100102)}}) then {
			__CTRL(100102) ctrlEnable true;
		};
		__TRACE_1("Additional enable true","_lbdata")
	};
};

if (!isNil "xr_pl_no_lifes" && {xr_pl_no_lifes && {ctrlEnabled __CTRL(100102)}}) then {
	__CTRL(100102) ctrlEnable false;
};
if (!xr_respawn_available && {ctrlEnabled __CTRL(100102)}) then {
	__CTRL(100102) ctrlEnable false;
};
