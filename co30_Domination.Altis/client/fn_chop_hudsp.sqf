// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_chop_hudsp.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private ["_chdispx", "_chdispx2"];

disableSerialization;

#define __ui_forward "pics\ui_tankdir_forward_ca.paa"
#define __ui_back "pics\ui_tankdir_back_ca.paa"
#define __ui_left "pics\ui_tankdir_left_ca.paa"
#define __ui_right "pics\ui_tankdir_right_ca.paa"
#define __ui_tohigh "pics\ui_tankdir_turret_ca.paa"
#define __ui_ok "pics\ui_tankdir_tower_ca.paa"
#define __CTRL2(B) (_chdispx displayCtrl B)
#define __CTRL3(B) (_chdispx2 displayCtrl B)

[localize "STR_DOM_MISSIONSTRING_192", localize "STR_DOM_MISSIONSTRING_193", localize "STR_DOM_MISSIONSTRING_194", localize "STR_DOM_MISSIONSTRING_195", vehicle player, false, false, false] params ["_distvstr", "_typestr", "_liftstr", "_distgrstr", "_vec", "_doexitit", "_chophud_shown", "_chophud2_shown"];

if (player == driver _vec) then {
	private _vtype = _vec getVariable ["d_vec_type", ""];
	if (_vtype == "MHQ") then {
		d_playerInMHQ = true;
		[_vec, _vtype] spawn d_fnc_vec_welcome_message;
	};
};

private _msgshown = false;

while {d_player_in_vec} do {
	if (player == currentPilot _vec) then {
		private _chopttype = _vec getVariable ["d_choppertype", -1];
		__TRACE_2("","_vec","_chopttype")
		if (!_msgshown && {_chopttype > -1}) then {
			_msgshown = true;
			private _chop_welcome_scr = [_chopttype, _vec] spawn d_fnc_chopper_welcome2;
			sleep 0.321;
			while {true} do {
				sleep 0.3;
				if (scriptDone _chop_welcome_scr) exitWith {};
			};
		};
		if (_chopttype in [0,1]) then {
			private _search_height = 0;
			private _lift_height = 0;
			if (_chopttype == 1) then {
				_search_height = 70;
				_lift_height = 50;
			} else {
				_search_height = 50;
				_lift_height = 50;
			};
			private _hudoff = true;

			private _sling_cam = objNull;
			private _pip_cam_on = false;
			private _prev_liftobj = objNull;

			while {d_player_in_vec && {d_player_canu && {player == currentPilot _vec}}} do {
				if (d_chophud_on && {!visibleMap}) then {
					if (isNil "_vec") then {_vec = vehicle player};
					_hudoff = false;
					private _liftobj = objNull;
					private _check_cond = false;

					if (_vec getVariable ["d_vec_attached", false]) then {
						// no need to check for nearest!
						_liftobj = _vec getVariable ["d_Attached_Vec", objNull];
						_check_cond = !isNull _liftobj;
					} else {
						private _nobjects = nearestObjects [_vec, ["LandVehicle", "Air"], _search_height];
						__TRACE_2("","_vec","_nobjects")

						if (_nobjects isNotEqualTo []) then {
							_nobjects params ["_dummy"];
							if (isNil "_vec") then {_vec = vehicle player};
							if (_dummy == _vec) then {
								if (count _nobjects > 1) then {_liftobj = _nobjects # 1};
							} else {
								_liftobj = _dummy;
							};
						};

						if (!isNull _liftobj) then {
							if (_liftobj isKindOf "CAManBase") then {
								_liftobj = objNull;
							} else {
								private _marp = _liftobj getVariable ["d_WreckMaxRepair", d_WreckMaxRepair];
								__TRACE_2("","_vec","_marp")

								_check_cond = if (_chopttype == 1) then {
									private _isvalid = _liftobj getVariable "d_canbewlifted";
									if (isNil "_isvalid") then {
										_isvalid = !isNil {_liftobj getVariable "d_isspecialvec"};
										_liftobj setVariable ["d_canbewlifted", _isvalid];
									};
									(!isNull _liftobj && {_isvalid && {_marp > 0 && {damage _liftobj >= 1}}})
								} else {
									private _isvalid = _liftobj getVariable ["d_liftit", false] && {!(_liftobj getVariable ["d_no_lift", false])};
#ifndef __TT__
									(!isNull _liftobj && {_isvalid  && {(getPosVisual _vec) # 2 > 2.5}})
#else
									(!isNull _liftobj && {_isvalid && {(getPosVisual _vec) # 2 > 2.5 && {_liftobj getVariable ["d_side", d_player_side] == d_player_side}}})
#endif
								};
							};
						};
					};

					sleep 0.001;
					__TRACE_3("","_vec","_check_cond","_liftobj")

					if (_check_cond) then {
						if (!_chophud_shown) then {
							"d_chopper_lift_hud" cutRsc ["d_chopper_lift_hud", "PLAIN"];
							_chophud_shown = true;
							_chdispx = uiNamespace getVariable "d_chopper_lift_hud";
							__CTRL2(64440) ctrlSetText ([localize "STR_DOM_MISSIONSTRING_197", localize "STR_DOM_MISSIONSTRING_196"] select (_chopttype == 1));
						};

						if (_prev_liftobj != _liftobj) then {
							private _tofn = configOf _liftobj;

							private _type_name = [_tofn] call d_fnc_GetDisplayName;
							__CTRL2(64438) ctrlSetText ([format [_liftstr, _type_name], format [_typestr, _type_name]] select !(_vec getVariable ["d_vec_attached", false]));

							private _picstat = getText (_tofn>>"picture");
							private _picvcicons = getText (configFile>>"CfgVehicleIcons">>_picstat);
							__CTRL2(64439) ctrlSetText ([_picstat, _picvcicons] select (_picvcicons != ""));
							if (!isPiPEnabled) then {
								_prev_liftobj = _liftobj;
							};
						};

						if (isPipEnabled && {!_pip_cam_on || {_prev_liftobj != _liftobj}}) then {
							"d_RscPIP" cutText ["", "plain"];
							if (!isNull _sling_cam) then {
								_sling_cam cameraEffect ["terminate","back"];
								camDestroy _sling_cam;
							};
							private _cam_loc = _vec selectionPosition "slingcamera";
							if (_cam_loc isEqualTo [0,0,0]) then {
								_cam_loc = _vec selectionPosition "slingload0";
								if (_cam_loc isEqualTo [0,0,0]) then {
									_cam_loc = [0,0,-2.8];
								};
								_cam_loc = [_cam_loc # 0, (_cam_loc # 1) - 5, (_cam_loc # 2) - 0.1];
							} else {
								_cam_loc = [_cam_loc # 0, _cam_loc # 1, (_cam_loc # 2) - 0.2];
							};

							"d_RscPIP" cutRsc ["d_RscPIP", "PLAIN", 0, false];
							private _ctrlpip = (uiNamespace getVariable "d_RscPIP") displayCtrl 2300;
							_ctrlpip ctrlSetPositionY (((ctrlPosition _ctrlpip) # 1) + 0.3);
							_ctrlpip ctrlSettext format ["#(argb,256,256,1)r2t(%1,1.0)", "d_choprendtar0"];
							_ctrlpip ctrlSettextcolor [1,1,1,1];
							_ctrlpip ctrlCommit 0;

							_sling_cam = "camera" camCreate (getPosVisual _vec);
							_sling_cam attachTo [_vec, _cam_loc];
							_sling_cam camPreparetarget _liftobj;
							_sling_cam camCommitprepared 0;
							_sling_cam camPrepareFOV 0.9;
							_sling_cam camCommit 2;
							_sling_cam cameraEffect ["internal", "back", "d_choprendtar0"];
							_pip_cam_on = true;
							_prev_liftobj = _liftobj;
						};

						if !(_vec getVariable ["d_vec_attached", false]) then {
							__CTRL2(64441) ctrlSetText format [_distvstr, round (_vec distance _liftobj)];
							if (_vec inArea [_liftobj, 10, 10, 0, false] && {getPosVisual _vec # 2 < _lift_height}) then {
								__CTRL2(64448) ctrlSetText __ui_ok;
							} else {
								__CTRL2(64442) ctrlSetText (if (getPosVisual _vec # 2 >= _lift_height) then {localize "STR_DOM_MISSIONSTRING_198"} else {""});
								__CTRL2(64447) ctrlSetText __ui_tohigh;
								private _angle = _vec getRelDir _liftobj;
								__TRACE_1("","_angle")
								__CTRL2(64444) ctrlSetText (["", __ui_forward] select (_angle >= 290 || {_angle <= 70}));
								__CTRL2(64446) ctrlSetText (["", __ui_right] select (_angle >= 20 && {_angle <= 160}));
								__CTRL2(64443) ctrlSetText (["", __ui_back] select (_angle <= 250 && {_angle >= 110}));
								__CTRL2(64445) ctrlSetText (["", __ui_left] select (_angle <= 340 && {_angle >= 200}));
								sleep 0.001;
							};
						} else {
							private _ddx1 = [round ((getPosASLVisual _liftobj) # 2), round ((getPosVisual _liftobj) # 2)] select (!surfaceIsWater (getPosASL _liftobj));
							__CTRL2(64441) ctrlSetText format [_distgrstr, _ddx1];
							__CTRL2(64442) ctrlSetText (localize "STR_DOM_MISSIONSTRING_199");
							sleep 0.001;
						};
					} else {
						if (_chophud_shown) then {
							"d_chopper_lift_hud" cutFadeOut 0;
							_chophud_shown = false;
						};
						if (!_chophud2_shown) then {
							"d_chopper_lift_hud2" cutRsc ["d_chopper_lift_hud2", "PLAIN"];
							_chophud2_shown = true;
						};
						_chdispx2 = uiNamespace getVariable "d_chopper_lift_hud2";
						__CTRL3(61422) ctrlSetText ([localize "STR_DOM_MISSIONSTRING_197", localize "STR_DOM_MISSIONSTRING_196"] select _chopttype);


						if (_pip_cam_on) then {
							"d_RscPIP" cutText ["", "plain"];
							_sling_cam cameraEffect ["terminate","back"];
							camDestroy _sling_cam;
							_sling_cam = objNull;
							_pip_cam_on = false;
							_prev_liftobj = objNull;
						};

					};
				} else {
					if (!_hudoff) then {
						_hudoff = true;
						if (_chophud_shown) then {
							"d_chopper_lift_hud" cutFadeOut 0;
							_chophud_shown = false;
						};
						if (_chophud2_shown) then {
							"d_chopper_lift_hud2" cutFadeOut 0;
							_chophud2_shown = false;
						};
					};

					if (_pip_cam_on) then {
						"d_RscPIP" cutText ["","plain"];
						_sling_cam cameraEffect ["terminate","back"];
						camDestroy _sling_cam;
						_sling_cam = objNull;
						_pip_cam_on = false;
						_prev_liftobj = objNull;
					};

				};
				sleep 0.231;
			};
			if (_chophud_shown) then {
				"d_chopper_lift_hud" cutFadeOut 0;
				_chophud_shown = false;
			};
			if (_chophud2_shown) then {
				"d_chopper_lift_hud2" cutFadeOut 0;
				_chophud2_shown = false;
			};

			if (_pip_cam_on) then {
				"d_RscPIP" cutText ["","plain"];
				_sling_cam cameraEffect ["terminate","back"];
				camDestroy _sling_cam;
				_sling_cam = objNull;
				_pip_cam_on = false;
				_prev_liftobj = objNull;
			};
		} else {
			if (!_chophud2_shown) then {
				"d_chopper_lift_hud2" cutRsc ["d_chopper_lift_hud2", "PLAIN"];
				_chophud2_shown = true;
			};
			_chdispx2 = uiNamespace getVariable "d_chopper_lift_hud2";
			__CTRL3(61422) ctrlSetText (localize "STR_DOM_MISSIONSTRING_200");
			while {d_player_in_vec && {d_player_canu && {player == currentPilot _vec}}} do {
				sleep 0.421;
			};
			_doexitit = true;
			if (_chophud2_shown) then {
				"d_chopper_lift_hud2" cutFadeOut 0;
				_chophud2_shown = false;
			};
		};
	};
	if (_doexitit) exitWith {};
	sleep 0.432;
};

if (d_playerInMHQ) then {
	d_playerInMHQ = false;
};
