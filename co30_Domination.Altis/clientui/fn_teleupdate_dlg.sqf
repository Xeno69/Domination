// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

if (d_x_loop_end) exitWith {};

disableSerialization;

params ["_wone"];

//__TRACE_1("","_wone")

private _disp = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);

if (isNil "_disp") exitWith {};

private _listctrl = _disp displayCtrl 1500;

#define __COLRED [1,0,0,0.7]

private _respawn_target = nil;
for "_i" from 0 to ((lbSize _listctrl) - 1) do {
	private _lbdata = _listctrl lbData _i;
	//__TRACE_1("","_lbdata")
	private _uidx = d_add_resp_points_uni find _lbdata;
	//__TRACE_1("","_uidx")
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
						if (!(_mrs isKindOf "Ship") && {surfaceIsWater (getPosWorld _mrs)}) exitWith {__COLRED};
						if (!alive _mrs) exitWith {__COLRED};
						if (!(_mrs isKindOf "Ship") && {!(_mrs getVariable ["d_MHQ_Deployed", false])}) exitWith {__COLRED};
						if (_mrs getVariable ["d_enemy_near", false]) exitWith {__COLRED};
						if (_mrs isKindOf "Ship" && {_mrs emptyPositions "cargo" == 0}) exitWith {__COLRED};
						_mravailable = true;
						[1,1,1,1];
					};
					_listctrl lbSetColor [_i, _lbcolor];
				};
				//__TRACE_1("","_mravailable")
				//__TRACE_2("","lbCurSel _listctrl","_i")
				if (lbCurSel _listctrl == _i) then {
					if (_mravailable) then {
						private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
							format [localize "STR_DOM_MISSIONSTRING_607", _listctrl lbText _i]
						} else {
							format [localize "STR_DOM_MISSIONSTRING_605", _listctrl lbText _i]
						};
						(_disp displayCtrl 100102) ctrlEnable true;
						//__TRACE_1("MRR enable true","_lbdata")
						(_disp displayCtrl 100110) ctrlSetText _text;
					} else {
						(_disp displayCtrl 100102) ctrlEnable false;
						//__TRACE_1("MRR enable false","_lbdata")
						(_disp displayCtrl 100110) ctrlSetText "";
					};
				};
			} else {
				if (d_respawnatsql in [0,2] && _lbdata == "D_SQL_D") then {
					// d_respawnatsql == 2 always show button, otherwise only show if isleader == false (a squadmate)
					if (d_respawnatsql == 2 || !(player getVariable ["xr_isleader", false])) then {
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
							[1,1,1,1]
						} else {
							__COLRED
						};
						_listctrl lbSetColor [_i, _lbcolor];
						if (lbCurSel _listctrl == _i) then {
							if (!isNil "_respawn_target") then {
								private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
								format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1705a"]
								} else {
									format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1705a"]
								};
								(_disp displayCtrl 100102) ctrlEnable true;
								//__TRACE_1("SQL enable true","_lbdata")
								(_disp displayCtrl 100110) ctrlSetText _text;
							} else {
								(_disp displayCtrl 100102) ctrlEnable false;
								//__TRACE_1("SQL enable false","_lbdata")
								(_disp displayCtrl 100110) ctrlSetText "";
							};
						};
					};
				};
			};
		} else {
			if (lbCurSel _listctrl == _i && {xr_respawn_available && {!ctrlEnabled (_disp displayCtrl 100102)}}) then {
				//__TRACE("xr_respawn_available 1111")
				(_disp displayCtrl 100102) ctrlEnable true;
			};
		};
	} else {
		//__TRACE_1("_listctrl lbText _i","_listctrl lbText _i")
		if (lbCurSel _listctrl == _i && {xr_respawn_available && {!ctrlEnabled (_disp displayCtrl 100102)}}) then {
			(_disp displayCtrl 100102) ctrlEnable true;
		};
		//__TRACE_1("Additional enable true","_lbdata")
	};
};

if (!isNil "xr_pl_no_lifes" && {xr_pl_no_lifes && {ctrlEnabled (_disp displayCtrl 100102)}}) then {
	(_disp displayCtrl 100102) ctrlEnable false;
	(_disp displayCtrl 123321) ctrlEnable false;
	(_disp displayCtrl 1500) ctrlEnable false;
};
if (!xr_respawn_available && {ctrlEnabled (_disp displayCtrl 100102)}) then {
	(_disp displayCtrl 100102) ctrlEnable false;
};
