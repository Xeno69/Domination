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
		private ["_distu", "_vu", "_targetPos", "_dodraw", "_tex", "_rtex"];
		{
			_distu = _cam2world distance _x;
			if (_distu <= d_dist_pname_hud) then {
				_vu = vehicle _x;
				_targetPos = _vu modelToWorldVisual (_x selectionPosition "Head");
				if !(_targetPos isEqualTo []) then {
					_dodraw = if (isNull objectParent _x) then {
						true
					} else {
						if (crew _vu isEqualTo 1) exitWith {true};
						if (_x == commander _vu) exitWith {true};
						if (_x == gunner _vu && {!isPlayer commander _vu}) exitWith {true};
						if (_x == driver _vu && {!isPlayer commander _vu && {!isPlayer gunner _vu}}) exitWith {true};
						false
					};
					if (_dodraw) then {
						_tex = "";
						_rtex = "";
						if (_distu <= 200) then {
							_tex = if (d_show_player_namesx == 1) then {
								[_x] call d_fnc_gethpname
							} else {
								if (d_show_player_namesx == 2) then {
									str(9 - round(9 * damage _x))
								} else {
									""
								};
							};
							if (isNil "_tex") then {_tex = _x call d_fnc_getplayername};
							_rtex = _x call d_fnc_getrankpic;
						} else {
							_tex = "*";
							_rtex = "#(argb,8,8,3)color(0,0,0,0)";
						};
						drawIcon3D [_rtex, [d_pnhudothercolor, d_pnhudgroupcolor] select (group _x == _grpp), _targetPos vectorAdd [0, 0, 0.4 + (_distu / 15) / 1.5], 0.4, 0.4, 0, _tex, 1, __d_textsize_dr3d, "RobotoCondensed"]; //PuristaSemibold PuristaMedium
					};
				};
			};
		} forEach (d_allplayers select {alive _x && {_x != player && {!(_x getVariable ["xr_pluncon", false]) && {isNil {_x getVariable "xr_plno3dd"} && {!(_x getVariable ["ace_isunconscious", false])}}}}});
	};
} else {
	if (!d_show_pname_hud) then {
		removeMissionEventHandler ["Draw3D", d_phudraw3d];
		d_phudraw3d = -1;
	};
};