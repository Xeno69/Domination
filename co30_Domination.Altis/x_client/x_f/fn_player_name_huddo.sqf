// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_player_name_huddo.sqf"
#include "..\..\x_setup.sqf"

disableSerialization;

#define __d_textsize_dr3d  0.03333

if (d_show_pname_hud && {!visibleMap && {isNil "d_is_sat_on"}}) then {
	if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}) then {
		private _grpp = group player;
		private _cam2world = positionCameraToWorld [0,0,0];
		{
			private _u = missionNamespace getVariable _x;
			if (!isNil "_u" && {alive _u && {_u != player && {!(_u getVariable ["xr_pluncon", false]) && {isNil {_u getVariable "xr_plno3dd"} && {!(_u getVariable ["ace_isunconscious", false])}}}}}) then {
				private _distu = _cam2world distance _u;
				if (_distu <= d_dist_pname_hud) then {
					private _vu = vehicle _u;
					private _targetPos = _vu modelToWorldVisual (_u selectionPosition "Head");
					if !(_targetPos isEqualTo []) then {
						private _dodraw = if (isNull objectParent _u) then {
							true
						} else {
							if (crew _vu isEqualTo 1) exitWith {true};
							if (_u == commander _vu) exitWith {true};
							if (_u == gunner _vu && {!isPlayer commander _vu}) exitWith {true};
							if (_u == driver _vu && {!isPlayer commander _vu && {!isPlayer gunner _vu}}) exitWith {true};
							false
						};
						if (_dodraw) then {
							private _tex = "";
							private _rtex = "";
							if (_distu <= 200) then {
								_tex = if (d_show_player_namesx == 1) then {
									[_u] call d_fnc_gethpname
								} else {
									if (d_show_player_namesx == 2) then {
										str(9 - round(9 * damage _u))
									} else {
										""
									};
								};
								if (isNil "_tex") then {_tex = _u call d_fnc_getplayername};
								_rtex = (rank _u) call d_fnc_getrankpic;
							} else {
								_tex = "*";
								_rtex = "#(argb,8,8,3)color(0,0,0,0)";
							};
							drawIcon3D [_rtex, [d_pnhudothercolor, d_pnhudgroupcolor] select (group _u == _grpp), _targetPos vectorAdd [0, 0, 0.4 + (_distu / 15) / 1.5], 0.4, 0.4, 0, _tex, 1, __d_textsize_dr3d, "RobotoCondensed"]; //PuristaSemibold PuristaMedium
						};
					};
				};
			};
			false
		} count d_player_entities;
	};
} else {
	if (!d_show_pname_hud) then {
		removeMissionEventHandler ["Draw3D", d_phudraw3d];
		d_phudraw3d = -1;
	};
};