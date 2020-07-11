// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spectdraw3d.sqf"
#include "..\x_macros.sqf"

#define __d_textsize_dr3d  0.03333

private ["_distu", "_vu", "_targetPos", "_dodraw", "_tex", "_rtex", "_rsize", "_hh"];
[positionCameraToWorld [0,0,0], d_dist_pname_hud, d_fnc_isplayer, d_fnc_gethpname, d_fnc_getrankpic, d_fnc_getplayername] params ["_cam2world", "_d_pn_hud", "_fnc_ispl", "_fnc_ghpn", "_fnc_grp", "_fnc_gpn"];
{
	_distu = _cam2world distance _x;
	if (_distu <= _d_pn_hud) then {
		_vu = vehicle _x;
		_targetPos = _vu modelToWorldVisual (_x selectionPosition "Head");
		if !(_targetPos isEqualTo []) then {
			_dodraw = if (isNull objectParent _x) then {
				true
			} else {
				call {
					if (crew _vu isEqualTo 1) exitWith {true};
					if (_x == commander _vu) exitWith {true};
					if (_x == gunner _vu && {!((commander _vu) call _fnc_ispl)}) exitWith {true};
					if (_x == driver _vu && {!((commander _vu) call _fnc_ispl) && {!((gunner _vu) call _fnc_ispl)}}) exitWith {true};
					false
				};
			};
			if (_dodraw) then {
				_rsize = 0.4;
				if (_distu <= 200) then {
					_tex = [_x] call _fnc_ghpn;
					__TRACE_1("1","_tex")
					if (isNil "_tex") then {_tex = _x call _fnc_gpn};
					__TRACE_1("2","_tex")
					_hh = _x call _fnc_grp;
					__TRACE_1("","_hh")
					_rtex = _hh # 0;
					_rsize = _hh # 1;
				} else {
					_tex = "*";
					_rtex = "#(argb,8,8,3)color(0,0,0,0)";
				};
				drawIcon3D [_rtex, [[1, 1, 1, 0.8], [0, 1, 0, 0.9]] select (group _x == group player), _targetPos vectorAdd [0, 0, 0.4 + (_distu / 15) / 1.5], _rsize, _rsize, 0, _tex, 1, __d_textsize_dr3d, "RobotoCondensed"]; // PuristaSemibold PuristaMedium
			};
		};
	};
} forEach (d_allplayers select {alive _x && {!(_x getVariable ["xr_pluncon", false])}});