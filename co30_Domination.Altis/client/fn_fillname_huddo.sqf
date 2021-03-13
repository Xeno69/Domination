// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_fillname_huddo.sqf"
#include "..\x_setup.sqf"

__TRACE("fillname_huddo")

#define __d_textsize_dr3d  0.03333
#define __d_textsize_dr3d_ai  0.028

d_pl_name_huddo_ar = [];
if (d_show_pname_hud && {!visibleMap && {isNil "d_is_sat_on"}}) then {
	if (alive player && {!(player getVariable "xr_pluncon")}) then {
		private ["_distu", "_vu", "_targetPos", "_dodraw", "_tex", "_rtex", "_rsize", "_hh", "_opax"];
		[positionCameraToWorld [0,0,0], d_dist_pname_hud, d_show_player_namesx, d_fnc_gethpname, d_fnc_gethpnameai, d_fnc_isplayer, d_fnc_getrankpic] params ["_cam2world", "_d_pn_hud", "_s_p_namesx", "_fnc_ghpn", "_fnc_ghpnai", "_fnc_isp", "_nfc_grp"];
		private _epp = eyePos player;
		{
			_distu = _cam2world distance _x;
			if (_distu <= _d_pn_hud) then {
				_opax = isNull objectParent _x;
				if (!_opax || {[objNull, "VIEW"] checkVisibility [_epp, eyePos _x] > 0.49}) then {
					_dodraw = if (_opax) then {
						_targetPos = _x modelToWorldVisual (_x selectionPosition "Pilot");
						true
					} else {
						_vu = vehicle _x;
						call {
							if (crew _vu isEqualTo 1) exitWith {
								_targetPos = _vu modelToWorldVisual (_x selectionPosition "Pilot");
								true
							};
							if (_x == commander _vu) exitWith {
								_targetPos = _vu modelToWorldVisual (_x selectionPosition "Pilot");
								true
							};
							if (_x == gunner _vu && {!((commander _vu) call _fnc_isp)}) exitWith {
								_targetPos = _vu modelToWorldVisual (_x selectionPosition "Pilot");
								true
							};
							if (_x == driver _vu && {!((commander _vu) call _fnc_isp) && {!((gunner _vu) call _fnc_isp)}}) exitWith {
								_targetPos = _vu modelToWorldVisual (_x selectionPosition "Pilot");
								true
							};
							false
						};
					};
					if (_dodraw) then {
						_rsize = 0.4;
						if (_distu <= 200) then {
							_tex = call {
								if (_s_p_namesx == 1) exitWith {
									[_x] call _fnc_ghpn
								};
								if (_s_p_namesx == 2) exitWith {
									str(9 - round(9 * damage _x))
								};
								""
							};
							if (isNil "_tex") then {_tex = name _x};
							_hh = _x call _nfc_grp;
							_rtex = _hh # 0;
							_rsize = _hh # 1;
						} else {
							_tex = "*";
							_rtex = "#(argb,8,8,3)color(0,0,0,0)";
						};
						d_pl_name_huddo_ar pushBack [_rtex, [[1, 1, 1, 0.8], [0, 1, 0, 0.9]] select (group _x == group player), _targetPos vectorAdd [0, 0, 0.2 + (_distu / 15) / 1.5], _rsize, _rsize, 0, _tex, 1, __d_textsize_dr3d, "RobotoCondensed"]; //PuristaSemibold PuristaMedium
					};
				};
			};
		} forEach (d_allplayers select {alive _x && {_x != player && {!(_x getVariable "xr_pluncon") && {isNil {_x getVariable "xr_plno3dd"}}}}});
		if (d_with_ai) then {
			{
				_distu = _cam2world distance _x;
				if (_distu <= _d_pn_hud) then {
					if ([objNull, "VIEW"] checkVisibility [_epp, eyePos _x] > 0) then {
						_targetPos = _x modelToWorldVisual (_x selectionPosition "Pilot");
						if (_distu <= 200) then {
							_tex = call {
								if (_s_p_namesx == 1) exitWith {
									[_x] call _fnc_ghpnai
								};
								if (_s_p_namesx == 2) exitWith {
									str(9 - round(9 * damage _x))
								};
								""
							};
						} else {
							_tex = "*";
						};
						d_pl_name_huddo_ar pushBack ["#(argb,8,8,3)color(0,0,0,0)", [[1, 1, 1, 0.8], [0, 1, 0, 0.9]] select (group _x == group player), _targetPos vectorAdd [0, 0, 0.2 + (_distu / 15) / 1.5], 0.4, 0.4, 0, _tex, 1, __d_textsize_dr3d_ai, "RobotoCondensed"]; //PuristaSemibold PuristaMedium
					};
				};
			} forEach (d_allplayerai select {alive _x && {isNull objectParent _x}});
		};
	};
} else {
	if (!d_show_pname_hud) then {
		removeMissionEventHandler ["Draw3D", d_phudraw3d];
		d_pl_name_huddo_ar = [];
		d_phudraw3d = -1;
	};
};
